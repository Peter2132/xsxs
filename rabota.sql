CREATE TABLE OC(
ID_OC serial PRIMARY KEY 

 );
 
insert into OC(Name12)
values
('Android'),
('MUIU'),
('iOS'),
('Fire OS'),
('Аврора');

select * from OC;
select Name12 from OC;
select * from OC where Name12 = 'MUIU';

delete from OC
where Name12 = 'iOS';

UPDATE OC
SET Name12 = 'Update'
WHERE Name12 = 'Android';

 CREATE TABLE BatteryCapacity(
ID_BatteryCapacity serial PRIMARY KEY

 );
 
insert into BatteryCapacity(Name2)
values
(4900),
(3200),
(4500),
(3900),
(6000),
(4100),
(5000);

select * from BatteryCapacity;
 
DELETE FROM BatteryCapacity
WHERE Name2 = 3200;

UPDATE BatteryCapacity
SET Name2 = 7000
WHERE Name2 = 4900;

CREATE TABLE Memory(
ID_Memory serial PRIMARY KEY

 );
 
insert into Memory(Name4)
values 
('128 ГБ'),
('256 ГБ'),
('64 ГБ'),
('32 ГБ'),
('16 ГБ');
 
select * from Memory;

delete from Memory
where Name4 = '256 ГБ';

UPDATE Memory
SET Name4 = 'Update'
WHERE Name4 = '128 ГБ';


CREATE TABLE Manufacturer(
ID_Manufacturer serial PRIMARY KEY

 );
 
insert into Manufacturer(Name3)
values
('Xiaomi'),
('Sumsung'),
('Apple'),
('Huawei'),
('Microsoft');

select * from Manufacturer;

delete from Manufacturer
where Name3 = 'Sumsung';

UPDATE Manufacturer
SET Name3 = 'Update'
WHERE Name3 = 'Xiaomi';

CREATE TABLE ServiceCenter(
ID_ServiceCenter serial PRIMARY KEY,
	OC_ID INT NOT NULL,
	BatteryCapacity_ID INT NOT NULL,
	Memory_ID INT NOT NULL,
	Manufacturer_ID INT NOT NULL,
	FOREIGN KEY (OC_ID) REFERENCES OC(ID_OC),
	FOREIGN KEY (BatteryCapacity_ID) REFERENCES BatteryCapacity(ID_BatteryCapacity),
	FOREIGN KEY (Memory_ID) REFERENCES Memory(ID_Memory),
	FOREIGN KEY (Manufacturer_ID) REFERENCES Manufacturer(ID_Manufacturer)

 );
 
insert into Primer(OC_ID,BatteryCapacity_ID,Memory_ID,Manufacturer_ID,Name5)
values
(1,1,3,4,'OC'),
(1,1,3,4,'BatteryCapacity'),
(4,1,3,4,'Memory'),
(5,1,3,4,'Manufacturer'),
(5,1,3,4,'Color');

select * from Primer;

delete from Primer
where Name5 = 'BatteryCapacity';

UPDATE Primer
SET Name5 = 'Update'
WHERE Name5 = 'OC';

ALTER TABLE Primer
ADD Name5 varchar(29);

ALTER TABLE Memory
ADD Name4 varchar(25);

ALTER TABLE OC
ADD Name12 varchar(20);
ALTER TABLE OC
ADD CONSTRAINT ConstraintName CHECK (ID_OC > 0);

ALTER TABLE BatteryCapacity
ADD Name2 varchar(21);
ALTER TABLE BatteryCapacity
ALTER COLUMN Name2 SET DATA TYPE INT USING Name2::INT;



ALTER TABLE Manufacturer
ADD Name3 varchar(30);
ALTER TABLE Manufacturer
DROP COLUMN Name3;
ALTER TABLE Manufacturer
ADD Name3 varchar(30);

ALTER TABLE ServiceCenter RENAME TO Primer;

SELECT Primer.Name5, OC.Name12 
FROM Primer
INNER JOIN OC ON Primer.OC_ID = OC.ID_OC; 

SELECT Primer.Name5, OC.Name12 
FROM Primer
RIGHT JOIN OC ON Primer.OC_ID = OC.ID_OC;

SELECT Primer.Name5, OC.Name12 
FROM Primer
LEFT JOIN OC ON Primer.OC_ID = OC.ID_OC;

SELECT Primer.Name5, OC.Name12 
FROM Primer
FULL JOIN OC ON Primer.OC_ID = OC.ID_OC;
 
 