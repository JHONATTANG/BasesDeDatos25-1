USE TOUR;

-- 1.Nombre y el equipo de aquellos corredores menores de 30 años que han ganado alguna etapa.
Select 	CIC.Nombre "NOMBRE CICLISTA", CIC.FechaNacimiento "FECHA NACIMIENTO",
 EQ.Nombre "NOMBRE EQUIPO",  CLET.NumEtapa "ETAPA CLASIFICADA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join clasificacionetapa CLET On CIC.IdCiclista = CLET.IdCiclista
where timestampdiff(YEAR, FechaNacimiento, CURDATE()) <=30
Order By CIC.IdEquipo ;


-- 2.Nombre y equipo de los corredores mayores de 35 años que han ganado algún tramo( etapa ).
Select 	CIC.Nombre "NOMBRE CICLISTA", CIC.FechaNacimiento "FECHA NACIMIENTO",
 EQ.Nombre "NOMBRE EQUIPO",  CLET.NumEtapa "ETAPA CLASIFICADA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join clasificacionetapa CLET On CIC.IdCiclista = CLET.IdCiclista
where timestampdiff(YEAR, FechaNacimiento, CURDATE()) >=35
Order By CIC.IdEquipo ;


-- 3.Datos de las etapas que pasan por algún tramo de montaña y que tienen salida y llegada en la misma población.
-- Si el tramo tiene altura mayor a 700 es montaña
select * from tramo
where altura > 700
order by etapa;

select * from etapa
left join ciudad CI on etapa.Llegada and etapa.Salida  = CI.IdCiudad
where etapa.salida = etapa.llegada;


-- 4.Poblaciones que tienen la meta de alguna etapa, pero desde las que no se realiza ninguna salida.
select * from etapa
left join ciudad CI on etapa.Llegada  = CI.IdCiudad
where llegada not like salida;


-- 5.Nombre y el equipo de los ciclistas que han ganado alguna etapa llevando la camiseta de color amarillo, mostrando también el número de etapa.
Select 	CIC.Nombre "NOMBRE CICLISTA", 
 EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
 CAM.Color "CAMISETA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
-- where (YEAR('2025-01-01') - YEAR(CIC.FechaNacimiento)) >=35
where CAM.Color = 'AMARILLA'
Order By CIC.IdEquipo ;


-- 6.Poblaciones de salida y de llegada de las etapas donde se encuentran tramos con altura superior a 900 metros.
select * from tramo
where altura > 900
order by etapa;


-- 7.Número de las etapas que tienen algún(os) tramos de montaña, indicando cuántos tiene cada una de ellas.
select E.NumEtapa "Etapa", COUNT(CodTramo) "Tramos con Montaña"
from tramo T
inner join etapa E on T.Etapa =  E.NumEtapa
where altura > 700
group by etapa;


-- 8.Obtener la edad media de los ciclistas que han ganado alguna etapa.

SELECT AVG(TIMESTAMPDIFF(YEAR, CIC.FechaNacimiento, CURDATE())) AS Edad_Promedio
FROM Ciclistas CIC
WHERE CIC.IdCiclista IN (
    SELECT DISTINCT CLET.IdCiclista 
    FROM clasificacionetapa CLET
);

SELECT *
    #AVG(TIMESTAMPDIFF(YEAR, CIC.FechaNacimiento, CURDATE())) AS Edad_Promedio
FROM Ciclistas CIC
WHERE CIC.IdCiclista IN (
    SELECT DISTINCT CLET.IdCiclista 
    FROM clasificacionetapa CLET
);

Select 	CIC.Nombre "NOMBRE CICLISTA", 
				timestampdiff(YEAR, FechaNacimiento, CURDATE()) as EDAD,
				EQ.Nombre "NOMBRE EQUIPO", ROW_NUMBER() OVER (ORDER BY clet.NumPuesto ASC) as Puesto_Clasificación,
				 CONCAT(clet.HorasRec, ':', clet.MinRec, ':', clet.SegRec) as Horas_Recorridas,
				clet.pts as puntos
		From Ciclistas CIC
		Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
		Inner Join clasificacionetapa CLET On CIC.IdCiclista = CLET.IdCiclista
		where clet.numetapa = 1;

-- 9.Obtener la edad del ciclista más joven, la del más veterano y la media de edad de los ciclistas que han participado en la vuelta.
# TIMESTAMPDIFF Calcula la diferencia en años entre FechaNacimiento y CURDATE(), ajustando automáticamente si el cumpleaños ya ocurrió en el año actual.
SELECT 
    MIN( timestampdiff(YEAR, FechaNacimiento, CURDATE()) ) AS Edad_Ciclista_Joven,
    MAX( timestampdiff(YEAR, FechaNacimiento, CURDATE()) ) AS Edad_Ciclista_Veterano,
    AVG( timestampdiff(YEAR, FechaNacimiento, CURDATE()) ) AS Edad_Media
