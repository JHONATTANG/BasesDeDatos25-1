-- Se crea la base de datos del tour
# Create database Tour;

-- Se selecciona la base de datos
use Tour;

-- Creamos las tablas y dependencias

/*
create table Equipo(
	IdEquipo int primary key not null,
	Nombre varchar(50),
	Director varchar(100)
);

create table Ciclistas(
	IdCiclista int primary key not null,
	Nombre varchar(100) not null,
    FechaNacimiento date not null,
    CONSTRAINT CK_FechaNacimiento CHECK (
		YEAR('2025-01-01') - YEAR(FechaNacimiento) >=18
        AND YEAR('2025-01-01') - YEAR(FechaNacimiento) <=50
    ),
    PesoGr int,
    IdEquipo int not null,
	FOREIGN KEY (IdEquipo) REFERENCES Equipo(IdEquipo)
);

Create table Categoria(
	IdCategoria int not null primary key,
    TipoCategoria varchar(50) not null
);

Create table Ciudad(
	IdCiudad int not null primary key auto_increment,
    Ciudad varchar(200) not null
);

create table Etapa(
	NumEtapa int primary key auto_increment not null,
    Km int not null,
    IdCategoria int not null,
    Salida varchar(200) not null,
    Llegada varchar(200) not null,
    Fecha date not null,
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

create table Tramo(
	CodTramo varchar(10) not null primary key,
    Nombre varchar(200),
    Altura int not null,
    Distancia int not null,
    Etapa int not null,
    FOREIGN KEY (Etapa) REFERENCES Etapa(NumEtapa)
);

create table Camiseta(
	Codigo int not null primary key auto_increment,
    Color varchar(20) not null,
    Premio int not null,
    FOREIGN KEY (Premio) REFERENCES Categoria(IdCategoria)
);

create table Clasificacion(
	NumPuesto int auto_increment not null,
	UNIQUE(NumPuesto),
    IdCiclista int not null,
    FOREIGN KEY (IdCiclista) REFERENCES Ciclistas(IdCiclista),
    UNIQUE(IdCiclista),
    Pts int not null DEFAULT 0,
    HorasRec int not null default 0,
    MinRec int not null default 0,
    SegRec int not null default 0,
    HorasDif int not null default 0,
    MinDif int not null default 0,
    SegDig int not null default 0
);

create table Premios(
	IdPremio int not null primary key,
    IdCiclista int not null,
    Codigo int,
    NumEtapa int not null,
    FOREIGN KEY (IdCiclista) REFERENCES Ciclistas(IdCiclista),
    FOREIGN KEY (Codigo) REFERENCES Camiseta(Codigo),
    FOREIGN KEY (NumEtapa) REFERENCES Etapa(NumEtapa)
);

create table ClasificacionEtapa(
	NumPuesto int auto_increment not null primary key,
    IdCiclista int not null,
    FOREIGN KEY (IdCiclista) REFERENCES Ciclistas(IdCiclista),
    NumEtapa int not null,
    FOREIGN KEY (NumEtapa) REFERENCES Etapa(NumEtapa),
    Pts int not null DEFAULT 0,
    HorasRec int not null default 0,
    MinRec int not null default 0,
    SegRec int not null default 0
);
*/



#(2,2,3,now(), DATE_ADD(NOW(), INTERVAL 15 DAY)),

-- Ingresamos la data

/*
INSERT INTO Equipo
VALUES
(1001,'UAE TEAM EMIRATES','PAUL EMIRATES'),
(1002,'SOUDAL QUICK-STEP','ALEX SOUDAL'),
(1003,'TEAM VISMA','SARAH VISMA'),
(1004,'MOVISTAR TEAM','RICK MOV THIU'),
(1005,'PREMIER TECH','TECHI HUDJ'),
(1006,'INEOS GRENADIERS','HEAL GREN HAM'),
(1007,'LIDL-TREK','KIM YI JEM'),
(1008,'EF EDUCATION - EASYPOST','KIZMA SARABEN INAH');*/

