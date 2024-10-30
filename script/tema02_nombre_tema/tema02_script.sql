use proyecto_bd;

select * from Inspector i
where datediff(year,i.fecha_nacimiento, GETDATE()) > 50 

-- ALTA
--procedimiento para agregar un nuevo inspector
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

DROP PROCEDURE proc_AgregarInspector;
alter table Inspector alter column telefono_inspector varchar(10);

EXEC proc_AgregarInspector 'Lucas', 'Cabrera', 43108457, '3794028322', 'juan.perez@example.com', '1970-01-01', 3000.00;

--MODIFICACION
-- REALIZAR UN AUMENTO DEL 45% DEL SALARIO A LOS INSPECTORES QUE TENGAN UNA EDAD MAYOR A 50 AÑOS 
CREATE PROCEDURE proc_AumentarSalario
AS
BEGIN
    UPDATE Inspector
    SET salario = salario * 1.45
    WHERE DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) > 50;
END;

EXEC proc_AumentarSalario;

--BAJA
-- eliminar los inspectores que no tengan una inspeccion asignada
CREATE PROCEDURE proc_EliminarInspectoresSinInspecciones
AS
BEGIN
    DELETE FROM Inspector 
    WHERE  not exists (SELECT null FROM Inspecciones s where s.id_inspector = id_inspector);
END;

select * from Inspector i
where not exists (SELECT null FROM Inspecciones s where s.id_inspector = i.id_inspector);
EXEC proc_EliminarInspectoresSinInspecciones;

-----------------------------------------------------------------FUNCIONES ALMACENADAS--------------------------------------
--contar cuantos proyectos tienen un cierto tipo de contrataciones
CREATE FUNCTION ContarProyectosPorTipoContratacion
(
    @id_contratacion INT
)
RETURNS INT
AS
BEGIN
    DECLARE @count INT;

    SELECT @count = COUNT(*)
    FROM Proyectos
    WHERE id_contrataciones = @id_contratacion;

    RETURN @count;
END;

SELECT dbo.ContarProyectosPorTipoContratacion(4);

--contar cuantas inspecciones estan pendientes y a que proyectos (nombre) pertenecen
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

SELECT * FROM dbo.ContarInspeccionesPendientes();

--contar cuantos inspectores son mayores de 30 años
CREATE FUNCTION ContarInspectoresMayores30()
RETURNS INT
AS
BEGIN
    DECLARE @count INT;

    SELECT @count = COUNT(*)
    FROM Inspector
    WHERE DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) > 30;

    RETURN @count;
END;
SELECT dbo.ContarInspectoresMayores30();


--contar los proyectos que se realizan en la provincia de corrientes
CREATE FUNCTION ContarProyectosEnCorrientes()
RETURNS INT
AS
BEGIN
    DECLARE @count INT;

    SELECT @count = COUNT(*)
    FROM Proyectos p
    JOIN Localidad l ON p.id_localidad = l.id_localidad
    WHERE l.nombre_localidad = 'Corrientes';

    RETURN @count;
END;

SELECT dbo.ContarProyectosEnCorrientes();
