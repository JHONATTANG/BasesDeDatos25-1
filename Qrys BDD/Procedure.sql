#introduccion

 create database class230425;
 
 
 use class230425;
 
CREATE TABLE Autores (autor_id INT PRIMARY KEY, nombre VARCHAR(255));
INSERT INTO Autores VALUES (1, 'J.K. Rowling'), (2, 'J.R.R. Tolkien'), (3, 'George Orwell');


CREATE TABLE Libros (libro_id INT PRIMARY KEY, titulo VARCHAR(255), autor_id INT);
INSERT INTO Libros VALUES (1, 'Harry Potter', 1), (2, 'The Hobbit', 2), (3, '1984', 3), (4, 'The Lord of the Rings', 2), (5, 'Animal Farm', 3);


SELECT Libros.titulo, Autores.nombre FROM Libros INNER JOIN Autores ON Libros.autor_id = Autores.autor_id;

SELECT Autores.nombre, COUNT(Libros.libro_id) as number_of_books 
FROM Libros 
JOIN Autores ON Libros.autor_id = Autores.autor_id 
GROUP BY Autores.nombre;


SELECT Autores.nombre, COUNT(Libros.libro_id) as number_of_books
from Libros
join Autores on Libros.autor_id = Autores.autor_id
group by Autores.nombre
order by number_of_books desc limit 1;



select nombre from autores where autor_id 
in (
	select autor_id from libros group by autor_id having count(libro_id) > 1
);



## SEGURIDAD

CREATE USER 'jhonattangu'@'localhost' IDENTIFIED BY 'password123';

GRANT SELECT ON class230425.* TO 'jhonattangu'@'localhost';

REVOKE SELECT ON class230425.* FROM 'jhonattangu'@'localhost';




create database ejercicio2304;
use ejercicio2304;

CREATE TABLE Autores (
	autor_id INT Primary Key,
	nombre varchar(255)
);

Create table Libros (
	libro_id INT Primary Key,
    titulo varchar(255),
    autor_id INT,
    foreign key (autor_id) REFERENCES Autores(autor_id),
    fecha_publicacion date,
    cantidad_disponible int
);


INSERT INTO Autores VALUES (1, 'J.K. Rowling'), (2, 'J.R.R. Tolkien'), (3, 'George Orwell'),(4, 'Moith humman');
INSERT INTO Autores VALUES (4, 'Moith humman');

INSERT INTO Libros VALUES 
(1, 'Harry Potter', 1, '2010-01-01', 5), 
(2, 'The Hobbit', 2, '2005-02-10', 1), 
(3, '1984', 3, '1983-03-25', 2), 
(4, 'The Lord of the Rings', 2, '2015-07-30', 0), 
(5, 'Animal Farm', 3, '2024-12-11', 3);



-- Listar todos los libros disponibles
select * from libros
where cantidad_disponible <> 0;

-- Actualizar la cantidad disponible de un libro en especifico
UPDATE libros
SET cantidad_disponible = 10
WHERE libro_id = 1;

-- utilizar JOIN para listar libros con autores

SELECT Libros.titulo, Autores.nombre FROM Libros INNER JOIN Autores ON Libros.autor_id = Autores.autor_id;


-- Autores que no han escrito ningun libro
SELECT Autores.nombre 
FROM Autores 
left JOIN libros 
ON autores.autor_id = libros.autor_id 
where libros.autor_id is null;

-- Crear un rol llamado "lector" y realice consulta de tablas


CREATE USER 'lector'@'localhost' IDENTIFIED BY '12345';

GRANT SELECT ON ejercicio2304.* TO 'lector'@'localhost';

REVOKE SELECT ON ejercicio2304.* FROM 'lector'@'localhost';

















### Privacidad de los datos

create table informacion(
	ID int primary key,
    nombre varchar (255),
    direccion varchar(255),
    SSN varchar(11)
);

insert into informacion (ID,nombre,direccion,SSN)
VALUES (1,'JUAN CAMILO GOMEZ','CARRERA 23 # 130 - 39', aes_encrypt('123-45-33','LLAVE_PRUEBA'));

## HASTA AQUI CON SSN VARCHAR SE GENERA ERROR, ENTONCES


alter table informacion modify SSN BLOB;

insert into informacion (ID,nombre,direccion,SSN)
VALUES (1,'JUAN CAMILO GOMEZ','CARRERA 23 # 130 - 39', aes_encrypt('123-45-33','LLAVE_PRUEBA'));


select * from informacion;

select ID,nombre,direccion, aes_decrypt(SSN,'LLAVE_PRUEBA') from informacion;


select ID,nombre,direccion, cast(aes_decrypt(SSN,'LLAVE_PRUEBA') as char(15)) as SSN_decifrado from informacion;




-- use biblioteca;
DELIMITER //
CREATE PROCEDURE EJ1()   
BEGIN   
DECLARE NUM INT default 1;   
DECLARE RES VARCHAR(50) default '';   
SET RES = '';   
WHILE NUM <=10 DO	   
SET RES = CONCAT(RES, NUM, ',');	   
SET NUM = NUM + 1;   
END WHILE;   
SELECT RES;
END 
//
CALL EJ1; -- LLAMAR A LA FUNCIÓN
DROP PROCEDURE EJ1; -- ELIMINAR LA FUNCIÓ









use Empresa;
-- Crear base de datos y usarla
CREATE DATABASE IF NOT EXISTS Empresa;
USE Empresa;

-- Crear tabla de vendedores
CREATE TABLE IF NOT EXISTS Vendedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla de ventas
CREATE TABLE IF NOT EXISTS Ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vendedor INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_vendedor) REFERENCES Vendedores(id)
);

