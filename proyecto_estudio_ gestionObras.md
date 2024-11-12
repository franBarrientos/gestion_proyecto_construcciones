# Proyecto de Estudio!

Acceso al documento [PDF](doc/proyecto_estudio_BaseDatos1.pdf) del diccionario de datos.

**Estructura del documento principal:**
- **PROYECTO SOBRE LA GESTION DE OBRAS DEL Instituto Autárquico de Planeamiento y Vivienda (IAPV) de la provincia de Entre Ríos**

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:
- Cabrera Romani, Lucas Ivan 43108457
- Brollo, Celso Raul 42733217
- Barrientos, Franco 45645852
- Capay, Gabriel 41008590

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

```sql
CREATE [ OR ALTER ] { PROC | PROCEDURE } [schema_name.] procedure_name [ ; number ]
    [ { @parameter_name [ type_schema_name. ] data_type } [ VARYING ] [ NULL ] [ = default ]
    [ OUT | OUTPUT | [READONLY] ]
    [ ,...n ]
    [ WITH <procedure_option> [ ,...n ] ]
    [ FOR REPLICATION ]
AS
    { [ BEGIN ]
        sql_statement [;]
        [ ...n ]
      [ END ] 
    }
    [;]

<procedure_option> ::= 
    [ ENCRYPTION ]
    [ RECOMPILE ]
    [ EXECUTE AS Clause ]
```

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

```sql
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


## TEMA 3: Manejo de permisos a nivel de usuarios de base de datos

### Configuración de Autenticación Mixta SQL Server
SQL Server permite configurar la autenticación en modo mixto, lo cual habilita tanto la autenticación de Windows como la autenticación propia de SQL Server. Esto es útil en ambientes que combinan usuarios internos, que pueden autenticarse mediante Windows, y usuarios externos con credenciales de SQL Server.

####	Ejemplo:

```sql
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 2;
```


### Permisos a Nivel de Usuarios
SQL Server permite crear usuarios específicos con permisos personalizados. Los cuales puede incluir, por ejemplo, usuarios con permisos administrativos completos y otros con permisos limitados a lectura. El objetivo es controlar lo que cada usuario puede hacer en la base de datos.

#### Ejemplo:

```sql
CREATE LOGIN UsuarioAdmin WITH PASSWORD = 'Admin12!';
CREATE USER UsuarioAdmin FOR LOGIN UsuarioAdmin;
EXEC sp_addrolemember 'db_owner', 'UsuarioAdmin';

CREATE LOGIN UsuarioLectura WITH PASSWORD = 'lectura123!';
CREATE USER UsuarioLectura FOR LOGIN UsuarioLectura;
EXEC sp_addrolemember 'db_datareader', 'UsuarioLectura'; 
```

Con estos permisos, el usuario de solo lectura podrá consultar datos, pero no insertarlos ni modificarlos.

### Permisos a Nivel de Roles
SQL Server permite crear roles que agrupan permisos específicos. Estos roles facilitan la administración de permisos cuando varios usuarios necesitan permisos similares. Por ejemplo, un rol que otorga solo permisos de lectura puede asignarse a varios usuarios para evitar configuraciones individuales.

#### Ejemplo:

```sql
CREATE ROLE LecturaRol;
GRANT SELECT ON Inspector TO LecturaRol;
EXEC sp_addrolemember 'LecturaRol', 'UsuarioLectura';
```

Los usuarios dentro del rol LecturaRol pueden consultar la tabla "Inspector", pero no modificarla.


## TEMA 4: Backup y Restore. Backup en linea

El proceso de Backup y Restore en bases de datos permite proteger y recuperar información en caso de fallos, pérdidas de datos, o desastres. Esto asegura que los datos críticos permanezcan disponibles y restaurables a un estado previo. La copia de seguridad crea un respaldo de la base de datos en un momento específico, mientras que el restore permite devolver la base de datos a ese punto de respaldo. Las organizaciones confían en los datos para tomar decisiones y operar eficientemente, por lo que cualquier pérdida de datos puede tener efectos negativos graves, tanto operativos como financieros.

### Tipos de Backup
1. Full Backup: Este es el tipo de backup más completo, ya que guarda toda la base de datos en su estado actual. Se recomienda como punto de inicio y debe realizarse de forma periódica para capturar el estado total de la base de datos.
2. Transaction Log Backup: Registra todas las transacciones ocurridas desde el último Full Backup o Transaction Log Backup. Esto permite restaurar la base de datos a un momento específico. Es ideal para entornos críticos, ya que permite restauraciones a puntos exactos, minimizando la pérdida de datos.
3. Backup en línea: Este tipo de respaldo se realiza mientras la base de datos está activa y en uso, sin interrumpir las operaciones. Es crucial para sistemas de alta disponibilidad que no pueden permitirse el lujo de detenerse para realizar un backup.

### Configuración del Modelo de Recuperación
Para que el Backup en línea y los Transaction Log Backups funcionen correctamente, es necesario ajustar el modelo de recuperación de la base de datos. En SQL Server, cambiar el modelo de recuperación a "Full" para habilitar respaldos más avanzados.

### Backup Full 
Este tipo de backup realiza una copia completa de todos los datos en el sistema en un momento específico. Generalmente se realiza como el primer respaldo y luego periódicamente para capturar el estado completo de los datos.

#### Ejemplo Backup FULL

```sql
BACKUP DATABASE proyecto_bd  
TO DISK = 'C:\backup\base_datos_full.bak';
```


### Backup Transaction Log
Los Transaction Log Backups permiten guardar solo las transacciones desde el último Backup completo o de log. Este proceso registra eventos de cambio incremental, lo cual permite restauraciones detalladas y precisas.

#### Ejemplo Backup Transaction Log

```sql
BACKUP LOG proyecto_bd 
TO DISK = 'C:\backup\base_datos_log.trn';
```

### Restore
La restauración de una base de datos implica devolverla a un estado guardado en un backup previo. Esto se puede hacer a partir de un backup completo y, si se necesita un punto en el tiempo específico, aplicando backups de log en el orden correcto

#### Ejemplo de Restore: Utilizando Full y Log

```sql
RESTORE DATABASE proyecto_bd
FROM DISK = 'C:\backup\base_datos_full.bak';
WITH NORECOVERY;

