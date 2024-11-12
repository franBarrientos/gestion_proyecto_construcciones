# Proyecto de Estudio!

Acceso al documento [PDF](doc/proyecto_estudio_BaseDatos1.pdf) del diccionario de datos.

**Estructura del documento principal:**
PROYECTO SOBRE LA GESTION DE OBRAS DEL Instituto Autárquico de Planeamiento y Vivienda (IAPV) de la provincia de Entre Ríos

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:
*Cabrera Romani, Lucas Ivan 43108457
*Brollo Celso, Raul 42733217
*Barrientos, Franco 45645852
*Capay, Gabriel 41008590

**Año**: 2024

# CAPÍTULO I: INTRODUCCIÓN


## 1.1 Tema

El Instituto Autárquico de Planeamiento y Vivienda (IAPV) de Entre Ríos se encarga de construir viviendas en colaboración con empresas privadas. Durante la construcción, se verifica el progreso y la calidad del trabajo a través de inspecciones.

## 1.2 Definición o planteamiento del problema

Nuestro escenario se basa en un Instituto Autárquico de Planeamiento y Vivienda (IAPV) de la provincia de Entre Ríos, que se dedica a la construcción de unidades habitacionales por convenios o concesiones con empresas privadas. Dichas construcciones se pueden llevar a cabo en las distintas ciudades de la provincia. De los proyectos se desean saber cuál es el número de proyecto que se va a realizar en una ciudad y su departamento, el tipo de construcción que se va a realizar (viviendas amuebladas, viviendas techadas, calles asfaltadas, enripiado, etc.), el nombre del proyecto que se llevara a cabo, la fecha de inicio y fin estimada para el proyecto.

De la empresa que se encarga de la construcción, se desea saber el número de empresa, nombre de la empresa, dirección y ciudad, como también un representante técnico del cual se desea conocer el nombre, apellido, DNI y correo electrónico.

Una vez empezada la obra, por cada etapa que se va cumpliendo, un inspector del Instituto va a constatar la misma y autorizar con su aprobación la continuidad de dicha obra. Del inspector se desea conocer el nombre, apellido, DNI, correo electrónico y teléfono.

Se debe tener en cuenta que cada proyecto puede tener puede tener varias etapas distintas, y una misma etapa puede tener varias inspecciones. A su vez de cada inspección, se quiere saber el nombre de la etapa, el inspector que realizara dicha inspección, estado de la etapa y fecha en la que se realizó la inspección.

## 1.3 Objetivo del trabajo práctico

Se estable como objetivo diseñar una base de datos que represente el caso de estudio mencionado anteriormente y generar su modelo físico. Además, como requerimiento se desea generar informes sobre el estado de la obra mediante los procedimientos que nos brinda el motor de base de datos. 



# CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

## TEMA 1: Optimización de consultas a través de índices

En bases de datos los índices, son estructuras que aceleran la recuperación de datos al asociarse con tablas. Existen diversos tipos de índices:
- Índice Clustered: Un índice clúster ordena y almacena las filas de datos de la tabla o vista por orden en función de la clave del índice clúster.
- Índice NonClustered: Cada fila del índice no clúster contiene un valor de clave no agrupada y un localizador de fila. Este localizador apunta a la fila de datos del índice clúster o el montón que contiene el valor de clave.
- Índice Hash: En un dice hash, se accede a los datos a través de una tabla hash en memoria. Los índices hash utilizan una cantidad fija de memoria, que es una función del número de cubos.
- Índice Unique: Un índice único se asegura de que la clave de índice no contenga valores duplicados y, por tanto, cada fila de la tabla o vista sea en cierta forma única.
- Columnstore Index: Almacena datos en columnas en lugar de filas, optimizando consultas analíticas de grandes volúmenes de datos.
- Índice Filtrado: Permite indexar solo un subconjunto de datos mediante predicados, ideal para consultas de filtrado específico.
- Índice Espacial: Optimiza consultas que involucran datos espaciales.
  
### Consideraciones al Usar Índices

