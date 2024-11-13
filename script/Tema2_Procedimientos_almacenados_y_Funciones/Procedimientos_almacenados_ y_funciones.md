# Procedimiento almacenados y Funciones almacenadas

# INTROODUCCION
En  SQL-server los procedimientos almacenados son utilizados para realizar tareas similares a los procedimientos de otros lenguajes de programación, como realizar cálculos que devuelvan uno o múltiples resultados, realizar procesos complejos como actualizar, eliminar o actualizar datos en la base de datos. Es decir, que un procedimiento puede ser utilizado para modificar la estructura de datos, manejar transacciones, agrupar múltiples sentencias entre otras tareas.

Las Funciones en SQL server son conjuntos de instrucciones SQL que se utilizan para ejecutar tareas específicas. Funcionan como funciones matemáticas, en el cual reciben un conjunto de entradas y devuelven un conjunto de salidas.
A su vez, permiten replicar tareas en otros sectores del código, es decir que pueden ser llamadas en un WHERE o un SELECT, para simplificar tareas. Por ende no tendrá que replicar scripts, con la simple utilización de funciones.

En resumen, una función siempre devuelve un resultado, a diferencia de un procedimiento que puede o no devolver un resultado y además modificar la estructura de datos.

# ¿QUE ES UN PROCEDIMINETO ALMACENADO?
Un procedimiento almacenado en SQL Server es un bloque de instrucciones Transact-SQL que se pueden llamar desde otras consultas o procedimientos almacenados. Se trata de un código SQL preparado que se puede guardar de modo que el código se pueda reutilizar una y otra vez.

# SINTAXIS

```
CREATE [ OR ALTER ] { PROC | PROCEDURE }
    [schema_name.] procedure_name [ ; number ]
    [ { @parameter_name [ type_schema_name. ] data_type }
        [ VARYING ] [ NULL ] [ = default ] [ OUT | OUTPUT | [READONLY]
    ] [ ,...n ]
[ WITH <procedure_option> [ ,...n ] ]
[ FOR REPLICATION ]
AS { [ BEGIN ] sql_statement [;] [ ...n ] [ END ] }
[;]
```

# EJECUTAR UN PROCEDIMIENTO ALMACENADO

1.  Conexión a la Base de Datos Debes estar conectado a la base de datos donde se encuentra el procedimiento almacenado.
2. Conocer el Nombre del Procedimiento Debes conocer el nombre exacto del procedimiento almacenado que deseas ejecutar.
3. Parámetros (si es necesario) Si el procedimiento requiere parámetros de entrada, debes conocer sus tipos y el orden en que se deben pasar. 
4. Sintaxis para Ejecutar el Procedimiento La forma básica de ejecutar un procedimiento almacenado es utilizando la instrucción EXEC o EXECUTE.

   
# ALMACENAMIENTO Y MODIFICACION DE UN PROCEDIMIENTO ALMACENADO

Los procedimientos almacenados como los definidos por el usuario, una vez ejecutados serán almacenados en la carpeta de Procedimientos Almacenados/Procedimientos almacenados del sistema. A su vez un procedimiento almacenado puede ser modificado, para ello deberemos ir al buscador de objetos, buscamos el procedimiento que queremos modificar, realizamos los cambios necesarios en el procedimiento y luego lo ejecutamos para guardar los cambios.

# LLAMADA DE PROCEDIMIENTO ALMACENADO

Para llamar a un procedimiento almacenado utilizamos la palabra reservada call.

# VENTAJAS DE PROCEDIMIENTOS ALMACENADOS
1. Que se realicen cálculos o procesos complejos y se devuelvan múltiples resultados al contexto que hizo la llamada. 

2. Contener instrucciones de programación que realicen operaciones en la base de datos, incluidas las llamadas a otros procedimientos.

3. Agrupan múltiples sentencias SQL en un solo bloque, lo que facilita su ejecución y reutilización.

4. Facilitan el mantenimiento del código, ya que cualquier cambio en la lógica se puede hacer en el procedimiento sin afectar a la aplicación, es decir, permite la reutilización de código.

