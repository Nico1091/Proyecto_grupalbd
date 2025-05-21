create database BancoDB;
use BancoDB;
select *  from Cliente;
create table Sucursal (
    Id int auto_increment,
    Nombre varchar(30) not null,
    Direccion varchar(50) not null,
    Ciudad varchar(30) not null,
    Codigo_postal varchar(10),
    Telefono varchar(10),  
    primary key (Id),
    constraint Sucursal_UC unique(Nombre, Direccion)
);
insert into Sucursal values
(1,'Bancolombia_1','Av 15 cll 20 10-14','Bogota','0101','3217493247'),
(2,'Bancolombia_2','Av 17 cll 15 20-10','Medellin','0102','3246789076'),
(3,'Bancolombia_3','Av 20 cll 17 08-15','Cali','0103','3457890983'),
(4,'Bancolombia_4','Av 27 cll 30 15-09','Cucuta','0104','3759203048'),
(5,'Bancolombia_5','Av 30 cll 27 18-20','Barranquilla','0105','3238495020');


create table Departamento (
    Id int auto_increment,
    Nombre varchar(30) not null,
    Descripcion varchar(200),
    primary key(Id),
    constraint Departamento_UC unique(Nombre)
);

insert into Departamento values
(1,'Credito y prestamos','Solicitudes y aprobacion de prestamos Clientes individuales y empresas'),
(2,'Cuentas y depositos','Administrar cuentas corriente,ahorro y depositos'),
(3,'Tesoreria','Gestionar Flujo de efectivo e inversionnes'),
(4,'Atencion al cliente','Gestionar relaciones con los clientes quejas consultas y reclamaciones'),
(5,'Recursos Humanos','Gestionar personal y autorizar contratacion,formacion,desarrollo y bienestar de los empleados');
select * from Cliente;
delete  from Cliente where Nombre = 'Jose Perez';
create table Cargo (
    Id int auto_increment,	
    Nombre varchar(70) not null,
    Descripcion varchar(300),
    Departamento_Id int,
    primary key(Id),
    constraint Empleado_Cargo_FK foreign key(Departamento_id) references Departamento(Id),
    constraint  Cargo_UC unique(Nombre)
);
insert into Cargo values
(1,'oficial de credito','Asesora los clientes sobre productos crediticios',1),
(2,'Gerente de credito','Supervisa el proceso de otrorgar credito y prestamos',1),
(3,'Analista de credito','Evalua y analiza el proceso para otorgar creditos al cliente ademas de realizar informes',1),
(4,'Gerente de cuentas','Supervisa operaciones relacionadas  con las cuentas  del cliente',2),
(5,'Ejecutivo de cuentas','Asiste a los clientes en apertura y administracion de cuentas bancarias  ademas de explicar las opciones que ofrece el banco para el rano y uso de las mismas',2),
(6,'Asesor de cuentas','Asesora personalmente a los clientes para escoger la cuenta adaptada a sus necesidades ademas de mostrar tasas de interes  y tarifas acorde al uso de las mismas',2),
(7,'Tesoreria General','Supervisa la liquidez de las inversionnes Bancarias',3),
(8,'Gerente de tesoreria','Gestionas las inversiones y transacciones en los mercados coordina operaciones diarias y se asegura de la liquidez bancaria',3),
(9,'Trader de tesoreria','Ejecuta operaciones en el mercado financiero,compra y vende activos como bonos y divisas y otros instrumentos para gestionar riesgos  y mejorar rentabilidad',3),
(10,'Gerente de servicio al cliente','Supervisa la calidad de atencion al cliente a partir del personal ademas de establecer politicas y procedimientos para mejorar la satisfacion al cliente',4),
(11,'Representante de atencion al cliente','Punto de contacto con el cliente en fisico o de manera virtual,Atiende consultas  sobre productos y servicios,cuentas bancarias,tarjetas de credito y prestamos',4),
(12,'Asesor de servicio al cliente','Ofrece asesoramiennto personalizado a los clientes para la comprension de sus propias inversiones ademas de ofrecer soluciones y recomendaciones adecuadas al usuario',4),
(13,'Director de recursos Humanos','Responsable de la gestion global, define la estrategia de recursos humanos,se alinea con las necesidades de los empleados',5),
(14,'Gerente de recursos Humanos','Supervisa las operaciones diarias del departamento de Recursos Humanos(RR.HH),se encarga de implementar politicas de contratacion formacion y compensacion, Gestionamiento de relaciones en el area empresarial',5),
(15,'Especialista en reclutamiento y seleccion','Gestiona todo el proceso de contratacion desde la busqueda de candidatos hasta laentrevista y seleccion,Colabora  con los departamenntos del banco para verificar el personal que le es requerido',5); 



