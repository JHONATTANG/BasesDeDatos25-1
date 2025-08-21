-- Crear base de datos y seleccionarla
CREATE DATABASE IF NOT EXISTS TOUR;
USE TOUR;

-- Crear tabla de zonas con metas mensuales TablasDataTour.SQL

-- Crear el procedimiento para evaluar si los vendedores cumplieron la meta mensual
DELIMITER //

# DROP PROCEDURE  IF EXISTS Ganadores_Etapas

CREATE PROCEDURE Ganadores_Etapas(IN etapaIN int)
BEGIN
    -- Declarar variables para recorrer los datos
    DECLARE done INT DEFAULT 0;
    DECLARE nombre_ciclista VARCHAR(150);
    DECLARE edad_ciclista INT;
    DECLARE Equipo_ciclista varchar(150);
    DECLARE Clasificacion_ciclista VARCHAR(150);
    DECLARE Tiempo_Ciclista VARCHAR(150);
    DECLARE puntos_ciclista int;
    

    -- Definir cursor para obtener nombre del vendedor, zona, meta de la zona, y total de ventas en el mes
    -- La función COALESCE(valor, valor_predeterminado) devuelve:
    -- valor si no es NULL
    -- valor_predeterminado si sí es NULL
    
    DECLARE cur CURSOR FOR
	
    
		Select 	CIC.Nombre "NOMBRE CICLISTA", 
				timestampdiff(YEAR, FechaNacimiento, CURDATE()) as EDAD,
				EQ.Nombre "NOMBRE EQUIPO", 
                ROW_NUMBER() OVER (ORDER BY clet.NumPuesto ASC) as Puesto_Clasificación,
				 CONCAT(clet.HorasRec, ':', clet.MinRec, ':', clet.SegRec) as Horas_Recorridas,
				clet.pts as puntos
		From Ciclistas CIC
		Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
		Inner Join clasificacionetapa CLET On CIC.IdCiclista = CLET.IdCiclista
		where clet.numetapa = etapaIN;

    -- Manejador para detectar fin del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir el cursor
    OPEN cur;

    -- Bucle para recorrer cada registro
    leer_loop: LOOP
        FETCH cur INTO nombre_ciclista, edad_ciclista, Equipo_ciclista, Clasificacion_ciclista, Tiempo_Ciclista, puntos_ciclista;

        IF done THEN
            LEAVE leer_loop;
	    END IF;

        -- Evaluar si el vendedor cumplió la meta
    
		IF edad_ciclista < 24 THEN
            SELECT 
                CONCAT(nombre_ciclista, ' - Puesto: ', Clasificacion_ciclista, ' - Equipo: ',Equipo_ciclista) AS Clasificacion,
                edad_ciclista AS Edad,
                CONCAT('Tiempo de Clasificación ', Tiempo_Ciclista, ' en la etapa ',etapaIN) AS Clasificacion,
                'Es más joven de 24 años' AS Excelencia,
                CONCAT('Puntaje de: ', puntos_ciclista) AS Puntaje;
        ELSE
            SELECT 
                CONCAT(nombre_ciclista, ' - puesto: ', Clasificacion_ciclista, ' - Equipo: ',Equipo_ciclista) AS Clasificacion,
                edad_ciclista AS Edad,
                CONCAT('Tiempo de Clasificación ', Tiempo_Ciclista, ' en la etapa ',etapaIN) AS Clasificacion,
                'Es veterano con 24 años o más' AS Excelencia,
                CONCAT('Puntaje de: ', puntos_ciclista) AS Puntaje;
        END IF;
    END LOOP;

    -- Cerrar el cursor
    CLOSE cur;
END;
//

-- Restaurar el delimitador original
DELIMITER ;

-- Ejecutar el procedimiento para el mes de abril 2024
CALL Ganadores_Etapas(4);



Select 	CIC.Nombre "NOMBRE CICLISTA", 
				timestampdiff(YEAR, FechaNacimiento, CURDATE()) as EDAD,
				EQ.Nombre "NOMBRE EQUIPO", 
                ROW_NUMBER() OVER (ORDER BY clet.NumPuesto ASC) as Puesto_Clasificación,
				 CONCAT(clet.HorasRec, ':', clet.MinRec, ':', clet.SegRec) as Horas_Recorridas,
				clet.pts as puntos
		From Ciclistas CIC
		Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
		Inner Join clasificacionetapa CLET On CIC.IdCiclista = CLET.IdCiclista
		where clet.numetapa = 10;