-- Insertar algunos vendedores
INSERT INTO Vendedores (nombre) VALUES 
('Laura Gómez'),
('Carlos Pérez'),
('Ana Martínez');

-- Insertar algunas ventas
INSERT INTO Ventas (id_vendedor, cantidad, fecha) VALUES 
(1, 40, '2024-01-10'),
(1, 30, '2024-01-15'),
(2, 60, '2024-01-12'),
(2, 45, '2024-01-20'),
(3, 110, '2024-01-10');

-- Crear procedimiento para evaluar desempeño
DELIMITER //
CREATE PROCEDURE EvaluarDesempenoVendedor(IN vendedor_id INT)
BEGIN
    DECLARE totalVentas INT;
    -- Calcular total de ventas del vendedor
    SELECT SUM(cantidad) INTO totalVentas
    FROM Ventas
    WHERE id_vendedor = vendedor_id;
    -- Evaluar desempeño según el total
    IF totalVentas > 100 THEN
        SELECT 'Excelente vendedor' AS Resultado;
    ELSEIF totalVentas BETWEEN 50 AND 100 THEN
        SELECT 'Buen desempeño' AS Resultado;
    ELSE
        SELECT 'Debe mejorar' AS Resultado;
    END IF;
END;
//
DELIMITER ;

-- llamar el procedimiento para cada vendedor
CALL EvaluarDesempenoVendedor(2);







































-- Crear base de datos y seleccionarla
CREATE DATABASE IF NOT EXISTS EvaluacionVentas;
USE EvaluacionVentas;

-- Crear tabla de zonas con metas mensuales
CREATE TABLE IF NOT EXISTS Zonas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    meta_mensual INT
);

-- Crear tabla de vendedores asociados a una zona
CREATE TABLE IF NOT EXISTS Vendedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    zona_id INT,
    FOREIGN KEY (zona_id) REFERENCES Zonas(id)
);

-- Crear tabla de ventas asociadas a cada vendedor
CREATE TABLE IF NOT EXISTS Ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vendedor INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_vendedor) REFERENCES Vendedores(id)
);

-- Insertar zonas con sus metas mensuales
INSERT INTO Zonas (nombre, meta_mensual) VALUES
('Norte', 100),
('Sur', 150),
('Centro', 120);

-- Insertar vendedores asignados a cada zona
INSERT INTO Vendedores (nombre, zona_id) VALUES
('Laura Gómez', 1),
('Carlos Pérez', 2),
('Ana Martínez', 3),
('Pedro Ramírez', 2);

-- Insertar ventas realizadas por cada vendedor
INSERT INTO Ventas (id_vendedor, cantidad, fecha) VALUES
(1, 50, '2024-04-01'),
(1, 60, '2024-04-15'),
(2, 70, '2024-04-10'),
(2, 60, '2024-04-20'),
(3, 130, '2024-04-05'),
(4, 40, '2024-04-08');



-- Crear el procedimiento para evaluar si los vendedores cumplieron la meta mensual
DELIMITER //

CREATE PROCEDURE EvaluarMetasZona(IN mes VARCHAR(7))
BEGIN
    -- Declarar variables para recorrer los datos
    DECLARE done INT DEFAULT 0;
    DECLARE nombre_vendedor VARCHAR(100);
    DECLARE nombre_zona VARCHAR(50);
    DECLARE total_ventas INT;
    DECLARE meta INT;

    -- Definir cursor para obtener nombre del vendedor, zona, meta de la zona, y total de ventas en el mes
    -- La función COALESCE(valor, valor_predeterminado) devuelve:
    -- valor si no es NULL
    -- valor_predeterminado si sí es NULL
    
    DECLARE cur CURSOR FOR
        SELECT 
            Vendedores.nombre,
            Zonas.nombre,
            Zonas.meta_mensual,
            COALESCE(SUM(Ventas.cantidad), 0) AS total
        FROM Vendedores
        JOIN Zonas ON Vendedores.zona_id = Zonas.id
        LEFT JOIN Ventas ON Ventas.id_vendedor = Vendedores.id 
             AND DATE_FORMAT(Ventas.fecha, '%Y-%m') = mes
        GROUP BY Vendedores.id;

    -- Manejador para detectar fin del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir el cursor
    OPEN cur;

    -- Bucle para recorrer cada registro
    leer_loop: LOOP
        FETCH cur INTO nombre_vendedor, nombre_zona, meta, total_ventas;

        IF done THEN
            LEAVE leer_loop;
        END IF;

        -- Evaluar si el vendedor cumplió la meta
        IF total_ventas >= meta THEN
            SELECT 
                CONCAT(nombre_vendedor, ' - ', nombre_zona) AS VendedorZona,
                total_ventas AS Ventas,
                meta AS Meta,
                'Cumplió la meta' AS Resultado;
        ELSE
            SELECT 
                CONCAT(nombre_vendedor, ' - ', nombre_zona) AS VendedorZona,
                total_ventas AS Ventas,
                meta AS Meta,
                'No cumplió la meta' AS Resultado;
        END IF;
    END LOOP;

    -- Cerrar el cursor
    CLOSE cur;
END;
//

-- Restaurar el delimitador original
DELIMITER ;

-- Ejecutar el procedimiento para el mes de abril 2024
CALL EvaluarMetasZona('2024-04');


SELECT 
            Vendedores.nombre,
            Zonas.nombre,
            Zonas.meta_mensual,
            COALESCE(SUM(Ventas.cantidad), 0) AS total
        FROM Vendedores
        JOIN Zonas ON Vendedores.zona_id = Zonas.id
        LEFT JOIN Ventas ON Ventas.id_vendedor = Vendedores.id 
             AND DATE_FORMAT(Ventas.fecha, '%Y-%m') = '2024-04'
        GROUP BY Vendedores.id;