1.	Eficiencia en Consultas: Puede reducir el tiempo de búsqueda permitiendo que el optimizador de consultas acceda a los datos necesarios sin escanear toda la tabla.
2.	Costo en Operaciones de Modificación: Instrucciones como INSERT, UPDATE, y DELETE requieren que los índices se actualicen lo cual consume recursos adicionales.
3.	Selección de Columnas: Algunas columnas no pueden ser claves de índices, como aquellas de tipo text, ntext, y image.
   
### Evaluación y Ejemplo de Uso

Se realizaron pruebas con diferentes configuraciones de índices para medir el impacto en el rendimiento del proyecto:
- Un índice clustered en una columna de baja cardinalidad (pocos valores únicos) mostró un mejor rendimiento en consultas que uno en una columna de alta cardinalidad.
- Un índice nonclustered mejoró el tiempo de respuesta, pero aumentó significativamente el espacio de almacenamiento.



## TEMA 2: Funciones y Procedimientos Almacenados

Los procedimientos almacenados son similares a los procedimientos de otros lenguajes de programación en tanto que pueden:
Que se realicen cálculos o procesos complejos y se devuelvan múltiples resultados al contexto que hizo la llamada. 
Contener instrucciones de programación que realicen operaciones en la base de datos, incluidas las llamadas a otros procedimientos.
 Permiten manejar transacciones de manera eficiente, garantizando la atomicidad de las operaciones.
 Agrupan múltiples sentencias SQL en un solo bloque, lo que facilita su ejecución y reutilización.
 Facilitan el mantenimiento del código, ya que cualquier cambio en la lógica se puede hacer en el procedimiento sin afectar a la aplicación.
Pueden aceptar parámetros para personalizar su comportamiento y devolver múltiples valores a través de parámetros de salida.
En resumen pueden recibir parametro o no, como  realizar operaciones que pueden incluir múltiples acciones (como inserciones, actualizaciones o eliminaciones) y no están limitados a devolver un solo valor. 

Un procedimiento puede hacer referencia a tablas que aún no existan. En el momento de la creación, solo se realiza la comprobación de la sintaxis. El procedimiento no se compila hasta que se ejecute por primera vez. Solamente durante la compilación se resuelven todos los objetos a los que se haga referencia en el procedimiento.aunque este procedimiento provocará un error en tiempo de ejecución si las tablas a las que hace referencia no existen.

### Procedimientos Almacenados del Sistema
Son procedimientos predefinidos que vienen con SQL Server. Proporcionan funcionalidad esencial para administrar y configurar la base de datos. ejemplo: sp_help-sp_adduser-sp_who. Se usan generalmente utilizados para tareas de administración, monitoreo y configuración del sistema. No requieren que el usuario los defina ni los implemente.
Procedimientos Almacenados Definidos por el Usuario
Son procedimientos creados por los usuarios para realizar operaciones específicas y personalizadas en la base de datos. Utilizados para automatizar procesos, realizar cálculos complejos o encapsular operaciones que se usan con frecuencia en aplicaciones.
Distintos usos de procedimientos en sql server
Devolver más de un conjunto de resultados.
Crear un procedimiento almacenado CLR.
Crear un procedimiento con parámetros de entrada.
Usar un procedimiento con parámetros comodín.
Usar parámetros OUTPUT.
Usar UPDATE en un procedimiento.
Usar TRY CATCH.
Crear un procedimiento almacenado que ejecute una instrucción SELECT.

#### Sintaxis

