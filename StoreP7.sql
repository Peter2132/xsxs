CREATE TABLE Clients(
 ID_Client SERIAL PRIMARY KEY,
 ClientSurname VARCHAR(50) NOT NULL,
 ClientName VARCHAR(50) NOT NULL,
 ClientMIddleName VARCHAR(50) NOT NULL,
 Email VARCHAR (100) NOT NULL UNIQUE,
 PhoneNumber VARCHAR(11) NOT NULL UNIQUE
);


INSERT INTO Clients(ClientSurname,ClientName,ClientMIddleName,Email,PhoneNumber)
VALUES
('Ваня','Ушаков','Анечкин','vadim@m.ru','4352352353'),
('Кирилл','Петров','Петрович','katimov@gmail.com','4325355233'),
('Андрей','Ульянов','Ульянович','lavrov@mpt.ru','44738956743');


CREATE TABLE Products(
	ID_Product SERIAL PRIMARY KEY,
	ProductName VARCHAR (100) NOT NULL,
	Price DECIMAL (10,2) NOT NULL
);


INSERT INTO Products(ProductName,Price)
VALUES
('Маркерная доска', 300.78),
('Мышка', 95000.00),
('Ноутбук', 599.99);


CREATE TABLE Orders(
	ID_Order SERIAL PRIMARY KEY,
	OrderDate DATE NOT NULL,
	Client_ID INT NOT NULL REFERENCES Clients(ID_Client)
);


INSERT INTO Orders(OrderDate,Client_ID)
VALUES
('18.12.2022',1 ),
('24.02.2023', 2),
('01.01.2024', 3);


CREATE TABLE OrderDetails(
	ID_OrderDetail SERIAL PRIMARY KEY,
	Order_ID INT NOT NULL REFERENCES Orders(ID_Order),
	Product_ID INT NOT NULL REFERENCES Products(ID_Product),
	Amount INT DEFAULT(1)
);


INSERT INTO OrderDetails(Order_ID,Product_ID,Amount)
VALUES
(1,2,2 ),
(1,3, 2),
(2, 1, 3),
(3 , 2,1);

CREATE OR REPLACE VIEW OrderClientView AS
SELECT Orders.OrderDate AS "Дата",
	Clients.ClientSurname || ' ' || LEFT(Clients.ClientName, 1) || '. ' ||
	LEFT(Clients.ClientMiddleName, 1) || '. ' AS "Фамилия и инициалы",
	'Почта: ' || Clients.Email || ' Телефон: ' || Clients.PhoneNumber
	AS "Контактная информация"
FROM Orders
INNER JOIN Clients ON Orders.client_ID = Clients.id_client;

SELECT * FROM OrderClientView;

CREATE OR REPLACE VIEW OrderClientView AS
SELECT Orders.OrderDate AS "Дата",
	Clients.ClientSurname || ' ' || LEFT(Clients.ClientName, 1) || '. ' ||
	LEFT(Clients.ClientMiddleName, 1) || '. ' AS "Фамилия и инициалы",
	'Почта: ' || Clients.Email || ' Телефон: ' || Clients.PhoneNumber
	AS "Контактная информация",
	COUNT(*) AS "Количество повторений"
FROM Orders
INNER JOIN Clients ON Orders.client_ID = Clients.id_client
GROUP BY OrderDate, ClientSurname, ClientName , ClientMiddleName, Email ,PhoneNumber;

SELECT * FROM OrderClientView;

CREATE VIEW ProductVIEW AS 
SELECT Products.ProductName AS "нАЗВАНИЯ ПРОДУКТА",
    'Цена без скидки: ' || Products.Price || 
    'Цена со скидкой 50%: ' || 
    ROUND(Products.Price * 0.5, 2) AS "Цена"
FROM Products;

SELECT * FROM ProductVIEW;





