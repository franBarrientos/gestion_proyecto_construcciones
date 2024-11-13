use proyecto_bd;



-- procedimiento de tipo DML (Data Manipulation Language)
--realiza la insercion de nuevos inspectores dentro de la tabla de inspector
-- ALTA
--procedimiento para agregar un nuevo inspector
--Recibe parametros de entrada los datos del inspector:
--nombre,apellido,dni,telefono,correo, fecha_nacimiento y salario
--luego realiza la insercion dentro de un bloque de codigo BEGIN END realiza una insercion mediante la instruccion select
CREATE PROCEDURE proc_AgregarInspector
    @nombre_inspector VARCHAR(200),
    @apellido_inspector VARCHAR(200),
    @dni_inspector INT,
    @telefono_inspector varchar(10),
    @correo_inspector VARCHAR(200),
    @fecha_nacimiento DATE,
   @salario DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Inspector (nombre_inspector, apellido_inspector, dni_inspector, telefono_inspector, correo_inspector, fecha_nacimiento, salario)
    VALUES (@nombre_inspector, @apellido_inspector, @dni_inspector, @telefono_inspector, @correo_inspector, @fecha_nacimiento, @salario);
END;


--modifico el tipo de dato de la columna telefono a varchar
alter table Inspector alter column telefono_inspector varchar(10);

--llamo a la funcion para ejecutarla y paso los parametros que deseo insertar
EXEC proc_AgregarInspector 'pedro', 'Cabrera', 43108455, '3794028322', 'juan.perez@example.com', '1970-01-01', 3000.00;

EXEC proc_AgregarInspector 'juan', 'Ramirez', 45111333, '37940000123', 'ramirez@example.com', '1970-01-01', 3000.00;

--Procedimiento almacenado que permite la modificacion de la tabla inspector
--Realiza un aumento del 45% a los inspectores que tienen una edad mayor a 50 años
--dentro del bloque BEGIN END se encuentra una instruccion update que modifica el salario de los inspectores

CREATE PROCEDURE proc_AumentarSalario
AS
BEGIN
    UPDATE Inspector
    SET salario = salario * 1.45
    WHERE DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) > 50;
END;

--Llama al procedimiento almacenado, una vez ejecutado la columna de salario se modificara
EXEC proc_AumentarSalario;

--Procedimiento almacenado que realiza una eliminacion fisica de Inspectores que no poseen una inspeccion asignada
--Dentro del bloque de codigo BEGIN END, realiza una busqueda con la instruccion not exists.
--En caso de no encontrarse dicho inspector en la tabla inspecciones se eliminara dicho inspector
-- eliminar los inspectores que no tengan una inspeccion asignada
CREATE PROCEDURE proc_EliminarInspectoresSinInspecciones
AS
BEGIN
    DELETE FROM Inspector 
    WHERE  not exists (SELECT null FROM Inspecciones s where s.id_inspector = id_inspector);
END;

select * from Inspector i
where not exists (SELECT null FROM Inspecciones s where s.id_inspector = i.id_inspector);

--ejecuto el procedimiento almacenado para eliminar inspectores sin inspeccion
EXEC proc_EliminarInspectoresSinInspecciones;

-----------------------------------------------------------------FUNCIONES ALMACENADAS--------------------------------------


--contar cuantas inspecciones estan pendientes y a que proyectos (nombre) pertenecen

--funcion que permite contar de la tablas inspecciones se encuentran con estado 'pendiente'
--la funcion permite retornar una tabla, en lugar de devolver un valor unico
--La tabla que devuelve, es una tabla agrupada por el nombre de proyecto y la cantidad de inspecciones que tiene dicho proyecto
--que tiene en estado pendiente

CREATE FUNCTION ContarInspeccionesPendientes()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.Nombre_proyecto,
        COUNT(*) AS InspeccionesPendientes
    FROM Inspecciones i
    JOIN Proyectos p ON i.nro_proyecto = p.nro_proyecto
    WHERE i.estado_inspeccion = 'Pendiente'
    GROUP BY p.Nombre_proyecto
);

--ejecuto la funcion contar inspeccionesp pendientes
SELECT * FROM dbo.ContarInspeccionesPendientes();

-- Funcion que devuelve un valor unico, lo que permite contar cuantos inspectores son mayores a 30
--Declaro una variable contar_may30 donde se va almacenar la cantidad y luego retorno la cantidad
CREATE FUNCTION ContarInspectoresMayores30()
RETURNS INT
AS
BEGIN
    DECLARE @contar_may30 INT;

    SELECT @contar_may30 = COUNT(*)
    FROM Inspector
    WHERE DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) > 30;

    RETURN @contar_may30;
END;

--ejecuto la funcion que devuelve la cantidad de inspectores mayores de edad
SELECT dbo.ContarInspectoresMayores30() as cantidad_mayores_30;

