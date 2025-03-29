DROP DATABASE IF EXISTS northwind;
CREATE DATABASE northwind DEFAULT CHARSET=utf8;
USE northwind;

DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS EmployeeTerritories;
DROP TABLE IF EXISTS Territories;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Regions;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Shippers;
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Categories;

-- 1. Categories 表
CREATE TABLE Categories (
  CategoryID INT NOT NULL AUTO_INCREMENT,
  CategoryName VARCHAR(15) NOT NULL,
  Description TEXT,
  Picture MEDIUMBLOB,
  PRIMARY KEY (CategoryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2. Customers 表
CREATE TABLE Customers (
  CustomerID CHAR(5) NOT NULL,
  CompanyName VARCHAR(40) NOT NULL,
  ContactName VARCHAR(30),
  ContactTitle VARCHAR(30),
  Address VARCHAR(60),
  City VARCHAR(15),
  Region VARCHAR(15),
  PostalCode VARCHAR(10),
  Country VARCHAR(15),
  Phone VARCHAR(24),
  Fax VARCHAR(24),
  PRIMARY KEY (CustomerID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 3. Employees 表
CREATE TABLE Employees (
  EmployeeID INT NOT NULL AUTO_INCREMENT,
  LastName VARCHAR(20) NOT NULL,
  FirstName VARCHAR(10) NOT NULL,
  Title VARCHAR(30),
  TitleOfCourtesy VARCHAR(25),
  BirthDate DATETIME,
  HireDate DATETIME,
  Address VARCHAR(60),
  City VARCHAR(15),
  Region VARCHAR(15),
  PostalCode VARCHAR(10),
  Country VARCHAR(15),
  HomePhone VARCHAR(24),
  Extension VARCHAR(4),
  Photo LONGBLOB,
  Notes TEXT,
  ReportsTo INT,
  PhotoPath VARCHAR(255),
  PRIMARY KEY (EmployeeID),
  CONSTRAINT fk_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES Employees(EmployeeID)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 4. Shippers 表
CREATE TABLE Shippers (
  ShipperID INT NOT NULL AUTO_INCREMENT,
  CompanyName VARCHAR(40) NOT NULL,
  Phone VARCHAR(24),
  PRIMARY KEY (ShipperID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 5. Suppliers 表
CREATE TABLE Suppliers (
  SupplierID INT NOT NULL AUTO_INCREMENT,
  CompanyName VARCHAR(40) NOT NULL,
  ContactName VARCHAR(30),
  ContactTitle VARCHAR(30),
  Address VARCHAR(60),
  City VARCHAR(15),
  Region VARCHAR(15),
  PostalCode VARCHAR(10),
  Country VARCHAR(15),
  Phone VARCHAR(24),
  Fax VARCHAR(24),
  HomePage TEXT,
  PRIMARY KEY (SupplierID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 6. Products 表
CREATE TABLE Products (
  ProductID INT NOT NULL AUTO_INCREMENT,
  ProductName VARCHAR(40) NOT NULL,
  SupplierID INT,
  CategoryID INT,
  QuantityPerUnit VARCHAR(20),
  UnitPrice DECIMAL(19,4) DEFAULT 0.00,
  UnitsInStock SMALLINT DEFAULT 0,
  UnitsOnOrder SMALLINT DEFAULT 0,
  ReorderLevel SMALLINT DEFAULT 0,
  Discontinued TINYINT(1) NOT NULL,
  PRIMARY KEY (ProductID),
  CONSTRAINT fk_Products_Supplier FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_Products_Category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 7. Regions 表
CREATE TABLE Regions (
  RegionID INT NOT NULL,
  RegionDescription VARCHAR(50) NOT NULL,
  PRIMARY KEY (RegionID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 8. Territories 表
CREATE TABLE Territories (
  TerritoryID CHAR(20) NOT NULL,
  TerritoryDescription VARCHAR(50) NOT NULL,
  RegionID INT NOT NULL,
  PRIMARY KEY (TerritoryID),
  CONSTRAINT fk_Territories_Region FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 9. EmployeeTerritories 表
CREATE TABLE EmployeeTerritories (
  EmployeeID INT NOT NULL,
  TerritoryID CHAR(20) NOT NULL,
  PRIMARY KEY (EmployeeID, TerritoryID),
  CONSTRAINT fk_EmployeeTerritories_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_EmployeeTerritories_Territory FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 10. Orders 表
CREATE TABLE Orders (
  OrderID INT NOT NULL AUTO_INCREMENT,
  CustomerID CHAR(5),
  EmployeeID INT,
  OrderDate DATETIME,
  RequiredDate DATETIME,
  ShippedDate DATETIME,
  ShipVia INT,
  Freight DECIMAL(19,4) DEFAULT 0.00,
  ShipName VARCHAR(40),
  ShipAddress VARCHAR(60),
  ShipCity VARCHAR(15),
  ShipRegion VARCHAR(15),
  ShipPostalCode VARCHAR(10),
  ShipCountry VARCHAR(15),
  PRIMARY KEY (OrderID),
  CONSTRAINT fk_Orders_Customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_Orders_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_Orders_Shipper FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 11. OrderDetails 表
CREATE TABLE OrderDetails (
  OrderID INT NOT NULL,
  ProductID INT NOT NULL,
  UnitPrice DECIMAL(19,4) NOT NULL,
  Quantity SMALLINT NOT NULL,
  Discount FLOAT NOT NULL,
  PRIMARY KEY (OrderID, ProductID),
  CONSTRAINT fk_OrderDetails_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_OrderDetails_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
