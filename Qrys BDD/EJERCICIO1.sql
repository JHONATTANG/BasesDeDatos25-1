-- Libros, Usuarios, Prestamos



-- create database LIBRERIA;

use LIBRERIA;
/*
CREATE TABLE DIRECTORIO (
	IDDirectorio INT primary key,
	Direccion VARCHAR(50),
	Telefono INT
);

CREATE TABLE USUARIOS (
	IDUsuario INT primary key,
	NombreUsuario VARCHAR(50),
	IDDirectorio INT,	
	FOREIGN KEY (IDDirectorio) REFERENCES DIRECTORIO(IDDirectorio)
);

CREATE TABLE LIBROS (
	IDLibro INT primary key auto_increment,
	NombreLibro VARCHAR(200),
	Categoria VARCHAR(50)
);

CREATE TABLE PRESTAMOS (
	IDPrestamo INT primary key auto_increment,
	IDLibro INT,
	IDUsuario INT,	
    FechaPrestamo datetime,
    FechaDevolucion datetime,
	FOREIGN KEY (IDLibro) REFERENCES LIBROS(IDLibro),
    FOREIGN KEY (IDUsuario) REFERENCES USUARIOS(IDUsuario)
);

CREATE TABLE DISPONIBILIDAD(
	IDPrestamo int,
	IDLibro int,
	Estado bool,
    FOREIGN KEY (IDPrestamo) REFERENCES PRESTAMOS(IDPrestamo),
    FOREIGN KEY (IDLibro) REFERENCES LIBROS(IDLibro)
);

*/

/*
-- DIRECTORIO, USUARIO, LIBRO, PRESTAMOS, DISPONIBILIDAD
INSERT INTO DIRECTORIO 
VALUES
(1001,'Bogota cra 11 #22-3',4701225),
(1002,'Bogota cra 11 bis #40-2',6702225),
(1003,'Bogota cll 13 #52-2',7703225),
(1004,'Bogota dgn 3 #50-2',8704225),
(3001,'Medellin cra 13 #2-30',3711215);
*/
/*
INSERT INTO USUARIOS
VALUES
(1,'Jhonattan Gonzalez',1001),
(2,'Leider Cordero',1004),
(3,'Micaela Coy',3001),
(4,'Henry Hernandez',1001);
*/
/*
INSERT INTO LIBROS
VALUES
(1,'Aplicaciones de Telecomunicaciones','Tecnología'),
(2,'Como preparar comidas navideñas','Cocina'),
(3,'La Biología para gardo Décimo','Ciencias'),
(4,'Los laberintos de la mente','Psicología'),
(5,'Tecnura','Tecnología');
*/
/*
INSERT INTO PRESTAMOS
VALUES
(1,1,1,now(), DATE_ADD(NOW(), INTERVAL 8 DAY)),
(2,2,3,now(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
(3,4,2,now(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
(4,5,4,now(), DATE_ADD(NOW(), INTERVAL 8 DAY));
*/
/*
INSERT INTO DISPONIBILIDAD
VALUES
(1,1,TRUE),
(2,2,TRUE),
(3,4,TRUE),
(4,5,TRUE);
*/

SELECT * FROM USUARIOS ;
SELECT * FROM LIBROS ;
SELECT * FROM PRESTAMOS ;
SELECT * FROM DISPONIBILIDAD ;
SELECT * FROM DIRECTORIO ;