---Funcion que cuenta los inspectores con un salario superior a 3000
CREATE FUNCTION ContarInspectoresConSalarioSuperior()
RETURNS INT
AS
BEGIN
    DECLARE @contar_may30 INT;

    SELECT @contar_may30 = COUNT(*)
    FROM Inspector i
    WHERE i.salario > 3000;

    RETURN @contar_may30;
END;

SELECT dbo.ContarInspectoresConSalarioSuperior() as Inspectores_con_salarioSuperior;




--------------------Procedimiento almacenado con parametros externos
--Procedimiento almacenado que recibe parametros externos.
--permite ingresar nuevos proyectos, mediante el ingreso de parametros externos
--Creamos el procedimiento y definimos los parametros que debe recibir

CREATE PROCEDURE InsertarProyecto
    @cantidad_proyecto INT, @Nombre_proyecto VARCHAR(200), @fecha_inicio_proyecto DATE, @fecha_fin_proyecto DATE,
    @id_contrataciones INT,@id_localidad INT,@id_constructora INT,@id_tipoconstruccion INT
AS
BEGIN
    -- controla si existe la clave foranea tipo_contrataciones, en caso de no existir devuelve un mensaje
    IF NOT EXISTS (SELECT null FROM Tipo_contrataciones WHERE id_contrataciones = @id_contrataciones)
    BEGIN
        PRINT 'No existe el id_contrataciones.';
        RETURN;
    END
	--controla si existe la clave foranea id_localidad, en caso de no existir devuelve un mensaje 
    IF NOT EXISTS (SELECT null FROM Localidad WHERE id_localidad = @id_localidad)
    BEGIN
        PRINT 'No existe el id_localidad.';
        RETURN;
    END

	--controla si existe la clave foranea id_constructora, en caso de no existir devuelve un mensaje
    IF NOT EXISTS (SELECT null FROM Empresa_constructora WHERE id_constructora = @id_constructora)
    BEGIN
        PRINT 'No existe el id_constructora.';
        RETURN;
    END

	--controla si existe la clave foranea id_tipoconstruccion, en caso de no existir devuelve un mensaje
    IF NOT EXISTS (SELECT null FROM Tipo_construccion WHERE id_tipoconstruccion = @id_tipoconstruccion)
    BEGIN
        PRINT 'No existe el id_tipoconstruccion.';
        RETURN;
    END

    --una vez que salto todas las verificaciones, permite ingresar los datos a la tabla de proyecto
    INSERT INTO Proyectos (cantidad_proyecto, Nombre_proyecto, fecha_inicio_proyecto, fecha_fin_proyecto, 
                           id_contrataciones, id_localidad, id_constructora, id_tipoconstruccion)
    VALUES (@cantidad_proyecto, @Nombre_proyecto, @fecha_inicio_proyecto, @fecha_fin_proyecto, 
            @id_contrataciones, @id_localidad, @id_constructora, @id_tipoconstruccion);

    --devuelve el mensaje de que se ha insertado correctamente
    PRINT 'Nuevo proyecto ingresado correctamente.';
END;


--ejecuto el procedimiento y les paso los parametros externos
EXEC InsertarProyecto
    @cantidad_proyecto = 100,--cantidad de proyectos
    @Nombre_proyecto = 'Proyecto de Construcción A', --nombre del proyecto
    @fecha_inicio_proyecto = '2024-01-01',--fecha de inicio del proyecto
    @fecha_fin_proyecto = '2025-01-01',--fecha de fin del proyecto
    @id_contrataciones = 1, --clave foranea
    @id_localidad = 2,--clave foranea
    @id_constructora = 3, --clave foranea
    @id_tipoconstruccion = 3; --clave foranea
	



	   INSERT INTO Proyectos (cantidad_proyecto, Nombre_proyecto, fecha_inicio_proyecto, fecha_fin_proyecto, 
                           id_contrataciones, id_localidad, id_constructora, id_tipoconstruccion)
    VALUES (20, 'Prueba', '2023-10-12','2026-11-2', 
            1, 2, 2, 3);


-----------------------------------------COMPARACION----------------------------- 
SET STATISTICS TIME ON;		 
SET STATISTICS IO ON;
DECLARE @contar_may30 INT;
  SELECT  @contar_may30 = COUNT(*)
    FROM Inspector i
    WHERE i.salario > 3000;


SET STATISTICS TIME OFF;		 
SET STATISTICS IO OFF;


SET STATISTICS TIME ON;		 
SET STATISTICS IO ON;
SELECT dbo.ContarInspectoresConSalarioSuperior() as Inspectores_con_salarioSuperior;
SET STATISTICS TIME OFF;		 
SET STATISTICS IO OFF;



SET STATISTICS TIME ON;		 
SET STATISTICS IO ON;
 UPDATE Inspector
    SET salario = salario * 1.45
    WHERE DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) > 50;
SET STATISTICS TIME OFF;		 
SET STATISTICS IO OFF;



SET STATISTICS TIME ON;		 
SET STATISTICS IO ON;
	EXEC proc_AumentarSalario;
SET STATISTICS TIME OFF;		 
SET STATISTICS IO OFF;