5. Los procedimientos controlan lo que los usuarios pueden hacer, lo que protege la base de datos, lo que protege la base de datos sin que puedan alterarla. El procedimiento almacenado funciona como una barrera que actúa como protector de datos. Dentro del procedimiento, se definen qué operaciones puede el usuario  ejecutar sobre los objetos de la base de datos.

6. Permite reducir el tráfico de red, debido a que las instrucciones se ejecutan en el servidor de la base de datos, debido a que el procedimiento si realiza múltiples operaciones reduce la cantidad de datos enviados entre el cliente y el servidor.

# TIPOS DE PROCEDIMIENTOS ALMACENADOS
1. Procediminetos almacenados del sistema: son procedimientos que incluye el SQL server, que como su nombre lo dicen son procedimientos que se encuentran almacenado en el sistema. Comienzan o suelen comenzar con el prefijo SP_ y son muy utiles para realizar tareas de administracion o de consulta de informacion al sistema ejemplo:
   ```sp_help: muestra informacion sobre tablas, vistas y objetos```
    ```sp_who: muestra informacion de usuarios y procesos```
2. Procedimientos almacenados definidos por el usuario: Son procediminetos generados justamente por el usuario, para realizar tareas personalizadas sobre ciertos datos en la base de datos. Pueden incluir parametros, bucles y condiciones.
3. Procedimientos almacenados temporales: los cuales pueden ser locales: comienzan con # y solo estan disponible en la sesion donde se crearon y luego estan los globales: comienzan con ## y estan disponibles para todas las sesiones.
4. Procedimientos almacenados extendidos : permiten ejecutar programas que fueron generados en otros lenguajes de programacion, empiezan con el prefijo xp_. Actualmente no se los utiliza mucho debido a problemas que pueden generar en temas de seguridad.

# ALGUNOS PROCEDIMIENTOS DEFINIDOS

 Procedimiento almacenado que permite el ingreso de datos de un inspector. Recibe parametros de entrada los datos del inspector: nombre,apellido,dni,telefono,correo, fecha_nacimiento y salario.
 Luego de recibir los parametros permite cargar en la tabla.
 ```
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
```
Para ejecutar este procedimiento requiere de la siguente instruccion:
```EXEC proc_AgregarInspector 'pedro', 'Cabrera', 43108455, '3794028322', 'juan.perez@example.com', '1970-01-01', 3000.00;```

Procedimiento con un Update:
Permite modificar el salario de los inspectores que tienen una edad mayor a 50 años. Es un procedimiento sencillo con un bloque BEGIN END, que consulta la edad de todos los inspectores y aquellos que tengan una edad superior a 50 se le asigna un aumento de salario.
```
CREATE PROCEDURE proc_AumentarSalario
AS
BEGIN
    UPDATE Inspector
    SET salario = salario * 1.45
    WHERE DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) > 50;
END;
```
Con esta instruccion se ejecuta la funcion aumento de salario
```EXEC proc_AumentarSalario;```

Procedimiento con un delete:
permite eliminar aquellos inspectores que no se encuentran en la tabla inspecciones
```
CREATE PROCEDURE proc_EliminarInspectoresSinInspecciones
AS
BEGIN
    DELETE FROM Inspector 
    WHERE  not exists (SELECT null FROM Inspecciones s where s.id_inspector = id_inspector);
END;
 ```
Para ejecutar este procedimiento se utiliza la siguiente instruccion:

 ```EXEC proc_EliminarInspectoresSinInspecciones; ```

# FUNCIONES

# ¿QUE ES UNA FUNCION ALMACENADA?

Una Función Almacenada o función definida por el usuario es un conjunto de instrucciones SQL que se almacena asociado a una base de datos. Es un objeto que se crea con la sentencia CREATE FUNCTION y se invoca con la sentencia SELECT o dentro de una expresión. Una función debe devolver un determinado valor, a diferencia de un procedimiento almacenado, que puede o no devolver un valor. Como también pueden ser utilizadas en consultas SQL.