/*
INSERT INTO Ciclistas
VALUES
(1,'TOM POGACAR','2005-05-20',86,1006),
(2,'JON VINGEGAARD','2001-08-25',84,1002),
(3,'RIM EVENEPOEL','1999-07-05',79,1003),
(4,'JONY ALMEIDA','1985-05-10',89,1004),
(5,'DON BALLERINI','1980-03-02',89,1003),
(6,'CAE BOL','1979-01-01',80,1003),
(7,'LEID MOZZATO','1996-05-09',71,1005),
(8,'ROY GHYS','1991-02-20',100,1004),
(9,'SAMUE DUJARDIN','1976-10-12',100,1002),
(10,'AIMA KRISTOFF','1990-10-05',77,1008),
(11,'NAIRO QUINTERO','1987-10-23',95,1004),
(12,'LOIS MARTINEZ','1982-06-24',95,1001),
(13,'LUBY DURBRIDGE','1985-12-07',89,1006),
(14,'JIDIKD DEGENKOLB','2001-10-09',80,1004),
(15,'CUAN BEYLLENS','1996-08-21',94,1005),
(16,'DE VAN POPPEL','2000-01-06',88,1002),
(17,'ALD DE LIE','1984-10-05',100,1002),
(18,'REX','1980-05-18',85,1008),
(19,'PAGE','1977-02-07',98,1004),
(20,'MEZGEC','1980-03-21',97,1005),
(21,'B TURNER','1996-02-12',99,1006),
(22,'P ALLEGAERT','2002-02-18',90,1005),
(23,'B GIRMAY','1984-11-25',99,1004),
(24,'P ACKERMANN','1980-05-03',87,1007),
(25,'M ARMDT','1995-08-22',84,1005),
(26,'N DENZ','1999-10-01',96,1003),
(27,'M VAN DEN BENI','2000-07-03',97,1008),
(28,'CUART LAPORTE','1999-05-09',72,1002),
(29,'R FIBBONS','2005-10-01',70,1002),
(30,'P LAPEIRA','1999-10-10',84,1006),
(31,'M MATTHEWS','1975-08-15',85,1006),
(32,'F GRELLIER','1984-09-18',100,1005),
(33,'K VAUQUELIN','1988-03-03',91,1002),
(34,'T GACHIGNARD','1988-08-24',96,1003),
(35,'MTEUNISSEN','2004-06-21',92,1003),
(36,'SGESCHKE','1996-10-10',87,1002),
(37,'BID VAN MOER','1980-10-02',76,1003),
(38,'M VAN DER POR','1975-07-29',84,1005),
(39,'C JUUL JENSEN','1995-08-15',83,1006),
(40,'R GARCIA PIERDE','1983-10-16',90,1005),
(41,'AND LAURENCE','2001-04-08',83,1001),
(42,'S BISSEGER','1975-07-10',88,1004),
(43,'C CHAMPOUSSIN','1975-04-29',94,1006),
(44,'C RUSSO','1998-03-27',70,1005),
(45,'M VERCHER','1978-04-03',71,1007),
(46,'B COQUARD','1987-06-04',74,1007),
(47,'R TILLER','1985-10-16',89,1007),
(48,'A TIRGOS','2003-01-31',76,1008),
(49,'G VERMEERSCH','1982-10-26',92,1008),
(50,'A ZINGLE','1986-07-27',90,1005);*/

/*
INSERT INTO Categoria
VALUES
(1,'LLANO'),
(2,'MEDIA MONTAÑA'),
(3,'CONTRARRELOJ INDIVIDUAL'),
(4,'MONTAÑA');*/

/*
INSERT INTO Ciudad (Ciudad)
VALUES
('LILLIE METROPOLE'),
('LAUWIN PLANQUE'),
('BOULOGNE SUR MER'),
('VALENCIENNES'),
('DUNKERQUE'),
('AMIENS METROPOLE'),
('ROUEN'),
('CAEN'),
('BAYEUX'),
('VIRE NORMANDIE'),
('SAINT MALO'),
('MUR DE BRETAGNE GUERLEDAN'),
('SAINT MEEN LE GRAND'),
('LAVAL ESPACE MAYENNE'),
('CHINON'),
('CHATEAUROUX'),
('ENNEZAT'),
('LE MONT DORE PUY DE SANCY');*/

