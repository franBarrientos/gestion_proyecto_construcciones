

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


--------Script para aumentar el lote de datos--------------
DECLARE @i INT = 0;

WHILE @i < 13
BEGIN
    INSERT INTO Inspecciones (fecha_inspeccion, estado_inspeccion, id_inspector, nro_proyecto, id_etapa)
    SELECT 
        DATEADD(DAY, @i, p.fecha_inspeccion), -- Suma @i días a la fecha de inicio del proyecto
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 'Aprobada'  
            ELSE 'No Aprobada' 
        END,
        id_inspector,  
        nro_proyecto, 
        id_etapa
    FROM   Inspecciones p

    SET @i = @i + 1;
END;

