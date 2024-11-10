

----------------Indice CLUSTERED-------------------------------
--Crear Indice Clustered en la columna fecha_inscripciones
CREATE CLUSTERED INDEX [IX_fecha_inspeccion]
ON [dbo].[Inspecciones] ([fecha_inspeccion])

--Borrar Indice Clustered IX_fecha_inspeccion
DROP INDEX IX_fecha_inspeccion ON Inspecciones

--Crear Indice Clustered en la columna fecha_inscripciones con la columna [estado_inspeccion]
--Ordenado por fecha 
CREATE CLUSTERED INDEX [IX_fecha_inspeccion]
ON [dbo].[Inspecciones] ([fecha_inspeccion],[estado_inspeccion])
--Ordenado por [estado_inspeccion]
CREATE CLUSTERED INDEX [IX_fecha_inspeccion]
ON [dbo].[Inspecciones] ([estado_inspeccion],[fecha_inspeccion])

--Crear Indice Clustered en la columna [estado_inspeccion] y [fecha_inscripciones]
CREATE NONCLUSTERED INDEX [IX_fecha_inspeccion]
ON [dbo].[Inspecciones] ([estado_inspeccion],[fecha_inspeccion])


-------------Consulta SQL a estudiar-----

SELECT fecha_inspeccion AS 'Fecha inspeccion' , estado_inspeccion AS 'ESTADO'
	FROM Inspecciones
	WHERE estado_inspeccion = 'Aprobada'
  	AND fecha_inspeccion BETWEEN '2023-03-01' AND '2023-05-31';



