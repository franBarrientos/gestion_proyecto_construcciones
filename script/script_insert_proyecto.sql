-- SCRIPT "Gestion de Obra"
-- INSERCIÓN DEL LOTE DE DATOS
USE proyecto_bd;

-- Insertar datos en la tabla Etapas
INSERT INTO Etapas (nombre_etapa) VALUES 
('Planeación'), 
('Construcción'), 
('Finalización');

-- Insertar datos en la tabla Tipo_contrataciones
INSERT INTO Tipo_contrataciones (nombre_contrataciones) VALUES 
('Contratación Directa'), 
('Licitación Pública'), 
('Asociación Público-Privada');

-- Insertar datos en la tabla Provincia
INSERT INTO Provincia (nombre_provincia) VALUES 
('Buenos Aires'), 
('CABA'), 
('Catamarca'),
('Chaco'),
('Chubut'),
('Cordoba'),
('Corrientes'),
('Entre Rios'),
('Formosa'),
('Jujuy'),
('La Pampa'),
('La Rioja'),
('Mendoza'),
('Misiones'),
('Neuquen'),
('Rio Negro'),
('Salta'),
('San Juan'),
('San Luis'),
('Santa Cruz'),
('Santa Fe'),
('Santiago del Estero'),
('Tierra del Fuego, Antartida e Isla del Atlantico Sur'),
('Tucuman');

-- Insertar datos en la tabla Representante_constructora
INSERT INTO Representante_constructora (nombre_representante, apellido_representante, dni_representante, correo_representante) VALUES 
('Juan', 'Pérez', 12345678, 'juan.perez@example.com'), 
('María', 'Gómez', 87654321, 'maria.gomez@example.com');

-- Insertar datos en la tabla Inspector
INSERT INTO Inspector (nombre_inspector, apellido_inspector, dni_inspector, telefono_inspector, correo_inspector) VALUES 
('Carlos', 'Martínez', 23456789, 987654321, 'carlos.martinez@example.com'), 
('Ana', 'Lopez', 34567890, 123456789, 'ana.lopez@example.com');

-- Insertar datos en la tabla Tipo_construccion
INSERT INTO Tipo_construccion (nombre_construccion) VALUES 
('Edificio'), 
('Puente'), 
('Carretera');

-- Insertar datos en la tabla Empresa_constructora
INSERT INTO Empresa_constructora (nro_constructora, nombre_constructora, ciudad_constructora, direccion_constructora, id_representante) VALUES 
(1, 'Constructora ABC', 'Ciudad A', 'Calle 123', 1), 
(2, 'Constructora XYZ', 'Ciudad B', 'Avenida 456', 2);

-- Insertar datos en la tabla Localidad
INSERT INTO Localidad (nombre_localidad, id_provincia) VALUES 
('Parana', 8), 
('Gualeguaychu',8), 
('Concordia', 8);

-- Insertar datos en la tabla Proyectos
INSERT INTO Proyectos (cantidad_proyecto, Nombre_proyecto, fecha_inicio_proyecto, fecha_fin_proyecto, id_contrataciones, id_localidad, id_constructora, id_tipoconstruccion) VALUES 
(100, 'Proyecto 1', '2024-01-01', '2024-12-31', 1, 1, 1, 1), 
(200, 'Proyecto 2', '2024-02-01', '2024-11-30', 2, 2, 2, 2);

-- Insertar datos en la tabla Proyecto_Etapas
INSERT INTO Proyecto_Etapas (nro_proyecto, id_etapa) VALUES 
(1, 1), 
(1, 2), 
(2, 1), 
(2, 3);

-- Insertar datos en la tabla Inspecciones
INSERT INTO Inspecciones (fecha_inspeccion, estado_inspeccion, id_inspector, nro_proyecto, id_etapa) VALUES 
(20240110, 'Aprobada', 1, 1, 1), 
(20240215, 'Pendiente', 2, 1, 2), 
(20240301, 'Rechazada', 1, 2, 3);


