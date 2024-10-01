CREATE DATABASE proyecto_bd;

USE proyecto_bd;

CREATE TABLE Tipo_construccion
(
  id_tipoconstruccion INT  IDENTITY(1,1)  NOT NULL,
  nombre_construccion VARCHAR(200) NOT NULL,			
  CONSTRAINT PK_id_tipo_construccion PRIMARY KEY (id_tipoconstruccion)
);

CREATE TABLE Empresa_constructora
(
  id_constructora INT IDENTITY(1,1)  NOT NULL,
  nro_constructora INT NOT NULL,
  nombre_constructora VARCHAR(200) NOT NULL,
  ciudad_constructora VARCHAR(200) NOT NULL,
  direccion_constructora VARCHAR(200) NOT NULL,
  id_representante INT NOT NULL,
 CONSTRAINT PK_id_constructura PRIMARY KEY (id_constructora),
  CONSTRAINT FK_representante_constructora FOREIGN KEY (id_representante) REFERENCES Representante_constructora(id_representante)
);

CREATE TABLE Localidad
(
  id_localidad INT  IDENTITY(1,1) NOT NULL,
  nombre_localidad VARCHAR(200) NOT NULL,
  id_provincia INT NOT NULL,
  CONSTRAINT PK_id_localidad PRIMARY KEY (id_localidad),
  CONSTRAINT FK_provincia_localidad FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);

CREATE TABLE Proyectos
(
  nro_proyecto INT IDENTITY(1,1)  NOT NULL,
  cantidad_proyecto INT NOT NULL,
  Nombre_proyecto VARCHAR(200) NOT NULL,
  fecha_inicio_proyecto DATE NOT NULL,
  fecha_fin_proyecto DATE NOT NULL,
  id_contrataciones INT NOT NULL,
  id_localidad INT NOT NULL,
  id_constructora INT NOT NULL,
  id_tipoconstruccion INT NOT NULL,
  CONSTRAINT PK_nro_proyecto PRIMARY KEY (nro_proyecto),
  CONSTRAINT FK_proyecto_contrataciones FOREIGN KEY (id_contrataciones) REFERENCES Tipo_contrataciones(id_contrataciones),
  CONSTRAINT FK_proyecto_localidad FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad),
 CONSTRAINT FK_proyecto_constructora FOREIGN KEY (id_constructora) REFERENCES Empresa_constructora(id_constructora),
 CONSTRAINT FK_proyecto_tipoconstruccion FOREIGN KEY (id_tipoconstruccion) REFERENCES Tipo_construccion(id_tipoconstruccion)
);

CREATE TABLE Proyecto_Etapas
(
  nro_proyecto INT NOT NULL, 
  id_etapa INT NOT NULL,
 CONSTRAINT PK_nroproyecto PRIMARY KEY (nro_proyecto, id_etapa),
  CONSTRAINT FK_nroproyecto_etapa FOREIGN KEY (nro_proyecto) REFERENCES Proyectos(nro_proyecto),
  CONSTRAINT FKproyecto_etapa FOREIGN KEY (id_etapa) REFERENCES Etapas(id_etapa)
);

CREATE TABLE Inspecciones
(
  id_inspecciones INT  IDENTITY(1,1) NOT NULL,
  fecha_inspeccion INT NOT NULL,
  estado_inspeccion VARCHAR(150) NOT NULL,
  id_inspector INT NOT NULL,
  nro_proyecto INT NOT NULL,
  id_etapa INT NOT NULL,
 CONSTRAINT PK_inspecciones_nroproyecto_etapa PRIMARY KEY (id_inspecciones, nro_proyecto, id_etapa),
  CONSTRAINT FK_inspeccion_inspector FOREIGN KEY (id_inspector) REFERENCES Inspector(id_inspector),
  CONSTRAINT FK_inspecciones_nroproyecto_etapa FOREIGN KEY (nro_proyecto, id_etapa) REFERENCES Poyecto_Etapas(nro_proyecto, id_etapa)
);