CREATE OR REPLACE PROCEDURE AddProductProcedure(
	IN ProductNamePR VARCHAR(100),
	IN PricePR DECIMAL(10,2)


)
LANGUAGE plpgsql -- язык процедур
AS $$ --начало тела процедуры
BEGIN -- начало блока кода процедуры
	INSERT INTO Products(ProductName,Price)
	VALUES (ProductNamePR,PricePR);
END $$;


CALL AddProductProcedure (
	'Машинка',
	1234.12
);

SELECT * FROM Products;




CREATE OR REPLACE PROCEDURE UpdateProductProcedure(
	IN ProductNamePR VARCHAR(100),
	IN PricePR DECIMAL(10,2),
	IN IDproduct INT

)
LANGUAGE plpgsql -- язык процедур
AS $$ --начало тела процедуры
BEGIN -- начало блока кода процедуры
	UPDATE Products
	SET ProductName = UpdateProductProcedure.ProductNamePR, Price = UpdateProductProcedure.PricePR
	WHERE ID_Product = UpdateProductProcedure.IDproduct;
END $$;

CALL UpdateProductProcedure (
	'ПУЛЬТ',
	12.00,
	4
);

SELECT * FROM Products;



CREATE OR REPLACE PROCEDURE DeleteProductProcedure(
	IN IDProduct INT


)

LANGUAGE plpgsql -- язык процедур
AS $$ --начало тела процедуры
BEGIN -- начало блока кода процедуры
	DELETE FROM Products
	WHERE ID_Product = IDProduct;
END $$;

CALL DeleteProductProcedure(4);



CREATE OR REPLACE FUNCTION GetProductsFunction (
	ProductNameFun VARCHAR(100)
)
RETURNS TABLE (ProductName VARCHAR(100), Price DECIMAL(10,2))
LANGUAGE plpgsql -- язык процедур
AS $$ --начало тела процедуры
BEGIN -- начало блока кода процедуры
	RETURN QUERY
	SELECT Products.ProductName, Products.Price FROM Products
	WHERE Products.ProductName = ProductNameFun;
END $$;

SELECT * FROM GetProductsFunction('Мышка');


CREATE OR REPLACE FUNCTION CountClients()
RETURNS INT
LANGUAGE plpgsql
AS $$
	DECLARE Counts INT;
BEGIN
	SELECT COUNT(*) INTO Counts FROM Clients;
	RETURN Counts;
END $$;

SELECT CountClients();



CREATE OR REPLACE FUNCTION ProfitStoreFunction()
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
    DECLARE Profit DECIMAL(10,2);
BEGIN
    SELECT SUM (OrderDetails.Amount * Products.Price) INTO Profit FROM OrderDetails
    INNER JOIN Products ON OrderDetails.Product_ID = Products.ID_Product;
    RETURN Profit;
END $$;

SELECT ProfitStoreFunction();

CREATE OR REPLACE FUNCTION ProfitTrigger()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	RAISE NOTICE 'Прибыль: %', ProfitStoreFunction();
	RETURN NULL;
	--RETURN NEW;
	--RETURN OLD;
END $$;

CREATE OR REPLACE TRIGGER ProfitTrigger
AFTER DELETE
ON OrderDetails
FOR EACH ROW
--FOR EACH STATEMENT
EXECUTE FUNCTION ProfitTrigger();


INSERT INTO OrderDetails(Order_ID,Product_ID,Amount)
VALUES
(1,1,2 ),
(2,2, 3)
SELECT * FROM OrderDetails;

DELETE FROM OrderDetails
WHERE id_orderdetail = 6;


CREATE OR REPLACE FUNCTION AmountTrigger()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	IF NEW.Amount <= 0 THEN
		RAISE EXCEPTION 'Кол-во должно быть больше 0:';
	END IF;
	
	RETURN NULL;
END $$;

CREATE OR REPLACE TRIGGER AmountTrigger
AFTER INSERT
ON OrderDetails
FOR EACH ROW
EXECUTE FUNCTION AmountTrigger();

INSERT INTO OrderDetails(Order_ID,Product_ID,Amount)
VALUES
(1,1,-2 ),
(2,2, 3)
SELECT * FROM OrderDetails;

















