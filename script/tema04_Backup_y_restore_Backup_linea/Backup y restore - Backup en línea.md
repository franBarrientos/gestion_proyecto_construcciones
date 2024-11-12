# Introducción
El Backup y Restore en bases de datos asegura que los datos se puedan recuperar en caso de fallos, pérdidas de información o desastres, por lo tanto, tener una copia de seguridad de la información es necesario, ya que la probabilidad de que los dispositivos presentes fallas es menos probable.
- Backup crea una copia de seguridad de los datos en un estado específico, que se puede usar para restaurar la base de datos en caso de problemas.
- Restore permite recuperar esa copia de seguridad, regresando la base de datos a un punto previo.
- Backup en línea es un tipo de respaldo que se realiza mientras la base de datos está en uso, sin interrumpir las operaciones, ideal para sistemas críticos que requieren alta disponibilidad.
Estas técnicas protegen los datos y aseguran que puedan recuperarse con precisión y rapidez.


# ¿Qué es un Backup y un Restore? Implementación

## 1. **Backup:** Un backup es la creación de una copia de los datos en un momento específico. Esta copia puede ser utilizada para restaurar el sistema o la base de datos en caso de pérdida de datos, fallas en el hardware, errores del sistema o errores humanos. Existen diferentes tipos de backups, como el completo (full), el incremental y el diferencial, que se ajustan a distintas necesidades de protección y restauración.

### Ejemplo cambiar el Recovery a Full

Para que el Backup en línea y los Transaction Log Backups funcionen correctamente, es necesario ajustar el modelo de recuperación de la base de datos. En SQL Server, cambiar el modelo de recuperación a "Full" para habilitar respaldos más avanzados.

```sql
USE master; 
ALTER DATABASE proyecto_bd SET RECOVERY FULL;
```

### Ejemplo Full Backup:

```sql
BACKUP DATABASE proyecto_bd 
TO DISK = 'C:\Backup\proyecto_bd.bak';
```

### Ejemplo Transaction Log 1: Inserción 10 registros:

```sql
USE proyecto_bd;

INSERT INTO Representante_constructora (nombre_representante, apellido_representante, dni_representante, correo_representante, fecha_nacimiento, salario)
VALUES ('Juan', 'Pérez', 12345678, 'juanperez@gmail.com', '1985-03-18', 57000.00),
('Raul', 'Brollo', 42733217, 'raulbro@gmail.com', '1999-08-15', 50000.00),
('Celso', 'Bro', 39345478, 'celso@gmail.com', '1995-07-22', 55000.00),
('Ana', 'Marston', 24345678, 'ana@gmail.com', '1965-04-17', 52000.00),
('Jon', 'Rodri', 45345685, 'JonRr@gmail.com', '1989-12-31', 80000.00),
('Cande', 'Quest', 15845679, 'Quest@gmail.com', '1995-12-25', 46000.00),
('Julian', 'Alf', 42352478, 'JulianAlf@gmail.com', '1989-12-18', 55000.00),
('Roberto', 'Donald', 45345788, 'DonaldMcRobert@gmail.com', '1988-10-15', 25000.00),
('Elias', 'Mac', 34545854, 'MacElias@gmail.com', '1999-05-30', 39000.00),
('Joaquin', 'Rodri', 42342578, 'JoaquinRodri@gmail.com', '1975-05-22', 45000.00);

BACKUP LOG proyecto_bd TO DISK = 'C:\Backup\proyecto_bd_log1.trn';
```

### Ejemplo Transaction Log 2: Segunda inserción de otros 10 registros:

```sql
USE proyecto_bd;

INSERT INTO Representante_constructora (nombre_representante, apellido_representante, dni_representante, correo_representante, fecha_nacimiento, salario)
VALUES 
('Martín', 'Gómez', 32165478, 'martingomez@gmail.com', '1982-01-12', 62000.00),
('Lucía', 'Fernández', 98765432, 'luciafernandez@gmail.com', '1992-11-05', 49000.00),
('Diego', 'Santos', 65432198, 'diego.santos@gmail.com', '1988-06-30', 54000.00),
('Valentina', 'López', 34567890, 'valelop@gmail.com', '1994-09-15', 51000.00),
('Santiago', 'Morales', 87654321, 'santiagomorales@gmail.com', '1986-03-25', 58000.00),
('Marta', 'Cruz', 12345679, 'martacruz@gmail.com', '1991-05-17', 47000.00),
('Pablo', 'Salazar', 23456789, 'pablosalazar@gmail.com', '1987-08-11', 53000.00),
('María', 'Torres', 34567891, 'mariat@gmail.com', '1990-12-20', 50000.00),
('Nicolás', 'Rivas', 45678901, 'nicolasrivas@gmail.com', '1984-10-14', 60000.00),
('Soledad', 'Cáceres', 56789012, 'soledad@gmail.com', '1993-07-18', 48000.00);

BACKUP LOG proyecto_bd TO DISK = 'C:\Backup\proyecto_bd_log2.trn';
```

#### Importancia del Backup
El Backup es importante ya que todos los dispositivos de almacenamiento, aunque sea en un grado pequeño, pueden presentar fallas. Contar con una copia de seguridad es fundamental para el desarrollador, ya que la posibilidad de que dos dispositivos fallen simultáneamente es significativamente menor, garantizando así una mayor protección de la información almacenada.


## 2. **Restore:** 
El restore es el proceso de recuperar los datos a partir de un backup. Permite restablecer los datos a un estado anterior, lo cual es crítico en situaciones de pérdida de datos o desastres. El proceso de restauración devuelve los datos al sistema desde el archivo de respaldo, asegurando así que las operaciones puedan continuar sin pérdida significativa de información.

