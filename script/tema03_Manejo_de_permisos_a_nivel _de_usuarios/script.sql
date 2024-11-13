USE proyecto_bd;

--Check tipo de Autenticación
DECLARE @LoginMode INT;
EXEC xp_instance_regread
    N'HKEY_LOCAL_MACHINE',
    N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer',
    N'LoginMode',
    @LoginMode OUTPUT;

SELECT CASE
         WHEN @LoginMode = 1 THEN 'Autenticación de Windows'
         WHEN @LoginMode = 2 THEN 'Autenticación Mixta'
         ELSE 'Desconocido'
       END AS ModoAutenticacion;



--Permisos a nivel de usuarios:

--1)
-- Crear dos usuarios de base de datos.
-- Se crean dos usuarios, uno con privilegios de administrador y
-- otro con permisos limitados, para observar cómo se comportan en función de los permisos asignados.

 -- Crea el login a nivel de servidor
--CREATE LOGIN UsuarioAdmin WITH PASSWORD = 'admin123'; --Falla por no cumplir las politicas para una password abajo estan detalladas.
  CREATE LOGIN UsuarioAdmin WITH PASSWORD = 'Admin12!'

 -- Crea el usuario en la base de datos seleccionada (EN ESTE CASO LA DEL PROYECTO CON LA SENTENCIA USE [BD])
CREATE USER UsuarioAdmin FOR LOGIN UsuarioAdmin;

--Un LOGIN puede estas asociado a mas de un USER en distintas BD
-- Login sin Usuario: El login existe y puede autenticarse en el servidor, pero no puede acceder a bases de datos hasta que se le asocie un usuario.
-- Usuario sin Login: El usuario se crea en la base de datos, pero no podrá autenticarse ni realizar ninguna acción, ya que no hay un login asociado que permita el acceso al servidor

-- Requisitos de Complejidad de Contraseña
-- Longitud Mínima: La contraseña debe tener al menos 8 caracteres de longitud.
--
-- Conjuntos de Caracteres: La contraseña debe incluir caracteres de al menos tres de los siguientes cuatro conjuntos:
--
-- Letras Mayúsculas: (A-Z)
-- Letras Minúsculas: (a-z)
-- Dígitos: (0-9)
-- Símbolos: (por ejemplo, !@#$%^&*()-_+=<>?)
-- Ejemplo de Contraseñas Válidas
-- Password1! (Mayúsculas, minúsculas, dígitos y símbolo)
-- MySecurePassword123! (Mayúsculas, minúsculas y dígitos)
-- !Complex1Pass (Mayúsculas, minúsculas, dígitos y símbolo)


CREATE LOGIN UsuarioLectura WITH PASSWORD = 'lectura123!';
CREATE USER UsuarioLectura FOR LOGIN UsuarioLectura;

-- 2)
-- A un usuario darle el permiso de administrador y al otro usuario solo permiso de lectura.
-- Se asignan roles y permisos adecuados a cada usuario, asegurando que el administrador tenga acceso total y el usuario de lectura solo pueda consultar.


EXEC sp_addrolemember 'db_owner', 'UsuarioAdmin'; -- Permiso total
EXEC sp_addrolemember 'db_datareader', 'UsuarioLectura'; -- Solo lectura

-- El comando EXEC sp_addrolemember 'db_owner', 'UsuarioAdmin'; se utiliza en SQL Server para asignar un usuario específico (en este caso, UsuarioAdmin) a un rol de base de datos determinado (db_owner).
--
-- Detalles del Comando
-- sp_addrolemember: Es un procedimiento almacenado del sistema que permite agregar un usuario o grupo a un rol específico en una base de datos.
-- 'db_owner': Este es un rol predefinido en SQL Server que otorga permisos completos sobre la base de datos. Los miembros de este rol pueden realizar cualquier acción dentro de la base de datos, como crear, modificar y eliminar objetos, así como administrar la seguridad de la base de datos.
-- 'UsuarioAdmin': Este es el nombre del usuario que se está agregando al rol db_owner.
-- Permisos del Rol db_owner
-- El rol db_owner tiene los siguientes permisos:
--
-- Control total sobre todos los objetos dentro de la base de datos.
-- Capacidad para ejecutar cualquier comando de Transact-SQL en la base de datos.
-- Permisos para crear y eliminar objetos en la base de datos (tablas, vistas, procedimientos almacenados, etc.).
-- Gestión de permisos de otros usuarios y roles en la base de datos.
-- Acceso a los datos y la capacidad de realizar copias de seguridad y restaurar la base de datos.

--                                                          Roles de Base de Datos (A nivel solo de BD, distinto de servidor)
-- db_owner
--
-- Descripción: Proporciona control total sobre la base de datos.
-- Permisos: Los miembros pueden realizar cualquier acción en la base de datos, incluidos la creación y eliminación de objetos.

-- db_securityadmin
--
-- Descripción: Permite gestionar la seguridad de la base de datos.
-- Permisos: Pueden modificar permisos y roles en la base de datos.

