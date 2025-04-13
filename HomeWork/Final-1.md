以下是一個根據 **Northwind 資料庫** 結構所設計的 **1NF → BCNF 規範化練習題目**，學生可以從非規範化資料表出發，逐步進行規範化：

---

## 🌟【資料庫規範化練習題】— Northwind 題型

### 題目：非規範化訂單表（Unnormalized Order Table）

公司正在使用如下格式的訂單紀錄表格來追蹤客戶訂單：

| OrderID | OrderDate | CustomerName | CustomerAddress | ProductList                                          |
|---------|-----------|---------------|------------------|------------------------------------------------------|
| 10248   | 2024-03-10| 王小明        | 台北市中正區xx路   | (Chai,10,18); (Chang,5,19); (Aniseed Syrup,2,10)     |
| 10249   | 2024-03-11| 李美玲        | 新北市板橋區yy街   | (Tofu,20,23.5); (Konbu,8,9)                          |

其中 `ProductList` 欄位表示此訂單中所有的產品項目，每筆紀錄以「(產品名稱, 數量, 單價)」形式儲存，並以分號 `;` 分隔多筆產品。

---

### 任務說明：

請依據資料庫規範化理論，依下列步驟完成規範化工作：

#### 步驟 1：將上述資料表轉換為 **第一正規形（1NF）**
- 每一個欄位只能儲存單一值，不能有重複資料群組（如 ProductList）。

#### 步驟 2：進一步轉換為 **第二正規形（2NF）**
- 移除非主鍵欄位對組合主鍵的部分相依。

#### 步驟 3：最後轉換為 **BCNF（Boyce-Codd Normal Form）**
- 所有決定因素皆為候選鍵。

---

### 🔍 提示：

1. 請先將 `ProductList` 拆開，讓每一筆訂單商品成為一列。
2. 考慮哪些欄位應該拆為獨立的實體（如：Customer, Product）。
3. 請為每個階段畫出資料表的結構（可用表格或 ER 圖輔助說明）。

---

### ✅ 標準解答概略：

#### 1NF 表格（消除重複群組）：

| OrderID | OrderDate | CustomerName | CustomerAddress | ProductName      | Quantity | UnitPrice |
|---------|-----------|---------------|------------------|------------------|----------|-----------|
| 10248   | 2024-03-10| 王小明        | 台北市中正區xx路   | Chai             | 10       | 18        |
| 10248   | 2024-03-10| 王小明        | 台北市中正區xx路   | Chang            | 5        | 19        |
| ...     | ...       | ...           | ...              | ...              | ...      | ...       |

#### 2NF 表格（拆出依賴部分主鍵的欄位）：

**Orders**
| OrderID | OrderDate | CustomerID |
|---------|-----------|------------|

**Customers**
| CustomerID | CustomerName | CustomerAddress |

**OrderDetails**
| OrderID | ProductID | Quantity | UnitPrice |

**Products**
| ProductID | ProductName |

#### BCNF 表格（移除非候選鍵決定因素）：
- 若 `ProductName` 可唯一決定 `ProductID`，則需移出 `ProductName → ProductID` 的依賴，確認只有候選鍵作為決定因素。

---

如果您需要此題目與解答整理為可下載的 PDF 講義，也可以為您製作。是否需要？
