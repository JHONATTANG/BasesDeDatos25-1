create database base204;
use base204;

create table Clientes (
	ClienteID int primary key not null auto_increment,
	NombreCliente varchar(50),
	Contacto int
);

create table Pedidos (
	PedidoID int primary key not null,
	ClienteID int,
	Factura int,
	FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

INSERT INTO Clientes (NombreCliente,Contacto)
VALUES
('Marco Aurelio',456443552),
('Lydia Johana',445332221),
('Ebbe',488982635),
('Sofia Mariona',412436773);

INSERT INTO Pedidos
VALUES
(234,4,160),
(235,2,48),
(236,3,64),
(237,4,92);


#inner join, se seleccionantdas ls filas de dos campos donde se haya realiado una busqueda

select * from clientes;
select * from Pedidos;

Select Clientes.NombreCliente, Pedidos.PedidoID
From Clientes
INNER JOIN Pedidos On Clientes.ClienteID = Pedidos.ClienteID
Order By Clientes.NombreCliente;

## Left join

Select Clientes.NombreCliente, Pedidos.PedidoID
From Clientes
Left Join Pedidos On Clientes.ClienteID = Pedidos.ClienteID
Order By Clientes.NombreCliente;


Select Clientes.NombreCliente, Pedidos.PedidoID
From Clientes
Right Join Pedidos On Clientes.ClienteID = Pedidos.ClienteID
Order By Clientes.NombreCliente;

Select Clientes.NombreCliente, Pedidos.PedidoID
From Pedidos 
Right Join Clientes On Clientes.ClienteID = Pedidos.ClienteID
Order By Clientes.NombreCliente;



Select Clientes.NombreCliente, Pedidos.PedidoID
From Clientes Outer Join Pedidos On Clientes.ClienteID = Pedidos.ClienteID;



Select Clientes.NombreCliente, Pedidos.PedidoID
From Clientes
Left Join Pedidos On Clientes.ClienteID = Pedidos.ClienteID
Union
Select Clientes.NombreCliente, Pedidos.PedidoID
From Clientes
Right Join Pedidos On Clientes.ClienteID = Pedidos.ClienteID
Order By Clientes.NombreCliente;