### Ejemplo restaurar al primer punto del log (después de los primeros 10 inserts):

```sql
USE master;
ALTER DATABASE proyecto_bd SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- Forzar el cierre de todas las conexiones y establecer el modo de usuario único para la restauración.

RESTORE DATABASE proyecto_bd
FROM DISK = 'C:\Backups\proyecto_bd_full.bak'
WITH NORECOVERY, REPLACE;

RESTORE LOG proyecto_bd  
FROM DISK = 'C:\Backups\proyecto_bd_log1.trn'
WITH RECOVERY;
```

### Ejemplo restaurar aplicando ambos archivos de log.

```sql
USE master;
ALTER DATABASE proyecto_bd SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- Forzar el cierre de todas las conexiones y establecer el modo de usuario único para la restauración.

RESTORE DATABASE proyecto_bd
FROM DISK = 'C:\Backups\proyecto_bd_full.bak'
WITH NORECOVERY, REPLACE;

RESTORE LOG proyecto_bd  
FROM DISK = 'C:\Backups\proyecto_bd_log1.trn'
WITH NORECOVERY;

RESTORE LOG proyecto_bd  
FROM DISK = 'C:\Backups\proyecto_bd_log2.trn'
WITH RECOVERY;
```

# ¿Por qué es importante el Backup y Restore?
Realizar backups y tener la capacidad de restaurar datos no solo protege la información de fallas, sino que también brinda confianza en la integridad del sistema de datos. Algunas razones clave para la importancia de estos procesos son:
- Protección ante pérdida de datos: Los datos pueden perderse por diversas razones, como fallas en el hardware, corrupción de archivos, ataques de malware, o incluso errores humanos. El backup proporciona una red de seguridad.
- Continuidad operativa: En sistemas que dependen de una disponibilidad constante, como los sistemas de negocios, la capacidad de restaurar datos rápidamente es fundamental para mantener la continuidad de las operaciones.
- Recuperación ante desastres: En situaciones de emergencia como incendios o inundaciones, un backup almacenado de forma segura permite recuperar la información y restaurar las operaciones a la normalidad.
-	Cumplimiento de normativas: Muchas industrias tienen requisitos legales para el almacenamiento y recuperación de datos, y una estrategia de backup adecuada puede asegurar el cumplimiento de estas normativas.

# Ventajas de realizar Backup y Restore
La implementación de estrategias de backup y restore tiene numerosas ventajas:
- Minimización de pérdidas de datos: Permite asegurar que, en caso de fallos, se puede restaurar la información hasta el último punto respaldado, lo que minimiza la cantidad de datos perdidos.
- Aseguramiento de la integridad de los datos: Al restaurar un backup, el sistema puede comprobar la integridad de los datos y asegurar que no haya corrupción, manteniendo la fiabilidad de la información.
- Reducción de tiempos de inactividad: Un sistema de backup bien estructurado permite una recuperación rápida, lo que reduce el tiempo que el sistema está inactivo y afecta a las operaciones.
- Protección frente a errores humanos: Los errores son inevitables en cualquier operación, y los backups permiten revertir el sistema a un estado anterior antes de que ocurran problemas.
- Recuperación precisa: Dependiendo del tipo de backup, como el uso de backups de logs de transacciones, se puede restaurar el sistema a un punto en el tiempo exacto, lo cual es útil en sistemas con alta demanda de disponibilidad y precisión.

# Tipos de Backup y Restore
## Los tipos de backups que se pueden incluir son:
- Full Backup: Es una copia completa de todos los datos en el sistema en un momento específico. Es básico y confiable, aunque puede ser lento y ocupar bastante espacio de almacenamiento.
- Incremental Backup: Guarda los datos que han cambiado desde el último backup, ya sea completo o incremental. La restauración de datos puede ser más compleja, ya que depende de una secuencia de respaldos específicas.
- Diferential Backup: Se hace un respaldo de toda la información modificada desde el último full backup. Ofrece una restauración más rápida en comparación con el incremental más, sin embargo, requiere más almacenamiento.
- Transaction Log Backup: Guarda las transacciones registradas en el sistema desde el último backup. Es especialmente útil para bases de datos, ya que permite realizar restauraciones precisas a puntos específicos en el tiempo, lo cual es crucial para sistemas que requieren alta disponibilidad y recuperación de datos ante eventos inesperados.

## Resumen:
- El Full Backup proporciona una copia completa de la Base de Datos y sirve de punto de inicio para restauraciones completas.
- El Transaction Log Backup permite capturar los cambios y restaurar la Base de Datos a momentos específicos, ideal para escenarios de alta disponibilidad o recuperación de desastres o fallas.


# Conclusión
Los backups y la capacidad de restauración de datos son esenciales para cualquier sistema. Ya que es un plan de respaldo bien diseñado que asegura, en caso de desastres o fallos, recuperar la información sin grandes pérdidas de datos ni largos tiempos de inactividad. Las organizaciones deben implementar una estrategia de backup y restore adaptada a sus necesidades, incluyendo backups completos, incrementales y de logs, para maximizar la seguridad y minimizar el riesgo de pérdida de datos. Por último, comentar que, brinda una tranquilidad esencial para las operaciones y el cumplimiento normativo.
Mediante los Backup completos y de logs de transacciones, fue posible restaurar la base de datos a ambos logs, garantizando precisión en la recuperación. Este proceso refuerza la importancia del modelo de recuperación Full y de respaldar periódicamente los logs para minimizar la pérdida de datos. En entornos reales, es recomendable implementar una estrategia de Backup regular y documentar los pasos, asegurando una restauración rápida y confiable.