CREATE [ OR ALTER ] { PROC | PROCEDURE }
    [schema_name.] procedure_name [ ; number ]
    [ { @parameter_name [ type_schema_name. ] data_type }
        [ VARYING ] [ NULL ] [ = default ] [ OUT | OUTPUT | [READONLY]
    ] [ ,...n ]
[ WITH <procedure_option> [ ,...n ] ]
[ FOR REPLICATION ]
AS { [ BEGIN ] sql_statement [;] [ ...n ] [ END ] }
[;]

<procedure_option> ::=
    [ ENCRYPTION ]
    [ RECOMPILE ]
    [ EXECUTE AS Clause ]

### Explicación de algunos de sus argumentos
CREATE: se usa para crear el procedimiento.
OR ALTER: permite modificar los procedimientos luego de crearlo.
PROC o PROCEDURE: permite identificar que se va a crear un procedimientos, se puede definir con ambas formas.
@parameter_name : parametros que puede recibir o no el procedimiento.
 [ type_schema_name. ]: El nombre del esquema al que pertenece el procedimiento. Los procedimientos se enlazan a un esquema. 
procedure_name:  nombre del procedimiento.
[ BEGIN ] sql_statement [;] [ ...n ] [ END ] : bloque de sentencia que puede definirse dentro del procedimiento.


### Ejecutar un procedimiento almacenado

 
1. Conexión a la Base de Datos Debes estar conectado a la base de datos donde se encuentra el procedimiento almacenado..
2. Conocer el Nombre del Procedimiento Debes conocer el nombre exacto del procedimiento almacenado que deseas ejecutar.
3. Parámetros (si es necesario) Si el procedimiento requiere parámetros de entrada, debes conocer sus tipos y el orden en que se deben pasar. Asegúrate de proporcionar los valores adecuados.
4. Sintaxis para Ejecutar el Procedimiento La forma básica de ejecutar un procedimiento almacenado es utilizando la instrucción EXEC o EXECUTE. Seguido del nombre del procedimiento almacenado y en caso de tener sus parametros.
   Funciones
Una función definida por el usuario acepta parámetros, realiza una acción, como un cálculo complejo, y devuelve el resultado de esa acción como un valor. El valor de retorno puede ser un valor escalar (único) o una tabla. 

### Clasificación de funciones
Funciones de agregado: toman un conjunto de valores y nos devuelven un solo valor ej: sum()-avg()-count()-max()-min().
Funciones de fila: operan en cada fila de forma individual en una tabla y permiten realizar cálculos o manipulaciones de datos.ej: upper()-lower()-substring().
Funciones determinísticas: que siempre retornan el mismo resultado.
Funciones no deterministas: retornan distintos resultados cada vez que son llamadas. aunque tengan el mismo parámetro. ej: getdate(), etc.


### Limitaciones
Las funciones definidas por el usuario no se pueden utilizar para realizar acciones que modifiquen el estado de la base de datos. Por ello, no pueden incluirse INSERTS, UPDATES o DELETE.
No existen parámetros de salida a diferencia de los procedimientos almacenados.
No pueden realizarse sentencias de control de transacciones como BEGIN TRANSACTION, COMMIT o ROLLBACK.
No pueden usarse dentro de una función comandos DDL como CREATE, ALTER, o DROP
No se pueden crear tablas temporales dentro de una función.



### Algunas funciones 
Funciones escalares: retornan un valor escalar
Funciones de tabla de varias instrucciones: retornan una tabla
Funciones de tabla en línea: retornan una tabla


#### Sintaxis

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

OR ALTER Altera condicionalmente la función sólo si ya existe.
NOMBRE_ESQUEMA El nombre del esquema al que pertenece la función definida por el usuario.
nombre_funcion El nombre de la función definida por el usuario. 
@nombre_parametro es el nombre del parametro que recibe
tipo_de_dato_retorno El valor de retorno de una función escalar definida por el usuario.
cuerpo_funcion donde permite definir un bloque para realizar ciertas operaciones

expresion_escalar Especifica el valor escalar que devuelve la función escalar.

### Ejecución de funciones
Una función se ejecuta con la palabra reservada Select siguiendo obligatoriamente el esquema, en  caso de que se este trabajo con el esquema por defecto (dbo.), colocarse obligatoriamente luego siguiendo f_nombre_funcion (@parametrod);
En caso de no incluir el esquema lanzará el siguiente error:

El mensaje 195, Nivel 15, Estado 10, Línea 20 ‘f_nombre_funcion’ no es un nombre de función incorporado reconocido
Una función se puede almacenar en un esquema definido por un usuario, en caso de que así lo desee. Esto tiene múltiples ventajas entre las cuales podemos destacar:
Para tener funciones que se utilicen para una determinada tarea dentro de un sistema, es decir, funciones que compartan una tarea en común.
Para no tener conflictos en nombre de funciones, debido a que diferentes funciones con tareas distintas pueden tener el mismo nombre pero tienen que estar en distintos esquemas.
Para lograr una mejor documentación y modularidad, debido a que funciones definidas en esquemas que le corresponden facilitan el entendimiento y comprensión de dicha definición.
Una función definida dentro de un esquema permite mayor rendimiento al motor de la base de datos. En tiempo de búsqueda, ejecución,etc.
 





# CAPÍTULO III: METODOLOGÍA SEGUIDA 



 **a) Cómo se realizó el Trabajo Práctico**
