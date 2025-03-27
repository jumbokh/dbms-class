USE northwind 

-- 飲料庫存總量
SELECT c.CategoryName, SUM(p.UnitsInStock) 庫存總量, avg(p.UnitsInStock) 平均數
FROM Categories c
INNER JOIN Products p ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'
GROUP BY c.CategoryName

--各種類的庫存狀況
SELECT c.CategoryName [種類], p.ProductName [物品名稱], p.UnitsInStock [庫存]
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'

--農產品庫存 + 平均庫存 + 最大最小平均差
SELECT c.CategoryName, SUM(p.UnitsInStock) AS 庫存, avg(p.UnitsInStock) AS 平均, MAX(p.UnitsInStock) 最大,MIN(p.UnitsInStock) 最小, STDEV(p.UnitsInStock)
FROM Categories c
INNER JOIN Products p ON c.categoryID = p.categoryID
WHERE c.CategoryName = 'Produce'
GROUP BY c.CategoryName

-- 1996年 銷售總額
SELECT c.CategoryName 類別, ROUND(SUM(od.Quantity * (1-od.Discount)* od.UnitPrice),2) 銷售總額
FROM Categories c
JOIN Products p ON p.CategoryID = c.CategoryID
JOIN [ORDER Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
WHERE c.CategoryName = 'Beverages' AND Datepart(YEAR,o.OrderDate)='1996'
GROUP BY c.CategoryName

-- 展示類別 (用group by)
SELECT c.CategoryName
FROM Products p
JOIN Categories c ON c.CategoryID=p.CategoryID
GROUP BY c.CategoryName

-- 展示類別 (用distinct)
SELECT DISTINCT c.CategoryName
FROM Categories c

--1996年 超過15比以上訂單 員工
SELECT e.EmployeeID [編號], e.LastName [名稱], COUNT(o.CustomerID) [訂單數]
FROM orders o
JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE DATEPART(YEAR, o.OrderDate) = '1996'
GROUP BY e.EmployeeID, e.LastName
HAVING COUNT(o.CustomerID) > 14
ORDER BY e.EmployeeID

--1996年 超過15比以上訂單 員工
SELECT e.EmployeeID [編號], e.LastName [名稱], COUNT(*) [訂單數]
FROM orders o
JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1996-01-01' AND '1996-12-31'
GROUP BY e.EmployeeID, e.LastName
HAVING COUNT(*) > 14
ORDER BY e.EmployeeID

-- 各類別庫存
SELECT c.CategoryName [類別], SUM(p.UnitsInStock) [庫存], MIN(p.UnitsInStock) [最小庫存], MAX(p.UnitsInStock) [最大庫存]
FROM Products p
INNER JOIN Categories c ON p.CategoryID= c.CategoryID
GROUP BY c.CategoryName

--加拿大 員工與客戶訂單的統計
SELECT EmployeeID, CustomerID,  COUNT(OrderID) 訂單數量
FROM [Orders Qry]
WHERE country IN('Canada')
GROUP BY EmployeeID, CustomerID
WITH ROLLUP

--加拿大 員工與客戶訂單的統計 家小計總計
SELECT isnull(CONVERT(nvarchar,EmployeeID),N'總計') AS EmployeeID, ISNULL(CustomerID, N'小計') AS CustomerID, COUNT(OrderID) 訂單數量
FROM [Orders Qry]
WHERE country IN('Canada')
GROUP BY EmployeeID, CustomerID
WITH ROLLUP

--加拿大 員工與客戶訂單的統計 家小計總計
SELECT isnull(CONVERT(nvarchar,EmployeeID),N'總計') AS EmployeeID, ISNULL(CustomerID, N'小計') AS CustomerID, COUNT(OrderID) 訂單數量
FROM [Orders]
WHERE shipcountry IN('Canada')
GROUP BY EmployeeID, CustomerID
WITH ROLLUP

-- 員工訂單 + 業績
SELECT e.EmployeeID, e.LastName, COUNT(o.OrderID) [訂單],ROUND(SUM( od.Quantity * ( 1 - od.Discount) *od.UnitPrice),0) 業績
FROM Employees e
JOIN Orders o ON o.EmployeeID=e.EmployeeID
JOIN [ORDER Details] od ON od.OrderID = o.OrderID
GROUP BY e.EmployeeID, e.LastName

2/8
USE northwind
GO


--查詢客戶訂單及供應商的資料，只會顯示有有訂單的客戶
SELECT DISTINCT c.CompanyName AS customers, p.ProductName , s.CompanyName 供應商
FROM Customers c
JOIN Orders o ON c.CustomerID=o.CustomerID
JOIN [ORDER Details] od ON o.OrderID = od. OrderID
JOIN Products p ON od.ProductID = p. ProductID
JOIN Suppliers s ON p.SupplierID=s.SupplierID
GROUP BY c.CompanyName, p.ProductName, s.CompanyName

--同上 (錯誤)但包含沒有客戶訂單的資料
SELECT c.CompanyName, s.CompanyName
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN [ORDER Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
JOIN Suppliers s ON s.SupplierID = p.SupplierID
GROUP BY c.CompanyName,s.CompanyName
ORDER BY s.CompanyName

--同上 但包含沒有客戶訂單的資料
SELECT c.CompanyName, s.CompanyName
FROM Customers c
LEFT JOIN ( Orders o
JOIN [ORDER Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
JOIN Suppliers s ON s.SupplierID = p.SupplierID )
 ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName,s.CompanyName
ORDER BY s.CompanyName

--連結自身 找出住在相同城市的員工
SELECT a.EmployeeID, a.FirstName, a.City, b.EmployeeID, b.FirstName, b.City
FROM Employees a
JOIN Employees b ON a.City = b.City
WHERE a.EmployeeID > b.EmployeeID

--self join 員工與主管關係表 (示範用right 顯示右邊b 資料表基底的全部員工ID，請與下面參照)
SELECT a.EmployeeID, a.FirstName, b.EmployeeID [主管ID], b.FirstName
FROM Employees a
RIGHT JOIN Employees b ON  b .EmployeeID = a.ReportsTo

--self join 員工與主管關係表 (正確)
SELECT a.EmployeeID, a.FirstName, b.EmployeeID [主管ID], b.FirstName
FROM Employees a
LEFT JOIN Employees b ON  b .EmployeeID = a.ReportsTo

SELECT MAX(OrderDate) FROM Orders
SELECT MIN(OrderDate) FROM Orders


--最早的第一筆訂單產品 與最新的一筆訂單產品 (訂單編號 + 訂單日期 + 產品)
SELECT
o.OrderID 訂單編號,
CONVERT(VARCHAR, o.OrderDate, 111) 訂單日期,
p.ProductName 產品
FROM Orders o
JOIN [ORDER Details] od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
WHERE o.OrderDate = (SELECT MAX(OrderDate) FROM Orders)
OR  o.OrderDate = (SELECT MIN(OrderDate) FROM Orders)
ORDER BY o.OrderDate