create table Cliente (
	Id int auto_increment,
    Nombre varchar(20) not null,
    Apellido varchar(20) not null,
    Cedula varchar(20) not null ,
    Direccion varchar(30),
    Telefono varchar(10),
    Correo varchar(20),
    Fecha_registro date not null default(current_date()),
    primary key(Id),
    constraint Cliente_UC Unique(Cedula)
);
use bancodb;
select * from Cliente;
delete from Cliente where Nombre='j	';
insert into Cliente values
(1,'Carlos','Villagram','1234567890','Av 15 cll 23 casa 10-13','2475938042','eudue@gmail.com',current_date()),
(2,'Jorge','Guzman','2467758930','Av 3 cll 14 casa 28-30','2638493028','Jorge2@gmail.com',current_date()),
(3,'Andres','Valcarcel','2385940274','Av 5 cll 27  casa 29-42','2647834750','Andres@gmail.com',current_date()),
(4,'Luis','Casanares','2536789356','Av 10 cll 32 casa 34-50','3547382916','Luis@gmail.com',current_date()),
(5,'Mario','Quinatanilla','3347289301','Av 23 cll 37 casa 63-73','3427646728','Mario@gmail.com',current_date());

create table Empleado (
    Id int auto_increment ,
    Nombre varchar(20) not null,
    Apellido varchar(20) not null,
    Cedula varchar(10) not null,
    Puesto varchar(30),
    Salario integer(8),
    Fecha_Contratacion date not null default(current_date()),
    Cargo_Id INT,
    primary key(Id),
    constraint Empleado_UC unique(Cedula),
    constraint Empleado_Cargo_FK foreign key(Cargo_id) references Cargo(Id)
);
select * from cliente;
insert into Empleado values
(1,'Jose','Casanares','3425167283','Oficial de credito',5000000,current_date(),1);
insert into Empleado values
(2,'Luis','Bedoya','3678902671','Gerente de credito',4000000,current_date(),2);
insert into Empleado values
(3,'Angel','Villareal',3547725367,'Analista de credito',2039999,current_date(),3);
insert into Empleado values
(4,'Pedro','Cardenas',3648593784,'Gerente de cuentas',6000000,current_date(),4);
insert into Empleado values
(5,'Andres','Escobar',3546783922,'Ejecutivo de cuentas',5000000,current_date(),5);
insert into Empleado values
(6,'Jaime','Pedraza','3657848932','Asesor de cuentas',2000000,current_date(),6);
insert into Empleado values
(7,'Jorge','Aleman',3546728931,'Tesoreria general',2536000,current_date(),7);
insert into Empleado values
(8,'Carlos','Brand',3789037380,'Gerente de tesoreria',2333444,current_date(),8);
insert into Empleado values
(9,'Juan','Conriquez',3546783679,'Trader de tesoreria',3455431,current_date(),9);
insert into Empleado values
(10,'Andrea','Guzman',3547378290,'Gerente de servicio al cliente',34667890,current_date(),10);
insert into Empleado values
(11,'Freimer','Escamilla',3456782923,'Representante de atencion al cliente',4562343,current_date(),11);
insert into Empleado values
(12,'Sebastian','Alarcon',3457890267,'Asesor de servicio al cliente',4536678,current_date(),12);
insert into Empleado values
(13,'Lina','Tejeiro',3567489567,'Director de recursos humanos',2436893,current_date(),13);
insert into Empleado values
(14,'Roller','Sierra',3567890456,'Gerente de recursos Humanos',2349098,current_date(),14);
insert into Empleado values
(15,'Carla','Camacaro',3456789098,'Especialista en reclutamiento y seleccion',3600000,current_date(),15);

SELECT COUNT(*) AS 'Todas la sucursales' FROM Sucursal;

SELECT COUNT(*) AS Total, 'Sucursales' AS Tipo FROM Sucursal
UNION ALL
SELECT COUNT(*) AS Total, 'Departamentos' AS Tipo FROM Departamento;
use bancodb;

create table Sucursal_Departamento (
    Sucursal_Id int,
    Departamento_Id int,
    constraint Sucursal_FK foreign key(Sucursal_Id) references Sucursal(Id),
    constraint Departamento_FK foreign key(Departamento_Id) references Departamento(Id)
);
select * from Cliente;	
delete  from Cliente where id=17;
insert into Sucursal_Departamento values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);
create table Cuenta (
    Id int auto_increment ,
    Numero_Cuenta varchar(20) not null,
    Tipo_Cuenta enum('Ahorros', 'Corriente') not null,
    Saldo integer,
    Fecha_Apertura date not null default (current_date()),
    Cliente_Id int,
    Sucursal_Id int,
    primary key(Id),
    constraint Cuenta_UC unique(Numero_Cuenta),
    constraint Cuenta_Cliente_FK foreign key (Cliente_Id) references Cliente(Id),
    constraint Cuenta_Sucursal_FK foreign key(Sucursal_Id) references Sucursal(Id)
);
alter table cuenta change Saldo Saldo integer;
insert into Cuenta values 
(1,'125','Ahorros',36000000,current_date(),1,1),
(2,'877','Corriente',78000000,current_date(),2,2),
(3,'925','Ahorros',800000000,current_date(),3,3),
(4,'720','Corriente',100000,current_date(),4,4),
(5,'160','Corriente',200000,current_date(),5,5);


