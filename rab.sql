CREATE TABLE Passports(
    ID_Passport serial PRIMARY KEY UNIQUE
);

Alter table passports
add Name1 varchar(30);

insert into passports (Name1)
values
('Rossiskiy'),
('Nemezkiy'),
('Moldovskiy');

select * from passports

update Passports set Name1 = 'angliskiy' 
where ID_Passport = 1;


CREATE TABLE Positions(
    ID_Position serial PRIMARY KEY UNIQUE
);

Alter table Positions
add Name2 varchar(25);


insert into Positions (Name2)
values
('Kassir'),
('Prepodavatel'),
('Medik');

select * from Positions





CREATE TABLE Departments(
    ID_Department serial PRIMARY KEY UNIQUE
);

Alter table Departments
add Name3 varchar(26);

insert into Departments (Name3)
values
('Sbita'),
('Otdel Kadrov'),
('Otdel Kachestva');

select * from Departments







CREATE TABLE Staffs(
    ID_Staff serial PRIMARY KEY,
   	ID_Passport INT UNIQUE REFERENCES Passports(ID_Passport),
    ID_Position INT UNIQUE REFERENCES Positions(ID_Position)
);

Alter table Staffs
add Name4 varchar(24);
Alter table Staffs
add Name41 varchar(20);

insert into Staffs (Name4, Name41)
values
('Kirill',1000),
('Artem', 2000),
('Oleg', 3000);

select * from Staffs




CREATE TABLE Staffs_Departments(
    ID_Staff INT REFERENCES Staffs(ID_Staff),
    ID_Department INT REFERENCES Departments(ID_Department),
    PRIMARY KEY (ID_Staff, ID_Department)
);