/*
INSERT INTO Etapa (Km, IdCategoria,Salida,Llegada,Fecha)
VALUES
(185,1,1,1,'2025-04-16'),
(212,2,2,3,'2025-04-17'),
(178,1,4,5,'2025-04-18'),
(173,2,6,7,'2025-04-19'),
(33,3,8,8,'2025-04-20'),
(201,2,9,10,'2025-04-21'),
(194,2,11,12,'2025-04-22'),
(174,1,13,14,'2025-04-23'),
(170,1,15,16,'2025-04-24'),
(163,4,17,18,'2025-04-25');*/

/*
INSERT INTO Tramo
VALUES
('A1','Jaco',789,19,1),
('B1','Garv',848,173,1),
('C1','Herc',553,97,1),
('D1','Kevi',583,22,1),
('E1','Lise',297,37,1),
('A2','Ofil',190,104,2),
('B2','Waly',545,158,2),
('C2','Leon',336,156,2),
('D2','Gilb',327,124,2),
('E2','Ronn',778,28,2),
('A3','Jona',116,99,3),
('B3','Roch',200,80,3),
('C3','Coop',891,86,3),
('D3','Merl',181,113,3),
('E3','Denn',84,120,3),
('A4','Cand',469,28,4),
('B4','Natt',589,70,4),
('C4','Mile',859,22,4),
('D4','Tuck',635,122,4),
('E4','Core',231,196,4),
('A5','Napo',181,5,5),
('B5','Dony',295,135,5),
('C5','Lees',200,44,5),
('D5','Moll',881,67,5),
('E5','Samp',553,17,5),
('A6','Quee',297,114,6),
('B6','Maur',185,42,6),
('C6','Madd',168,97,6),
('D6','Sula',763,42,6),
('E6','Abbe',459,100,6),
('A7','Bell',952,185,7),
('B7','Sand',143,182,7),
('C7','Cros',246,132,7),
('D7','Mall',885,80,7),
('E7','Babs',124,23,7),
('A8','Giud',664,128,8),
('B8','Kris',349,53,8),
('C8','Luci',582,118,8),
('D8','Prud',236,183,8),
('E8','Pege',938,48,8),
('A9','Arma',752,147,9),
('B9','Saun',225,176,9),
('C9','Itch',786,109,9),
('D9','Lace',319,161,9),
('E9','Suza',59,129,9),
('A10','Evyh',996,166,10),
('B10','Melo',47,176,10),
('C10','Debr',833,200,10),
('D10','Bidd',985,130,10),
('E10','Andr',628,194,10);*/

/*
INSERT INTO Clasificacion (IdCiclista,Pts,HorasRec,MinRec,SegRec,HorasDif,MinDif,SegDig)
VALUES
(1,82,5,60,50,1,4,41),
(2,56,0,57,7,2,36,19),
(3,54,3,46,11,2,58,19),
(4,380,4,19,25,0,49,25),
(5,381,4,32,31,1,17,32),
(6,372,0,57,7,2,28,24),
(7,96,1,8,31,1,48,9),
(8,99,3,8,9,0,9,30),
(9,304,5,59,44,1,5,60),
(10,387,1,27,18,0,0,40),
(11,308,1,59,1,2,25,41),
(12,88,2,24,7,0,43,40),
(13,263,2,1,20,2,57,59),
(14,37,2,21,5,0,58,32),
(15,24,6,3,23,2,52,30),
(16,250,0,51,0,2,29,30),
(17,256,1,0,60,1,37,8),
(18,335,1,32,11,1,21,21),
(19,349,2,22,54,0,17,8),
(20,26,0,43,14,0,12,35),
(21,126,4,18,27,1,47,3),
(22,361,3,23,15,0,41,15),
(23,398,5,25,27,1,49,56),
(24,382,2,55,37,1,51,50),
(25,190,4,56,16,0,7,2),
(26,323,2,51,1,2,51,8),
(27,329,4,54,22,1,2,6),
(28,176,2,18,6,0,35,18),
(29,101,6,35,36,1,22,58),
(30,170,6,57,46,0,0,0),
(31,269,1,23,21,1,8,17),
(32,154,0,26,19,0,50,40),
(33,342,6,43,37,1,57,45),
(34,127,6,1,17,1,44,58),
(35,87,5,49,35,0,16,28),
(36,6,5,38,54,1,56,29),
(37,270,3,2,2,2,45,39),
(38,195,6,36,25,2,24,50),
(39,30,3,58,45,0,49,37),
(40,319,4,54,55,0,52,38),
(41,231,2,37,3,2,58,19),
(42,41,5,40,23,0,59,51),
(43,373,2,49,0,2,31,33),
(44,176,4,13,59,2,16,17),
(45,77,4,7,15,1,58,47),
(46,400,5,6,40,1,7,35),
(47,132,2,46,32,2,44,1),
(48,374,4,50,55,2,35,14),
(49,84,1,24,28,0,11,31),
(50,169,6,41,2,0,19,49);*/