# SINTAXIS
```
CREATE [ OR ALTER ] FUNCTION [ schema_name. ] function_name
( [ { @parameter_name [ AS ] [ type_schema_name. ] parameter_data_type [ NULL ]
 [ = default ] [ READONLY ] }
    [ , ...n ]
  ]
)
RETURNS return_data_type
    [ WITH <function_option> [ , ...n ] ]
    [ AS ]
    BEGIN
        function_body
        RETURN scalar_expression
    END
[ ; ]
```

# EJECUCION DE FUNCIONES

Una función se ejecuta con la palabra reservada Select siguiendo obligatoriamente el esquema, en  caso de que se este trabajando con el esquema por defecto (dbo.), colocarse obligatoriamente luego siguiendo f_nombre_funcion (@parametrod);
En caso de no incluir el esquema lanzará el siguiente error:
El mensaje 195, Nivel 15, Estado 10, Línea 20 ‘f_nombre_funcion’ no es un nombre de función incorporado reconocido

# VENTAJAS DE FUNCIONES ALMACENADAS 

1. Reutilización de código donde las funciones almacenadas permiten encapsular lógica que puede ser reutilizada en múltiples consultas o procedimientos.

2. Mejora del rendimiento debido a que están almacenadas en el servidor y ser compiladas previamente, las funciones pueden ejecutar consultas complejas.

3. Seguridad se puede otorgar permisos para ejecutar funciones específicas sin dar acceso directo a las tablas subyacentes a distintos usuarios. 

4. Facilidad de mantenimiento si se necesita realizar un cambio en la lógica de negocio, solo tienes que modificar la función almacenada.

5. Modularidad debido a que se puede dividir la lógica compleja en funciones más pequeñas y específicas, lo que mejora la organización y legibilidad del código.

# ALMACENAMIENTO DE FUNCIONES ALMACENADAS DEFINIDAS POR EL USUARIO

Las funciones definidas por el usuario se almacenan en la siguiente carpeta de Funciones y dependiendo del tipo de función se almacenarán en las carpetas : Funciones con valores de tablas, Funciones escalares, Funciones de agregado.

#TIPOS DE FUNCIONES ALMACENADAS 
1. Funciones escalares: son funciones que devuelven un determinado valor ya sea int, varchar, date, etc. Se utilizan para realizar calculos.
2. Funciones de tabla con valores: Estas funciones en lugar de devolver un unico valor, permiten devolver una tabla.  Permiten devolver multiples valores, pero en forma de tabla. Permiten la utilizacion de bloque de codigo.
3. Funciones escalares de fila: estas funciones realuzan calculos o transformaciones en cada fila de manera individual, algunas de ellas son SUBSTRING(),LEN(),GETDATE(),DATEDIFF(),etc.

#FUNCIONES DEFINIDAS

Funciones que permiten realizar algunos calculos sobre las tablas:

Permite contar la cantidad de inspecciones con estado pendiente
```
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
```
Para ejecutar esta funcion se realiza mediante la siguiente sentencia
```SELECT * FROM dbo.ContarInspeccionesPendientes();```

Funcion que permite contar inspectores mayores de 30 años:
```
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
```

Con esta instruccion podemos ejecutar la funcion
```SELECT dbo.ContarInspectoresMayores30() as cantidad_mayores_30;```

Funcion que permite contar inspectores con salarios superior
```
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
```

Para ejecutar la funcion se utiliza esta instruccion:
```SELECT dbo.ContarInspectoresConSalarioSuperior() as Inspectores_con_salarioSuperior;```

# CONCLUSION

Un procedimiento almacenado es útil para realizar transformaciones de los datos en la estructura de la base de datos como actualizar, eliminar o insertar. Mientras que en una función es más adecuada utilizarla cuando queremos realizar cálculos, validaciones o transformaciones dentro de una consulta sin poder realizar modificaciones en la estructura de la base de datos.




