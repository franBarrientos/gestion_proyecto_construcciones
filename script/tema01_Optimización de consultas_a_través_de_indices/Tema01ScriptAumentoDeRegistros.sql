

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