create table Transaccion (
    Id int auto_increment ,
    Tipo_Transaccion enum('Deposito', 'Retiro', 'Transferencia') not null,
    Monto integer,
    Fecha_Transaccion timestamp default current_timestamp,
    Cliente_id INT,
    Cuenta_Destino_Id INT,
    Primary Key(Id),
    constraint Transaccion_Cliente_FK foreign key(Cliente_id) references Cliente(Id),
    constraint Transaccion_Cuenta_Destino_FK foreign key(Cuenta_Destino_Id) references Cuenta(Id)
);
drop table Transaccion;
insert into Transaccion values
(1,'Transferencia',24000000,current_date(),1,2),
(2,'Retiro',200000,current_date(),2,2),
(3,'Deposito',20000000,current_date(),3,3),
(4,'Transferencia',100000,current_date(),4,2),
(5,'Retiro',1000000,current_date(),5,5);



create table Prestamo (
    Id int auto_increment,
    Monto integer,
    Tasa_Interes integer,
    Fecha_Inicio date not null,
    Fecha_Fin date not null,
    Cuenta_Id int,
    primary key(Id),
    constraint Prestamo_Cuenta_FK foreign key(Cuenta_Id) references Cuenta(Id)
);

insert into Prestamo values
(1,400000,10,current_date,'2025-12-17 01:05:00',1),
(2,30000,20,current_date(),'2024-11-10 08:06:00',2),
(3,2000000000,15,current_date(),'2030-11-10 12:05:00',3),
(4,200,0,current_date(),current_date(),4),
(5,300000,12,current_date(),'2024-11-17 08:00:00',5);
select * from Cliente;


create table Tarjeta_Credito (
    Id int auto_increment,
    Numero_Tarjeta varchar(20) not null unique,
    Limite_Credito integer,
    Fecha_Emision date not null,
    Fecha_Expiracion date not null,
    Cuenta_Id int,
    primary key(Id),
    constraint Tarjeta_Credito_Cuenta_FK foreign key (Cuenta_Id) references Cuenta(Id)
);
insert into Tarjeta_credito values
(1,'000333111',400000,current_date(),'2030-11-10 12:05:00',1),
(2,'000444222',5048494,current_date(),'2030-11-10 12:05:00',2),
(3,'000555777',5474955312,current_date(),'2030-11-10 12:05:00',3),
(4,'222000788',37485956,current_date(),'2030-11-10 12:05:00',4),
(5,'444000000',38585,current_date(),'2030-11-10 12:05:00',5);



DELIMITER //

CREATE TRIGGER Un_Gerente_Por_Sucursal
BEFORE INSERT ON Empleado
FOR EACH ROW
BEGIN
    DECLARE num_gerentes INT;
    DECLARE gerente_cargo_id INT;
    
    -- Obtener el cargo_id del Gerente solo una vez
    SELECT Id INTO gerente_cargo_id 
    FROM Cargo 
    WHERE Nombre LIKE '%Gerente%';
    
    -- Solo hacer la verificación si el nuevo empleado es un Gerente
    IF NEW.Cargo_Id = gerente_cargo_id THEN
        SELECT COUNT(*) INTO num_gerentes
        FROM Empleado
        WHERE Cargo_Id = gerente_cargo_id
          AND Id IN (SELECT Sucursal_Id FROM Cuenta WHERE Id = NEW.Id);
        
        IF num_gerentes >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Solo puede haber un gerente por sucursal';
        END IF;
    END IF;
END;
//
DELIMITER ;

DELIMITER //

CREATE TRIGGER Limite_Cuentas_Por_Cliente
BEFORE INSERT ON Cuenta
FOR EACH ROW
BEGIN
    DECLARE num_cuentas INT;
    
    -- Contar el número de cuentas existentes del mismo tipo en la misma sucursal para el cliente
    SELECT COUNT(*) INTO num_cuentas
    FROM Cuenta
    WHERE Cliente_Id = NEW.Cliente_Id
      AND Tipo_Cuenta = NEW.Tipo_Cuenta
      AND Sucursal_Id = NEW.Sucursal_Id;
      
    -- Verificar si el cliente ya tiene 3 cuentas del mismo tipo en la misma sucursal
    IF num_cuentas >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un cliente no puede tener más de 3 cuentas del mismo tipo en la misma sucursal';
    END IF;
END;
//
DELIMITER ;