RESTORE LOG proyecto_bd  
FROM DISK = 'C:\backup\base_datos_log.trn' 
WITH NORECOVERY;
```

#### Importancia:
1. Protección ante pérdida de datos: Protege frente a fallos de hardware, ataques o errores humanos.
2. Continuidad operativa: Permite restaurar rápidamente los datos para evitar tiempos de inactividad.
3. Recuperación ante desastres: Facilita la restauración de datos después de situaciones extremas.
4. Cumplimiento normativo: Asegura el cumplimiento de regulaciones legales relacionadas con el manejo de datos.

#### Ventajas:
1. Minimiza pérdidas de datos y reduce tiempos de inactividad.
2. Protege contra errores humanos y asegura la integridad de los datos.
3. Permite una recuperación precisa, especialmente con backups de logs de transacciones.

En conclusión, es vital contar con estrategias de Backup y Restore para proteger y recuperar datos, garantizando la continuidad del negocio en caso de cualquier imprevisto.

# CAPÍTULO III: METODOLOGÍA SEGUIDA 


 ##* *a) Cómo se realizó el Trabajo Práctico**
### Elección del caso de estudio: Se eligió el Instituto Autárquico de Planeamiento y Vivienda (IAPV) como entidad principal, encargada de proyectos de construcción a empresas privadas en la provincia de Entre Ríos.
### Diseño Conceptual y Modelo ER: El proyecto se basa en un modelo de base de datos relacional, representando entidades clave como Proyectos, Etapas, Inspectores, Empresas Constructoras, etc.
### Desarrollo:
- Permisos y roles de usuarios: El sistema asegura acceso controlado a diferentes tipos de usuarios según roles.
- Funciones y Procedimientos Almacenados: Incluye funcionalidades para generar informes del estado de obras.
- Índices y optimización: Se integraron índices para mejorar la eficiencia en consultas clave.
- Triggers: Implementados para mantener consistencia en actualizaciones críticas de la base de datos.
### Pruebas y Validación: La base de datos fue probada con inserciones y consultas controladas, incluyendo pruebas de integridad referencial y de restricción de unicidad para campos críticos.
### Fase Final: Se realizo una revisión exhaustiva de la base de datos, verificando que cada componente (estructura, procedimientos, restricciones y documentación) El cual, según nuestro punto de vista, está completo. También realizamos la consolidación de toda la documentación para que esté clara y asequible, facilitando una futura gestión y mantenimiento de la base de datos.

 ## **b) Herramientas (Instrumentos y procedimientos)**
1) ERD Plus: Es la herramienta con la que creamos y editamos los diagramas, permitiéndonos trabajar en equipo y en línea, facilitando también la forma de guardar y editar los cambios sobre los diagramas.
2) SQL Server: Con esta herramienta, se crearon las tablas, restricciones, índices y triggers que aseguran la integridad y eficiencia del sistema. Además, SQL Server permitió implementar procedimientos almacenados para generar reportes y automatizar tareas recurrentes, mejorando así el control de la información.
3) Discord: Mediante de esta herramienta, se realizaron reuniones virtuales y discusiones en tiempo real, permitiendo a los integrantes compartir ideas, resolver dudas y coordinar tareas.

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


# CAPÍTULO V: CONCLUSIONES
Durante la fase de desarrollo, uno de los retos más importantes fue establecer conexiones complicadas entre las entidades. Para lograrlo, se diseñó un sistema claro y coherente que facilita la interacción entre las distintas partes en la construcción. Se pusieron en marcha medidas para evitar datos duplicados y mantener la coherencia de la información, como restricciones de unicidad y validaciones de integridad referencial.

Establecer dependencias entre las entidades fue otro aspecto importante para garantizar que cualquier modificación en una parte del proyecto no tuviera repercusiones negativas en otras áreas. Se utilizaron procesos estándar y reglas estrictas para manejar la inserción, actualización y eliminación de datos, lo cual fue clave para el éxito del proyecto.

Este enfoque asegura que la base de datos se pueda incorporar en todos los aspectos de los proyectos de construcción, facilitando a los involucrados tomar decisiones fundamentadas y seguir de cerca cada etapa de los proyectos.

Las funciones de este proyecto permiten realizar cálculos simples o transformaciones que se integren en consultas ; a su vez cuando sea necesaria la devolución de datos, el uso de procedimientos almacenados es útil cuando se requiere de lógica un poco más compleja, la necesidad de manipular datos y ejecutar múltiples acciones.
Es de mucha utilidad la realizacion  de procedimientos y funciones, debido a que ayudan al motor de base de datos a simplificar muchas tareas.


# BIBLIOGRAFÍA DE CONSULTA
- The Entity-Relationship Model: Toward a Unified View of Data, publicado en 1976 en ACM Transactions on Database Systems, por P. P. Chen.
- Aprende SQL, Universitat Jaume I, Castelló de la Plana, España, por G. Quintana (2014).
- Documentación oficial de Microsoft sobre el lenguaje T-SQL y el operador LIKE, en Microsoft Learn.
- Operador lógico SQL LIKE," disponible en SQL Shack, por R. Ortiz.

