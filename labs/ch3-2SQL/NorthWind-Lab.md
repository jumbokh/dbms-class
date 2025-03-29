以下是根據上述 customers 資料表結構（欄位包含 id、company、last_name、first_name、email_address、job_title、business_phone、home_phone、mobile_phone、fax_number、address、city、state_province、zip_postal_code、country_region、web_page、notes、attachments）調整後的練習題與參考解答：

---

## 練習題目

### 題目 1：單表查詢  
**題目描述：**  
查詢 customers 資料表中所有客戶的公司名稱、聯絡人（姓、名）以及所在城市與國家。  

**參考解答：**
```sql
SELECT company, last_name, first_name, city, country_region
FROM customers;
```

---

### 題目 2：條件查詢  
**題目描述：**  
查詢所在城市為 "Seattle" 的客戶，並顯示其公司名稱、聯絡人姓名及電話（business_phone）。  

**參考解答：**
```sql
SELECT company, CONCAT(first_name, ' ', last_name) AS full_name, business_phone
FROM customers
WHERE city = 'Seattle';
```

---

### 題目 3：使用 LIKE 進行模糊查詢  
**題目描述：**  
查詢公司名稱中含有 "Company" 字串的所有客戶，並顯示公司名稱與聯絡人姓名。  

**參考解答：**
```sql
SELECT company, CONCAT(first_name, ' ', last_name) AS full_name
FROM customers
WHERE company LIKE '%Company%';
```

---

### 題目 4：排序查詢  
**題目描述：**  
查詢所有客戶，並依照 last_name 升序排列；若 last_name 相同，再依照 first_name 升序排列。  

**參考解答：**
```sql
SELECT id, company, last_name, first_name, city
FROM customers
ORDER BY last_name ASC, first_name ASC;
```

---

### 題目 5：統計函數  
**題目描述：**  
查詢 customers 資料表中客戶的總數。  

**參考解答：**
```sql
SELECT COUNT(*) AS total_customers
FROM customers;
```

---

### 題目 6：計算衍生欄位  
**題目描述：**  
查詢每筆客戶記錄，並產生一個新的欄位 full_name，結合 first_name 與 last_name。  

**參考解答：**
```sql
SELECT id, company, CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;
```

---

### 題目 7：更新資料  
**題目描述：**  
將 city 為 "Seattle" 的客戶，其 state_province 更新為 "WA"。  

**參考解答：**
```sql
UPDATE customers
SET state_province = 'WA'
WHERE city = 'Seattle';
```

---

### 題目 8：嵌套查詢  
**題目描述：**  
查詢至少有相同 city 的其他客戶（例如，假設給定客戶 id 為 1 的城市），顯示這些客戶的公司名稱與城市。  
*提示：利用子查詢取得 id 為 1 的客戶所在城市，再找出該城市其他客戶。*

**參考解答：**
```sql
SELECT company, city
FROM customers
WHERE city = (
    SELECT city
    FROM customers
    WHERE id = 1
) AND id <> 1;
```

---

### 題目 9：刪除資料  
**題目描述：**  
刪除郵遞區號 (zip_postal_code) 為空字串的客戶記錄。  

**參考解答：**
```sql
DELETE FROM customers
WHERE zip_postal_code = '';
```

---

### 題目 10：集合查詢（使用 UNION 模擬）  
**題目描述：**  
查詢來自 "USA" 或 "Canada" 的客戶，分別查詢兩組結果後利用 UNION 合併，顯示公司名稱及國家。  
*提示：MySQL 支援 UNION，不需特殊處理。*

**參考解答：**
```sql
SELECT company, country_region
FROM customers
WHERE country_region = 'USA'
UNION
SELECT company, country_region
FROM customers
WHERE country_region = 'Canada';
```

---

以上練習題涵蓋了單表查詢、條件查詢、模糊查詢、排序、統計、衍生欄位、資料更新、嵌套查詢、刪除以及集合查詢等基本操作。  
請依此資料表結構直接複製各題 SQL 指令，在您的 MySQL/MariaDB 環境中練習與測試。
