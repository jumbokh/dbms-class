以下整理了一組基於北風資料庫的資料集與練習題目，這些題目參考了之前 SQL 簡報中各類查詢的範例（例如單表查詢、連接查詢、分組聚集、嵌套查詢與集合查詢等），讓您可以依據北風資料庫來進行練習與學習。下列不僅附上題目說明，也提供參考的 SQL 解答範例（您可依實際情況調整）：

---

## 資料集概述

北風資料庫包含下列主要表格（部分已在建立腳本中定義）：

- **Categories**：產品類別（CategoryID、CategoryName、Description…）
- **Suppliers**：供應商（SupplierID、CompanyName、ContactName…）
- **Products**：產品（ProductID、ProductName、SupplierID、CategoryID、UnitPrice、UnitsInStock…）
- **Customers**：客戶（CustomerID、CompanyName、ContactName、Country…）
- **Employees**：員工（EmployeeID、LastName、FirstName、Title、ReportsTo…）
- **Orders**：訂單（OrderID、CustomerID、EmployeeID、OrderDate、ShipCountry…）
- **OrderDetails**：訂單明細（OrderID、ProductID、UnitPrice、Quantity、Discount）
- **Shippers**：運輸公司
- **Regions**、**Territories** 與 **EmployeeTerritories**：地區與業務區分配資料

---

## 練習題目與範例解答

### 題目 1：單表查詢
**題目描述：**  
查詢 Products 表中所有產品的產品名稱與單價。

**參考解答：**
```sql
SELECT ProductName, UnitPrice
FROM Products;
```

---

### 題目 2：計算欄位
**題目描述：**  
查詢每個產品的產品名稱，以及其庫存總價（單價 * 庫存數量）。

**參考解答：**
```sql
SELECT ProductName,
       UnitPrice * UnitsInStock AS TotalStockValue
FROM Products;
```

---

### 題目 3：條件查詢與 DISTINCT
**題目描述：**  
查詢 Suppliers 表中所有供應商所在的不同國家。

**參考解答：**
```sql
SELECT DISTINCT Country
FROM Suppliers;
```

---

### 題目 4：基本連接查詢
**題目描述：**  
查詢 Orders 表中所有訂單的訂單編號、訂單日期，以及對應客戶的公司名稱（需連接 Customers 表）。

**參考解答：**
```sql
SELECT O.OrderID, O.OrderDate, C.CompanyName
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID;
```

---

### 題目 5：多表連接查詢
**題目描述：**  
查詢產品資訊，要求同時顯示產品名稱、對應的類別名稱（Categories 表）與供應商的公司名稱（Suppliers 表）。

**參考解答：**
```sql
SELECT P.ProductName, C.CategoryName, S.CompanyName AS Supplier
FROM Products P
LEFT JOIN Categories C ON P.CategoryID = C.CategoryID
LEFT JOIN Suppliers S ON P.SupplierID = S.SupplierID;
```

---

### 題目 6：分組與聚集函數
**題目描述：**  
計算每個訂單的總銷售金額（訂單明細中以 UnitPrice、Quantity 與 Discount 計算：單價 × 數量 × (1 – 折扣)），並顯示訂單編號及總銷售金額。

**參考解答：**
```sql
SELECT OrderID, 
       SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalSale
FROM OrderDetails
GROUP BY OrderID;
```

---

### 題目 7：嵌套查詢（子查詢 IN）
**題目描述：**  
查詢下過 1997 年訂單的所有客戶（假設 Orders 表中的 OrderDate 為訂單日期）。

**參考解答：**
```sql
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE YEAR(OrderDate) = 1997
);
```

---

### 題目 8：嵌套查詢（比較運算符）
**題目描述：**  
查詢產品中單價高於所有產品平均單價的產品名稱及單價。

**參考解答：**
```sql
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);
```

---

### 題目 9：嵌套查詢（使用 IN 與多層子查詢）
**題目描述：**  
查詢包含產品名稱為 'Chai' 的訂單（假設 Products 表中有 'Chai' 這筆記錄），列出訂單編號與客戶編號。

**參考解答：**
```sql
SELECT OrderID, CustomerID
FROM Orders
WHERE OrderID IN (
    SELECT OrderID
    FROM OrderDetails
    WHERE ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chai')
);
```

---

### 題目 10：使用 EXISTS
**題目描述：**  
查詢至少下過一筆訂單的客戶，顯示其客戶編號與公司名稱。

**參考解答：**
```sql
SELECT CustomerID, CompanyName
FROM Customers C
WHERE EXISTS (
    SELECT 1
    FROM Orders O
    WHERE O.CustomerID = C.CustomerID
);
```

---

## 延伸練習

您也可以嘗試以下進階題目：

- **進階題目 A：自我連接查詢**  
  查詢 Employees 表中每位員工的姓名以及其上級員工的姓名。  
  *提示：需要自我連接 Employees 表。*  
  **參考解答：**
  ```sql
  SELECT E.FirstName AS Employee, M.FirstName AS Manager
  FROM Employees E
  LEFT JOIN Employees M ON E.ReportsTo = M.EmployeeID;
  ```

- **進階題目 B：集合查詢**  
  查詢同時下過訂單且有產品訂購記錄的客戶（利用 INTERSECT 或 IN/EXISTS 模擬交集）。  
  *提示：MySQL 不支援 INTERSECT，可用內部連接或 EXISTS 模型實現。*  
  **參考解答：**
  ```sql
  SELECT CustomerID, CompanyName
  FROM Customers
  WHERE CustomerID IN (
      SELECT DISTINCT CustomerID
      FROM Orders
  )
    AND CustomerID IN (
      SELECT DISTINCT CustomerID
      FROM Orders
      WHERE OrderID IN (
          SELECT OrderID
          FROM OrderDetails
      )
  );
  ```

---

這些練習題目涵蓋了北風資料庫中常見的查詢類型，您可以依據題目要求進行實作並觀察結果。透過這些實際操作，可幫助您熟悉 MySQL 語法轉換、資料表連接、聚集函數應用以及嵌套查詢等重點內容。希望這組練習題能對您學習 SQL 提供充分的實戰練習與啟發。
