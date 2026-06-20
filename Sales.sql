CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    Phone VARCHAR(20),
    Debt DECIMAL(10,2)
);

INSERT INTO Customers (CustomerID, CustomerName, City, Phone, Debt) VALUES
(1, 'Mohamed Ali', 'Cairo', '01012345678', 5000),
(2, 'Mona Hassan', 'Giza', NULL, 15000),
(3, 'Ahmed Sami', 'Alexandria', '01234567890', 2000),
(4, 'Sara Adel', 'Cairo', '01198765432', 0),
(5, 'Magdy Farouk', 'Luxor', NULL, 8000);

-- جدول المنتجات
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, CategoryID, Price, Stock) VALUES
(1, 'Laptop', 1, 15000, 5),
(2, 'Mouse', 1, 200, 50),
(3, 'Keyboard', 1, 800, 30),
(4, 'Chair', 2, 1200, 15),
(5, 'Desk', 2, 5000, 8),
(6, 'Monitor', 3, 7000, 12),
(7, 'USB Cable', 3, 100, 100);

-- جدول الفئات
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Categories (CategoryID, CategoryName, City) VALUES
(1, 'Electronics', 'Cairo'),
(2, 'Furniture', 'Giza'),
(3, 'Accessories', 'Cairo');

-- جدول الطلبات
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Total) VALUES
(1, 1, '2026-03-01', 500),
(2, 2, '2026-03-05', 300),
(3, 3, '2026-03-10', 700),
(4, 1, '2026-03-15', 450);
ALTER TABLE Orders
ADD Total DECIMAL(10,2);
-- جدول تفاصيل الطلبات
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 4, 1),
(4, 3, 3, 1),
(5, 4, 5, 1),
(6, 4, 6, 2);



--1.	Show all customer data. 
select * from Customers
--2.	Show only customer names. 
select CustomerName from Customers
--3.	Show all products with a price greater than 1000. 
select * from products 
where price>1000
--4.	Show customers whose debts are in Cairo or Giza. 
select CustomerName from Customers 
WHERE city IN ('Cairo', 'Giza');
--5.	Show products with a price between 500 and 10000. 
select * from products 
WHERE price between 500 and 10000;
--6.	Show the first 2 products with the highest price. 
select * from products 
SELECT TOP 2 * FROM Products ORDER BY price DESC;
--7.	Show customers whose names begin with the letter M. 

select CustomerName from Customers 
WHERE CustomerName LIKE 'M%';
--8.	Show products with category_id = 1 or category_id = 3. 

select * from products 
where CategoryID =1 or CategoryID =3

SELECT * FROM Products
WHERE CategoryID IN (1, 3);
--9.	Show products with a stock greater than 10 and a price less than 10000.

select * from products 
WHERE stock > 10
AND price < 10000;
--10.	Show customers whose phone number is NULL. 

select * from Customers
where  phone is null
--_______________________________
_________
--Part 3: Aggregate Functions + Grouping
--11.	Calculate the total spending for each customer. 

SELECT CustomerID,
       SUM(Total) AS total_spending
FROM Orders
GROUP BY CustomerID;
--12.	Show customers who spent more than 10,000. 

SELECT CustomerName ,
       SUM(o.total) AS total_spending
FROM Customers c
join Orders o
on c.CustomerID =o.CustomerID
GROUP BY CustomerName
HAVING SUM(o.total) > 10000; 

--13.	Calculate the average price of products in each category. 
select p.CategoryID ,avg (p.Price) from Products p
group by p.CategoryID

--14.	Show the number of orders for each customer. 
select * from orders 
select * from customers 

select o.CustomerID ,count (o.OrderID) as total_orders from Orders o
group by o.CustomerID
--15.	Show customer names with the total for all their orders. 
SELECT c.CustomerName,
       SUM(o.Total) AS total_orders
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;
--16.	Show all customers with all their orders, even if they have no orders. 
select * from Customers

select * from Orders

SELECT c.CustomerName,
       o.OrderID
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;




--17.	Show all products with all orders that include them (cross join). 

SELECT *
FROM Products
CROSS JOIN Orders;
--18.	Show customers who have no orders 

SELECT *
FROM Customers

SELECT *
FROM Orders

select  c.CustomerID ,c.CustomerName ,o.OrderID
FROM Customers  c
LEFT JOIN  Orders o 
on c.CustomerID = o.CustomerID
where o.OrderID is null

--________________________________________
--Part 5: String / Number / Date Functions
--19.	Show all customer names in uppercase. 
SELECT UPPER(CustomerName) AS upper_name
FROM Customers c

--20.	Show the length of each customer name. 

SELECT len(CustomerName) AS length_name
FROM Customers c

--21.	Show the price of products rounded to the nearest whole number. 

select   ROUND(Price, 0) AS rounded_price from Products p
--22.	Show the difference between today's date and the order date. 

select   * from orders o
SELECT OrderID,
       DATEDIFF(DAY, OrderDate, GETDATE()) AS days_diff
FROM Orders;

--23.	Show the order date in 7 days.

SELECT OrderID,
       DATEADD(DAY, 7, GETDATE()) AS days_diff
FROM Orders;

--________________________________________
--Part 6: Data Manipulation
--24.	Add a new customer. 
select * from  Customers
INSERT INTO Customers (CustomerID,CustomerName, City, Phone, Debt)
VALUES (6,'Mohamed', 'Cairo', '01014546662', 5000);

--25.	Update the price of a specific product. 
UPDATE Products
SET Price = 500
WHERE ProductID = 1;

--26.	Delete a specific customer. 

DELETE FROM Customers
WHERE CustomerID = 5;
--27.	Add an age column to the customers table. 

DELETE FROM Customers
WHERE CustomerID = 5;
--28.	Clear all OrderDetails data. 
select * from OrderDetails
TRUNCATE TABLE OrderDetails;


--________________________________________
--Part 7: Set Operators
--29.	Show all cities + all categories (UNION).
select * from customers 
select * from Categories 

select c.City from customers c
UNION
select c.CategoryName from Categories  c

--30.	Show duplicate cities (UNION ALL). 

SELECT City FROM Customers
UNION ALL
SELECT City FROM Customers;
--31.	Show cities that exist only in Customers (EXCEPT). 

SELECT City FROM Customers
EXCEPT
SELECT CategoryName FROM Categories;

--32.	Show cities shared by both Customers and Categories (INTERSECT). 

SELECT City FROM Customers
INTERSECT
SELECT cat.City FROM Categories cat;