INSERT INTO ClasificacionEtapa (IdCiclista, NumEtapa, Pts, HorasRec, MinRec, SegRec)
VALUES
-- ETAPA 1 (LLANO - 10,9,8,7,6) - Mismos ciclistas en etapas llanas
(1,1,10,4,15,0),   -- Ciclista dominante en llanos
(2,1,9,4,17,30),
(3,1,8,4,20,15),
(4,1,7,4,23,0),
(5,1,6,4,25,45),

-- ETAPA 2 (MEDIA MONTAÑA - 10,8,5,4,3)
(6,2,10,5,10,0),   -- Especialistas media montaña
(7,2,8,5,12,30),
(8,2,5,5,15,15),
(9,2,4,5,18,0),
(10,2,3,5,20,45),

-- ETAPA 3 (LLANO - Mismos 5 ciclistas)
(1,3,10,4,18,0),   -- Repiten líderes llanos
(2,3,9,4,20,30),
(3,3,8,4,22,15),
(4,3,7,4,25,0),
(5,3,6,4,27,45),

-- ETAPA 4 (MEDIA MONTAÑA - Mismos 5 ciclistas)
(6,4,10,5,8,0),    -- Repiten líderes media montaña
(7,4,8,5,10,30),
(8,4,5,5,13,15),
(9,4,4,5,16,0),
(10,4,3,5,18,45),

-- ETAPA 5 (CONTRARRELOJ - 5,4,3,2,1)
(21,5,5,1,10,0),   -- Especialistas contrarreloj
(22,5,4,1,12,30),
(23,5,3,1,15,15),
(24,5,2,1,18,0),
(25,5,1,1,20,45),

-- ETAPA 6 (MEDIA MONTAÑA)
(6,6,10,5,5,0),     -- Dominancia media montaña
(7,6,8,5,7,30),
(8,6,5,5,10,15),
(9,6,4,5,13,0),
(10,6,3,5,15,45),

-- ETAPA 7 (MEDIA MONTAÑA)
(6,7,10,5,2,0),    -- Mismo grupo líder
(7,7,8,5,4,30),
(8,7,5,5,7,15),
(9,7,4,5,10,0),
(10,7,3,5,12,45),

-- ETAPA 8 (LLANO)
(1,8,10,4,12,0),   -- Líderes llanos
(2,8,9,4,14,30),
(3,8,8,4,17,15),
(4,8,7,4,20,0),
(5,8,6,4,22,45),

-- ETAPA 9 (LLANO)
(1,9,10,4,9,0),    -- Dominación total llanos
(2,9,9,4,11,30),
(3,9,8,4,14,15),
(4,9,7,4,17,0),
(5,9,6,4,19,45),

-- ETAPA 10 (MONTAÑA - 20,15,10,8,5)
(46,10,20,6,30,0),  -- Mejores montaña
(47,10,15,6,33,30),
(48,10,10,6,37,15),
(49,10,8,6,40,0),
(50,10,5,6,43,45);








