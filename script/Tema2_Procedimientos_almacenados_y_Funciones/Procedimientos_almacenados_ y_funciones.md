# Procedimiento almacenados y Funciones almacenadas

##INTROODUCCION
En  SQL-server los procedimientos almacenados son utilizados para realizar tareas similares a los procedimientos de otros lenguajes de programación, como realizar cálculos que devuelvan uno o múltiples resultados, realizar procesos complejos como actualizar, eliminar o actualizar datos en la base de datos. Es decir, que un procedimiento puede ser utilizado para modificar la estructura de datos, manejar transacciones, agrupar múltiples sentencias entre otras tareas.

Las Funciones en SQL server son conjuntos de instrucciones SQL que se utilizan para ejecutar tareas específicas. Funcionan como funciones matemáticas, en el cual reciben un conjunto de entradas y devuelven un conjunto de salidas.
A su vez, permiten replicar tareas en otros sectores del código, es decir que pueden ser llamadas en un WHERE o un SELECT, para simplificar tareas. Por ende no tendrá que replicar scripts, con la simple utilización de funciones.

En resumen, una función siempre devuelve un resultado, a diferencia de un procedimiento que puede o no devolver un resultado y además modificar la estructura de datos.

##¿QUE ES UN PROCEDIMINETO ALMACENADO?
Un procedimiento almacenado en SQL Server es un bloque de instrucciones Transact-SQL que se pueden llamar desde otras consultas o procedimientos almacenados. Se trata de un código SQL preparado que se puede guardar de modo que el código se pueda reutilizar una y otra vez.

##SINTAXIS
CREATE [ OR ALTER ] { PROC | PROCEDURE }
    [schema_name.] procedure_name [ ; number ]
    [ { @parameter_name [ type_schema_name. ] data_type }
        [ VARYING ] [ NULL ] [ = default ] [ OUT | OUTPUT | [READONLY]
    ] [ ,...n ]
[ WITH <procedure_option> [ ,...n ] ]
[ FOR REPLICATION ]
AS { [ BEGIN ] sql_statement [;] [ ...n ] [ END ] }
[;]

##EJECUTAR UN PROCEDIMIENTO ALMACENADO

1.  Conexión a la Base de Datos Debes estar conectado a la base de datos donde se encuentra el procedimiento almacenado.
2. Conocer el Nombre del Procedimiento Debes conocer el nombre exacto del procedimiento almacenado que deseas ejecutar.
3. Parámetros (si es necesario) Si el procedimiento requiere parámetros de entrada, debes conocer sus tipos y el orden en que se deben pasar. 
4. Sintaxis para Ejecutar el Procedimiento La forma básica de ejecutar un procedimiento almacenado es utilizando la instrucción EXEC o EXECUTE.

   
##ALMACENAMIENTO Y MODIFICACION DE UN PROCEDIMIENTO ALMACENADO

Los procedimientos almacenados como los definidos por el usuario, una vez ejecutados serán almacenados en la carpeta de Procedimientos Almacenados/Procedimientos almacenados del sistema. A su vez un procedimiento almacenado puede ser modificado, para ello deberemos ir al buscador de objetos, buscamos el procedimiento que queremos modificar, realizamos los cambios necesarios en el procedimiento y luego lo ejecutamos para guardar los cambios.

##LLAMADA DE PROCEDIMIENTO ALMACENADO

Para llamar a un procedimiento almacenado utilizamos la palabra reservada call.

##VENTAJAS DE PROCEDIMIENTOS ALMACENADOS
1_Que se realicen cálculos o procesos complejos y se devuelvan múltiples resultados al contexto que hizo la llamada. 

2_Contener instrucciones de programación que realicen operaciones en la base de datos, incluidas las llamadas a otros procedimientos.

3_Agrupan múltiples sentencias SQL en un solo bloque, lo que facilita su ejecución y reutilización.

4_Facilitan el mantenimiento del código, ya que cualquier cambio en la lógica se puede hacer en el procedimiento sin afectar a la aplicación, es decir, permite la reutilización de código.

5_Los procedimientos controlan lo que los usuarios pueden hacer, lo que protege la base de datos, lo que protege la base de datos sin que puedan alterarla. El procedimiento almacenado funciona como una barrera que actúa como protector de datos. Dentro del procedimiento, se definen qué operaciones puede el usuario  ejecutar sobre los objetos de la base de datos.

6_Permite reducir el tráfico de red, debido a que las instrucciones se ejecutan en el servidor de la base de datos, debido a que el procedimiento si realiza múltiples operaciones reduce la cantidad de datos enviados entre el cliente y el servidor.

#FUNCIONES

##¿QUE ES UNA FUNCION ALMACENADA?

Una Función Almacenada o función definida por el usuario es un conjunto de instrucciones SQL que se almacena asociado a una base de datos. Es un objeto que se crea con la sentencia CREATE FUNCTION y se invoca con la sentencia SELECT o dentro de una expresión. Una función debe devolver un determinado valor, a diferencia de un procedimiento almacenado, que puede o no devolver un valor. Como también pueden ser utilizadas en consultas SQL.

##SINTAXIS

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

##EJECUCION DE FUNCIONES

Una función se ejecuta con la palabra reservada Select siguiendo obligatoriamente el esquema, en  caso de que se este trabajo con el esquema por defecto (dbo.), colocarse obligatoriamente luego siguiendo f_nombre_funcion (@parametrod);
En caso de no incluir el esquema lanzará el siguiente error:
El mensaje 195, Nivel 15, Estado 10, Línea 20 ‘f_nombre_funcion’ no es un nombre de función incorporado reconocido

##VENTAJAS DE FUNCIONES ALMACENADAS 

Reutilización de código donde las funciones almacenadas permiten encapsular lógica que puede ser reutilizada en múltiples consultas o procedimientos.
Mejora del rendimiento debido a que están almacenadas en el servidor y ser compiladas previamente, las funciones pueden ejecutar consultas complejas.
Seguridad se puede otorgar permisos para ejecutar funciones específicas sin dar acceso directo a las tablas subyacentes a distintos usuarios. 
Facilidad de mantenimiento si se necesita realizar un cambio en la lógica de negocio, solo tienes que modificar la función almacenada.
Modularidad debido a que se puede dividir la lógica compleja en funciones más pequeñas y específicas, lo que mejora la organización y legibilidad del código.

##ALMACENAMIENTO DE FUNCIONES ALMACENADAS DEFINIDAS POR EL USUARIO

Las funciones definidas por el usuario se almacenan en la siguiente carpeta de Funciones y dependiendo del tipo de función se almacenarán en las carpetas : Funciones con valores de tablas, Funciones escalares, Funciones de agregado.

#CONCLUSION

Un procedimiento almacenado es útil para realizar transformaciones de los datos en la estructura de la base de datos como actualizar, eliminar o insertar. Mientras que en una función es más adecuada utilizarla cuando queremos realizar cálculos, validaciones o transformaciones dentro de una consulta sin poder realizar modificaciones en la estructura de la base de datos.




