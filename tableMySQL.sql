create database P50722;

use P50722;

create table Pasports(
	ID_Pasport int primary key auto_increment,
    seriesPass varchar(4)not null,
    numberPass varchar(6) not null,
    datePass date,
    WhoVidan varchar(100) not null
    );
create table Employess(
	ID_Employee int primary key auto_increment,
    firstname varchar(25) not null,
    surname varchar(25) not null,
    middlename varchar(25) default('-'),
    Pasport_ID int not null unique,
    foreign key (Pasport_ID) references Pasports(ID_Pasport),
    Position_ID int not null,
    foreign key (Position_ID) references Positions(ID_Position)
);



create table Positions(
	ID_Position int primary key auto_increment,
    NamePositions varchar(60) not null unique,
    
    Salary float not null
);

create table Otdels(
	ID_Otdel int primary key auto_increment,
    NameOtdel varchar(80) unique
);

create table EmployessOtdels(
	ID_EmployessOtdels int primary key auto_increment,
    Employess_ID int not null,
    Otdel_ID int not null,
    foreign key (Employess_ID) references Employess(ID_Employee),
    foreign key (Otdel_ID) references Otdels(ID_Otdel)
);