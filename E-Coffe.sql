-- Veritaban�n� olu�tur
CREATE DATABASE ECoffe;
GO

-- Ecommerce veritaban�n� kullan
USE ECoffe;
GO

-- Users tablosunu olu�tur
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName NVARCHAR(50),
    Email NVARCHAR(100),
    RegistrationDate DATE
);
GO

-- Products tablosunu olu�tur
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT
);
GO

-- Orders tablosunu olu�tur
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    PaymentMethod NVARCHAR(50),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserID)
    REFERENCES Users(UserID)
);
GO

-- Addresses tablosunu olu�tur
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    UserID INT,
    AddressLine1 NVARCHAR(100),
    AddressLine2 NVARCHAR(100),
    City NVARCHAR(50),
    PostalCode NVARCHAR(20),
    CONSTRAINT FK_Addresses_Users FOREIGN KEY (UserID)
    REFERENCES Users(UserID)
);
GO

-- Payments tablosunu olu�tur
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentStatus NVARCHAR(50),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);
GO

-- �rnek verileri ekle
INSERT INTO Users (UserID, UserName, Email, RegistrationDate)
VALUES (1, 'Ahmet Kaya', 'ahmetkaya@gmail.com', '2023-01-01'),
       (2, 'Ahmet Furkan Eker', 'ahmetfurkaneker@gmail.com', '2023-02-01');

INSERT INTO Products (ProductID, ProductName, UnitPrice, UnitsInStock)
VALUES (1, 'Kahve', 10.99, 50),
       (2, 'Latte', 20.99, 100),
       (3, '�ay', 5.99, 20),
       (4, 'Americano', 15.99, 75);

INSERT INTO Orders (OrderID, UserID, OrderDate, TotalAmount, PaymentMethod)
VALUES (1, 1, '2023-03-01', 50.99, 'Credit Card'),
       (2, 2, '2023-03-02', 35.99, 'PayPal');

INSERT INTO Addresses (AddressID, UserID, AddressLine1, AddressLine2, City, PostalCode)
VALUES (1, 1, 'Osmaniye', 'Merkez', 'Fak�u�a��', '80000'),
       (2, 2, 'Adana', 'Merkez', '�ukurova', '01010');

INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentStatus)
VALUES (1, 1, '2023-03-02', 50.99, 'Completed'),
       (2, 2, '2023-03-03', 35.99, 'Completed');
GO

-- Sipari� ve kullan�c� bilgilerini birle�tiren karma��k bir sorgu
SELECT o.OrderID, o.OrderDate, o.TotalAmount, u.UserName, a.AddressLine1, a.City
FROM Orders o
INNER JOIN Users u ON o.UserID = u.UserID
INNER JOIN Addresses a ON o.UserID = a.UserID;
GO

-- �r�nleri stok durumuna g�re s�ralayan karma��k bir sorgu
SELECT ProductName, UnitPrice, UnitsInStock,
    CASE
        WHEN UnitsInStock > 50 THEN 'In Stock'
        WHEN UnitsInStock > 0 THEN 'Limited Stock'
        ELSE 'Out of Stock'
    END AS StockStatus
FROM Products
ORDER BY CASE
    WHEN UnitsInStock > 50 THEN 1
    WHEN UnitsInStock > 0 THEN 2
    ELSE 3
END;
GO

-- Sakl� procedure (stored procedure) �rne�i
CREATE PROCEDURE GetOrdersByUser
    @UserID INT
AS
BEGIN
    SELECT o.OrderID, o.OrderDate, o.TotalAmount, u.UserName, p.PaymentStatus
    FROM Orders o
    INNER JOIN Users u ON o.UserID = u.UserID
    LEFT JOIN Payments p ON o.OrderID = p.OrderID
    WHERE o.UserID = @UserID;
END;
GO

-- Sakl� procedure'� �a��rma
EXEC GetOrdersByUser 1;
GO

-- Tablo de�eri i�levi (table-valued function) �rne�i
CREATE FUNCTION GetProductsByPriceRange
    (@MinPrice DECIMAL(10,2),
     @MaxPrice DECIMAL(10,2))
RETURNS TABLE
AS
RETURN (
    SELECT ProductName, UnitPrice, UnitsInStock,
        CASE
            WHEN UnitsInStock > 50 THEN 'In Stock'
            WHEN UnitsInStock > 0 THEN 'Limited Stock'
            ELSE 'Out of Stock'
        END AS StockStatus
    FROM Products
    WHERE UnitPrice BETWEEN @MinPrice AND @MaxPrice
);
GO

-- Tablo de�eri i�levini kullanma
SELECT *
FROM dbo.GetProductsByPriceRange(5.00, 15.00);
GO

-- K�s�tlamalar� ekleme
ALTER TABLE Users
ADD CONSTRAINT CK_Users_Email CHECK (Email LIKE '%@%');

ALTER TABLE Addresses
ADD CONSTRAINT DF_Addresses_AddressLine2 DEFAULT '' FOR AddressLine2;

ALTER TABLE Payments
ADD CONSTRAINT CK_Payments_Amount CHECK (Amount > 0);