-- db_accessadmin
--
-- Descripción: Permite gestionar el acceso a la base de datos.
-- Permisos: Pueden añadir o quitar usuarios de la base de datos.

-- db_backupoperator
--
-- Descripción: Permite realizar copias de seguridad de la base de datos.
-- Permisos: Pueden ejecutar copias de seguridad de la base de datos.

-- db_datareader
--
-- Descripción: Permite la lectura de datos de todas las tablas de la base de datos.
-- Permisos: Pueden consultar datos en todas las tablas.

-- db_datawriter
--
-- Descripción: Permite la escritura de datos en todas las tablas de la base de datos.
-- Permisos: Pueden insertar, actualizar y eliminar datos en todas las tablas.

-- db_ddladmin
--
-- Descripción: Permite la modificación de la estructura de la base de datos.
-- Permisos: Pueden ejecutar comandos DDL (Data Definition Language) para crear y modificar objetos de la base de datos.

-- db_monitor
--
-- Descripción: Permite monitorizar el rendimiento de la base de datos.

--       Diferencias Clave entre db_owner y db_accessadmin
-- Característica	/ db_owner	                / db_accessadmin
-- Permisos de Acceso/	Completos, incluye todo	| Limitados a la administración de acceso
-- Crear Tablas/	Sí                          /	No
-- Modificar Objetos/	Sí                      /	No


-- Al hacer la conexio  con los usuarios nuevos, solo puedo acceder a la base de datos a la cual se creeo el usario y a las del sistema (por defecto)
-- Al hacer los inerts
--  proyecto_bd> insert into dbo.Provincia (nombre_provincia)  values ('Corrientes')
[2024-10-27 19:13:55] [S0005][229] Line 1: The INSERT permission was denied on the object 'Provincia', database 'proyecto_bd', schema 'dbo'.
proyecto_bd> select * from dbo.Provincia
[2024-10-27 19:14
:05] 0 rows retrieved in 65 ms (execution: 39 ms, fetching: 26 ms)

                       proyecto_bd> insert into dbo.Provincia (nombre_provincia)  values ('Corrientes')
proyecto_bd> insert into dbo.Provincia (nombre_provincia)  values ('Corrientes')
[2024-10-28 23:00:28] 1 row affected in 297 ms


-- ALTA
--procedimiento para agregar un nuevo inspector
--WRITE
CREATE PROCEDURE proc_AgregarInspector
    @nombre_inspector VARCHAR(200),
    @apellido_inspector VARCHAR(200),
    @dni_inspector INT,
    @telefono_inspector INT,
    @correo_inspector VARCHAR(200),
    @fecha_nacimiento DATE,
    @salario DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Inspector (nombre_inspector, apellido_inspector, dni_inspector, telefono_inspector, correo_inspector, fecha_nacimiento, salario)
    VALUES (@nombre_inspector, @apellido_inspector, @dni_inspector, @telefono_inspector, @correo_inspector, @fecha_nacimiento, @salario);
END;


--READ
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

CREATE FUNCTION ContarProyectosEnCorrientes2()
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

-- EJECUTAR PROCEDIMIENTO (ContarInspeccionesPendientes) QUE LEE CON EL USUARIO ADMIN
proyecto_bd> SELECT * FROM dbo.ContarInspeccionesPendientes()
[2024-10-27 21:53:26] 0 rows retrieved in 36 ms (execution: 9 ms, fetching: 27 ms)
-- EJECUTAR PROCEDIMIENTO (ContarInspeccionesPendientes) QUE LEE CON EL USUARIO DE LECTURA
proyecto_bd> SELECT * FROM dbo.ContarInspeccionesPendientes()
[2024-10-27 21:53:26] 0 rows retrieved in 36 ms (execution: 9 ms, fetching: 27 ms)
--Concluimos que al tratarse de una sentencia que solo lee y como ambos tienen permisos para hacerlo, la consulta es exitosa.


-- EJECUTAR PROCEDIMIENTO (proc_AgregarInspector) QUE ESCRIBE CON EL USUARIO ADMIN
proyecto_bd> EXEC proc_AgregarInspector 'Lucas', 'Cabrera', 43108457, 37940283, 'juan.perez@example.com', '1970-01-01', 3000.00
[2024-10-27 21:58:05] 1 row affected in 87 ms

--Observamos que efectivamente inserte un inspector
proyecto_bd> select * from dbo.Inspector
[2024-10-27 22:00:05] 1 row retrieved starting from 1 in 45 ms (execution: 7 ms, fetching: 38 ms)

-- EJECUTAR PROCEDIMIENTO (proc_AgregarInspector) QUE ESCRIBE CON EL USUARIO DE LECTURA
proyecto_bd> EXEC proc_AgregarInspector 'Lucas', 'Cabrera', 43108457, 37940283, 'juan.perez@example.com', '1970-01-01', 3000.00
[2024-10-27 22:00:40] [S0005][229] Line 1: The EXECUTE permission was denied on the object 'proc_AgregarInspector', database 'proyecto_bd', schema 'dbo'.