FROM ciclistas;

SELECT Nombre, FechaNacimiento, timestampdiff(YEAR, FechaNacimiento, CURDATE()) as EDAD
from ciclistas
where 	timestampdiff(YEAR, FechaNacimiento, CURDATE()) = (SELECT MIN( timestampdiff(YEAR, FechaNacimiento, CURDATE()) ) FROM ciclistas)
or 		timestampdiff(YEAR, FechaNacimiento, CURDATE()) = (SELECT MAX( timestampdiff(YEAR, FechaNacimiento, CURDATE()) ) FROM ciclistas);


-- 10.Obtener el nombre del equipo y el director del ciclista que ha ganado la etapa más larga.
select eq.nombre as Equipo, eq.director as Director, cic.Nombre as Ciclista, et.NumEtapa as Etapa, et.Km as KM,	ROW_NUMBER() OVER (ORDER BY cl.NumPuesto ASC) as Puesto_Clasificación
from etapa et
join clasificacionEtapa cl on et.NumEtapa = cl.NumEtapa
join ciclistas cic on cl.IdCiclista = cic.IdCiclista
join equipo eq on cic.IdEquipo = eq.IdEquipo
where et.Km = (
	select Km from etapa
	order by Km desc
	limit 1
);


-- 11.Nombre y equipo del ganador de la vuelta (es decir, el que ha lucido la camiseta amarilla en la última etapa).
Select 	CIC.Nombre "NOMBRE CICLISTA", 
 EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
 CAM.Color "CAMISETA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
where CAM.Color = 'AMARILLA'
Order By CIC.IdEquipo ;


-- 12.Nombre y director de los equipos que, en alguna etapa, sus ciclistas han llevado tres o más camisetas.
Select 	CIC.Nombre "NOMBRE CICLISTA", 
 EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
 CAM.Color "CAMISETA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
Order By CIC.IdEquipo ;


-- 13.Dorsal y nombre del ciclista que ha llevado la camiseta verde durante más etapas.
Select 	CIC.Nombre "NOMBRE CICLISTA", 
 EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
 CAM.Color "CAMISETA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
where CAM.Color = 'VERDE'
Order By CIC.IdEquipo ;


-- 14.Obtener todos los datos
select 	cic.nombre as ciclista, eq.nombre as Equipo, eq.director as Director,  
		timestampdiff(YEAR, cic.FechaNacimiento, CURDATE()) as Edad_Ciclista,
        cic.PesoGr AS Peso_Ciclista_Kg, cla.NumPuesto AS Clasificacion_General,
        CONCAT(cla.HorasRec, ':', cla.MinRec, ':', cla.SegRec) as Horas_Recorridas,
        CONCAT('+ ',cla.HorasDif, ':', cla.MinDif, ':', cla.SegDig) as Tiempo_Diferencia_Lider,
        cla.Pts as Puntos, 
        (SELECT COUNT(DISTINCT claet.NumEtapa)  FROM clasificacionetapa claet  WHERE claet.IdCiclista = cic.IdCiclista) AS Etapas_Clasificadas,
        (
			SELECT GROUP_CONCAT(DISTINCT cam.color SEPARATOR ', ') 
			FROM camiseta cam
			JOIN premios pr ON cam.Premio = pr.IdPremio
			WHERE pr.IdCiclista = cic.IdCiclista
			GROUP BY pr.IdCiclista  -- Asegura un solo resultado
		) AS Premios
        
        
from ciclistas cic
join equipo eq on cic.IdEquipo = eq.IdEquipo
join clasificacion cla on cic.IdCiclista = cla.IdCiclista
order by cla.NumPuesto Asc
;


select 	et.NumEtapa AS Etapa,
		(select Ciudad from ciudad city where city.IdCiudad = et.salida) as Ciudad_Salida,
		(select Ciudad from ciudad city where city.IdCiudad = et.llegada) as Ciudad_Llegada,
        et.Km as Km_Etapa, et.Fecha AS Fecha_Etapa, cat.TipoCategoria as Categoria
        
from etapa et
join ciudad city on et.salida and et.llegada = city.IdCiudad
join categoria cat on et.IdCategoria = cat.IdCategoria
order by  et.NumEtapa;

Select Etapa, CodTramo as Codigo_Tramo, Nombre as Nombre_Tramo, Altura as Altura_Tramo, Distancia as Km_Tramo
from tramo order by Etapa ;