en desarrollo
 **b) Herramientas (Instrumentos y procedimientos)**
1) ERD Plus: Es la herramienta con la que creamos y editamos los diagramas, permitiéndonos trabajar en equipo y en línea, facilitando también la forma de guardar y editar los cambios sobre los diagramas.


# CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 





### Diagrama conceptual (opcional)

![diagrama_relacional](https://github.com/franBarrientos/gestion_proyecto_construcciones/blob/main/doc/diseñoconceptual.png)

### Diagrama relacional
![diagrama_relacional](https://github.com/franBarrientos/gestion_proyecto_construcciones/blob/main/doc/Modelo_Relacional.jpg)
v


### Diccionario de datos

Acceso al documento [PDF](doc/DiccionarioDeDatos.pdf) del diccionario de datos.
![image](https://github.com/user-attachments/assets/c127b20f-fdfe-4373-a748-d4588d5ba4fd)

![image](https://github.com/user-attachments/assets/134d8b81-2701-4085-9cd5-86349cfc5197)

![image](https://github.com/user-attachments/assets/110d6073-a397-4794-b03f-344af728747c)

![image](https://github.com/user-attachments/assets/c01b147d-c3b9-4a6c-a81c-01763ef3e53f)

![image](https://github.com/user-attachments/assets/3efdf690-5066-4c07-b7bd-43026a9a524a)

![image](https://github.com/user-attachments/assets/44843dc8-0f22-4519-8e13-6d3862a877d3)
![image](https://github.com/user-attachments/assets/53d13efd-b948-4a97-a308-646f2b97a2aa)



![image](https://github.com/user-attachments/assets/4c2d3e90-2bb8-4459-886b-0674961f8ed7)

![image](https://github.com/user-attachments/assets/47f16a2c-50fd-4333-93c8-dd2ff8bb3cbe)

![image](https://github.com/user-attachments/assets/e89a2406-d469-469b-a29a-5d63053bebbd)
![image](https://github.com/user-attachments/assets/a09b91dd-f1f1-4cda-b7b6-d5f07a4f5ff6)

![image](https://github.com/user-attachments/assets/ec6d63de-2152-4044-b83a-6954f1aaeac5)
![image](https://github.com/user-attachments/assets/20069e40-822a-4c3d-8270-6acd276cadd7)

![image](https://github.com/user-attachments/assets/c61f9faf-b843-4b31-a32b-b6db2a0b9a34)
![image](https://github.com/user-attachments/assets/1cf1d8af-ea8c-46ce-82b8-670b1eb7e882)


















### Desarrollo TEMA 1 "----"

en desarollo

### Desarrollo TEMA 2 "----"

en desarollo 


 CAPÍTULO V: CONCLUSIONES

Las funciones permiten realizar cálculos simples o transformaciones que se integren en consultas ; a su vez cuando sea necesaria la devolución de datos, el uso de procedimientos
almacenados es útil cuando se requiere de lógica un poco más compleja, la necesidad de manipular datos y ejecutar múltiples acciones.
Es de mucha utilidad la realizacion  de procedimientos y funciones, debido a que ayudan al motor de base de datos a simplificar muchas tareas.




## BIBLIOGRAFÍA DE CONSULTA
(material de lectura/consulta que se utilizó para el desarrollo del trabajo)