INSERT INTO Clasificacion (IdCiclista, Pts, HorasRec, MinRec, SegRec, HorasDif, MinDif, SegDig)
VALUES
-- Top 10 (Líderes por puntos y tiempo)
(1, 40, 150, 30, 0, 0, 0, 0),      -- Líder general
(6, 40, 150, 35, 15, 0, 5, 15),    -- Segundo por desempate
(2, 36, 150, 40, 30, 0, 10, 30),
(7, 32, 150, 45, 45, 0, 15, 45),
(3, 32, 150, 50, 0, 0, 20, 0),
(46, 20, 151, 0, 0, 0, 30, 0),     -- Mejor en montaña
(47, 15, 151, 10, 0, 0, 40, 0),
(4, 28, 151, 15, 0, 0, 45, 0),
(8, 20, 151, 20, 0, 0, 50, 0),
(5, 24, 151, 25, 0, 0, 55, 0),

-- Puestos 11-20
(9, 16, 151, 30, 0, 1, 0, 0),
(48, 10, 151, 35, 0, 1, 5, 0),
(10, 12, 151, 40, 0, 1, 10, 0),
(49, 8, 151, 45, 0, 1, 15, 0),
(21, 5, 151, 50, 0, 1, 20, 0),     -- Mejor contrarreloj
(50, 5, 151, 55, 0, 1, 25, 0),
(22, 4, 152, 0, 0, 1, 30, 0),
(23, 3, 152, 5, 0, 1, 35, 0),
(24, 2, 152, 10, 0, 1, 40, 0),
(25, 1, 152, 15, 0, 1, 45, 0),

-- Puestos 21-30 (Ciclistas sin puntos)
(11, 0, 160, 0, 0, 9, 30, 0),
(12, 0, 160, 5, 0, 9, 35, 0),
(13, 0, 160, 10, 0, 9, 40, 0),
(14, 0, 160, 15, 0, 9, 45, 0),
(15, 0, 160, 20, 0, 9, 50, 0),
(16, 0, 160, 25, 0, 9, 55, 0),
(17, 0, 160, 30, 0, 10, 0, 0),
(18, 0, 160, 35, 0, 10, 5, 0),
(19, 0, 160, 40, 0, 10, 10, 0),
(20, 0, 160, 45, 0, 10, 15, 0),

-- Puestos 31-40
(26, 0, 160, 50, 0, 10, 20, 0),
(27, 0, 160, 55, 0, 10, 25, 0),
(28, 0, 161, 0, 0, 10, 30, 0),
(29, 0, 161, 5, 0, 10, 35, 0),
(30, 0, 161, 10, 0, 10, 40, 0),
(31, 0, 161, 15, 0, 10, 45, 0),
(32, 0, 161, 20, 0, 10, 50, 0),
(33, 0, 161, 25, 0, 10, 55, 0),
(34, 0, 161, 30, 0, 11, 0, 0),
(35, 0, 161, 35, 0, 11, 5, 0),

-- Puestos 41-50
(36, 0, 161, 40, 0, 11, 10, 0),
(37, 0, 161, 45, 0, 11, 15, 0),
(38, 0, 161, 50, 0, 11, 20, 0),
(39, 0, 161, 55, 0, 11, 25, 0),
(40, 0, 162, 0, 0, 11, 30, 0),
(41, 0, 162, 5, 0, 11, 35, 0),
(42, 0, 162, 10, 0, 11, 40, 0),
(43, 0, 162, 15, 0, 11, 45, 0),
(44, 0, 162, 20, 0, 11, 50, 0),
(45, 0, 162, 25, 0, 11, 55, 0);










INSERT INTO Premios (IdPremio, IdCiclista, Codigo, NumEtapa)
VALUES
(1, 1, 1, 1),   -- Amarilla: Mejor general (ciclista 1)
(2, 21, 3, 5),  -- Verde: Mejor sprint/contrarreloj
(3, 46, 4, 10), -- Roja: Rey de la montaña
(4, 1, 2, 3);   -- Blanca: Más victorias (ciclista 1 con 4 etapas)

