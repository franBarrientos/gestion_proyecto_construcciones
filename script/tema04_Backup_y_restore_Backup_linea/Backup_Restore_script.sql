-- Cambiar el modelo de recuperación a FULL.
USE master;
ALTER DATABASE proyecto_bd SET RECOVERY FULL;

-- Backup FULL(Completo).
BACKUP DATABASE proyecto_bd  
TO DISK = 'C:\Backups\proyecto_bd_full.bak';

-- Insertar 10 registros.
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


-- Backup del archivo de log de transacciones.
BACKUP LOG proyecto_bd  
TO DISK = 'C:\Backups\proyecto_bd_log1.trn';

-- Insertar otros 10 registros.
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

-- Segundo Backup del archivo de log.
BACKUP LOG proyecto_bd  
TO DISK = 'C:\Backups\proyecto_bd_log2.trn';

-- Restaurar al primer punto del log (después de los primeros 10 inserts).
USE master;
ALTER DATABASE proyecto_bd SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- Forzar el cierre de todas las conexiones y establecer el modo de usuario único para la restauración.

RESTORE DATABASE proyecto_bd
FROM DISK = 'C:\Backups\proyecto_bd_full.bak'
WITH NORECOVERY, REPLACE;

RESTORE LOG proyecto_bd  
FROM DISK = 'C:\Backups\proyecto_bd_log1.trn'
WITH RECOVERY;

-- Restaurar aplicando ambos archivos de log.
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