--Observamos que el usuario al no tener permisos para escribir arroja un error
--La unica manera de que el usuario de lectura pueda ejecutar el procedimiento, es si le damos permisos de la siguiente manera:
GRANT EXECUTE ON proc_AgregarInspector TO UsuarioLectura;
--Entonces ahora ..
proyecto_bd> EXEC proc_AgregarInspector 'Franco', 'Cabrera', 43103457, 37940283, 'juan2.perez@example.com', '1970-01-01', 3000.00
[2024-10-27 22:04:33] 1 row affected in 38 ms

--Observamos que efectivamente inserte un segundo inspector
proyecto_bd> select * from dbo.Inspector
[2024-10-27 22:00:05] 2 row retrieved starting from 1 in 45 ms (execution: 7 ms, fetching: 38 ms)

--Ahora si hacemos los inserts sobre la tabla inspector con el usuario admin :
proyecto_bd> insert into dbo.Inspector(nombre_inspector, apellido_inspector, dni_inspector, telefono_inspector, correo_inspector, fecha_nacimiento, salario) values(
 'Feder', 'Cabreros', 43008457, 37940283, 'juan.perez@examp2le.com', '1970-01-01', 3000.00                                                                                                                                                                  )
[2024-10-27 22:09:15] 1 row affected in 25 ms

--Lo inserta correctamente, sin embargo desde el usuario de lectura:
proyecto_bd> insert into dbo.Inspector(nombre_inspector, apellido_inspector, dni_inspector, telefono_inspector, correo_inspector, fecha_nacimiento, salario) values ('Feder','Cabreros',43008457,37940283, 'juan.perez@examp2le.com','1970-01-01', 3000.00)
[2024-10-27 22:10:45] [S0005][229] Line 1: The INSERT permission was denied on the object 'Inspector', database 'proyecto_bd', schema 'dbo'.

--Obtenemos el siguiente error, entonces la unica manera de hacerlo es atraves del procedimiento:




--Permisos a nivel de roles del DBMS:
--Crear dos usuarios de base de datos.
CREATE LOGIN PruebaRol1 WITH PASSWORD = 'PruebaRol1!'
CREATE USER PruebaRolUno FOR LOGIN PruebaRol1;

CREATE LOGIN PruebaRol2 WITH PASSWORD = 'PruebaRol2!';
CREATE USER PruebaRolDos FOR LOGIN PruebaRol2;

--Crear un rol que solo permita la lectura de alguna de las tablas creadas.
    CREATE ROLE LecturaRol;

-- Este comando crea un rol en la base de datos llamado LecturaRol.
-- Los roles en SQL Server sirven para agrupar permisos de manera que puedan aplicarse de forma consistente a varios usuarios.
-- Esto facilita la gestión de permisos, ya que, en lugar de asignar permisos individualmente a cada usuario, puedes asignarlos a un rol y luego agregar usuarios a ese rol.
    GRANT SELECT ON Inspector TO LecturaRol;
-- Este comando otorga el permiso de SELECT (lectura) sobre la tabla TablaEjemplo al rol LecturaRol.
-- SELECT permite a los usuarios miembros de este rol realizar consultas de lectura en la tabla TablaEjemplo, pero no modificar los datos.

--     Darle permiso a uno de los usuarios sobre el rol creado anteriormente.
EXEC sp_addrolemember 'LecturaRol', 'PruebaRolUno';
-- sp_addrolemember: Es un procedimiento almacenado en SQL Server que se usa para agregar un usuario a un rol de base de datos.
-- 'LecturaRol': Es el nombre del rol en el cual estás agregando el usuario.
-- 'NombreUsuario': Es el nombre del usuario de la base de datos que estás agregando al rol.

-- Verificar el comportamiento de ambos usuarios (el que tiene permiso sobre el rol y el que no tiene), cuando intentan leer el contenido de la tabla
--Al ejecutar un select * de la tabla Inspecto con el usuario que tiene el rol de lectura sucede lo siguiente:
proyecto_bd> SELECT * FROM dbo.Inspector
[2024-10-27 22:30:16] 3 rows retrieved starting from 1 in 44 ms (execution: 11 ms, fetching: 33 ms)

--Se obtienen todos los inspectores, hay que mencionar que las unicas tablas que mi db managment me permite visualizar son aquellos para los cuales el rol tiene acceso
--No se me permite ni ejecutar o visualizar las otras tablas

--Al ejecutar un select * de la tabla Inspecto con el usuario que tiene No tiene Rol sucede lo siguiente:
--No es posible ejecutar un comando ya que en db managment no reconoce la tabla y al ejecutar la query..
proyecto_bd> select * from dbo.Inspector
[2024-10-27 22:34:16] [S0005][229] Line 1: The SELECT permission was denied on the object 'Inspector', database 'proyecto_bd', schema 'dbo'.

-- Si ejecutamos un
GRANT SELECT dbo.ContarInspeccionesPendientes TO PruebaRolUno;

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
GRANT EXECUTE ON dbo.ContarInspectoresMayores30 TO PruebaRolUno;
GRANT EXECUTE ON dbo.ContarProyectosEnCorrientes TO PruebaRolUno;
