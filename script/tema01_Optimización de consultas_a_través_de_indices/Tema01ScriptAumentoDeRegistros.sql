use proyecto_bd
select * from Inspecciones where fecha_inspeccion = '2005-08-29'

use proyecto_bdPrueba
select * from Inspecciones where fecha_inspeccion = '2005-08-29'

use proyecto_bdPruebaSinIndex
--DELETE FROM Inspecciones;

use proyecto_bdPrueba
select * from Inspecciones
use proyecto_bdPruebaSinIndex
select * from Inspecciones

use proyecto_bdPruebaSinIndex

DECLARE @i INT = 0;

WHILE @i < 13
BEGIN
    INSERT INTO Inspecciones (fecha_inspeccion, estado_inspeccion, id_inspector, nro_proyecto, id_etapa)
    SELECT 
        DATEADD(DAY, @i, p.fecha_inspeccion), -- Suma @i días a la fecha de inicio del proyecto
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 'Aprobada'  
            ELSE 'No Aprobada' -- Asignar 'No Aprobada' cuando el valor no sea 'Aprobada'
        END,
        id_inspector,  -- Usar un id_inspector válido de la tabla 'Inspector'
        nro_proyecto, 
        id_etapa
    FROM   Inspecciones p

    SET @i = @i + 1;
END;
--(4636672 filas afectadas)


--CASE 
    --WHEN RAND() < 0.5 THEN 'Aprobada'  
  --  ELSE 'No Aprobada' -- Asignar 'No Aprobada' cuando el valor no sea 'Aprobada'
--END




SET STATISTICS TIME ON;
SET STATISTICS IO ON;
use proyecto_bdPruebaSinIndex
	SELECT fecha_inspeccion AS 'Fecha inspeccion' , estado_inspeccion AS 'ESTADO'
	FROM Inspecciones
	WHERE estado_inspeccion = 'Aprobada'
	AND fecha_inspeccion BETWEEN '2023-03-01' AND '2023-05-31';
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
use proyecto_bdPrueba
	SELECT fecha_inspeccion AS 'Fecha inspeccion' , estado_inspeccion AS 'ESTADO'
	FROM Inspecciones
	WHERE estado_inspeccion = 'Aprobada'
	 AND fecha_inspeccion BETWEEN '2023-03-01' AND '2023-05-31';
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

use proyecto_bdPruebaSinIndex
CREATE CLUSTERED INDEX [IX_fecha_inspeccion]
ON [dbo].[Inspecciones] ([fecha_inspeccion],[estado_inspeccion])
--Ordenado por [estado_inspeccion]
use proyecto_bdPrueba
CREATE CLUSTERED INDEX [IX_fecha_inspeccion]
ON [dbo].[Inspecciones] ([estado_inspeccion],[fecha_inspeccion])


use proyecto_bdPrueba
CREATE NONCLUSTERED INDEX [IX_fecha_inspeccion]
ON [dbo].[Inspecciones] ([estado_inspeccion],[fecha_inspeccion])