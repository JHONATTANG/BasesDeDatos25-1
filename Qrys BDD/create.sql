-- Clase 26/03/2025

create database Base2603;
Use Base2603;

create table TABLA_EJEMPLO(
	ID INT auto_increment primary key,
    NOMBRE VARCHAR(100) NOT NULL,
    CURSO SMALLINT NOT NULL,
    GRUPO VARCHAR(2) NOT NULL,
    FECHA_INGRESO DATE DEFAULT '1000-01-01'
    #Default: la variable debe estar en el rango 
);

show tables;
show create table TABLA_EJEMPLO;


create table alumnos (
	id int not null primary key auto_increment,
    nombre varchar(10) not null,
    apellido varchar(10) not null
);
create table salones (
	id int not null primary key auto_increment,
    grupo varchar(10) not null,
    ubicacion varchar(10) not null
);

-- agregar campo idsalon
alter table alumnos add column idsalon int not null after id;

-- definir la llave foranea, enlazar con la tabla salones
-- y establecer el mecanismo de actualizacion 
alter table alumnos add constraint FK_idsalon foreign key (idsalon)
references salones (id) on delete cascade on update cascade;

-- comandos
/*
show tables; muestra tablas de la bd
show create table nombreTabla -- muestra la instruccion para crear dicha tabla
Show columns from NombreTabla -- muestra las columnas
rename table Original TO Nueva -- renombrar
Alter Table NombreTabla ADD NombreCampo TipoDato -- agregar campo
Alter Table NombreTabla Change Nombre Original Campo Nuevo Nombre NUEVO TIPO DE DATO; .-- 1Modificar campo
Alter table Nombre Tabla Drop Column Nombre de la columna -- Elimina columna 
*/