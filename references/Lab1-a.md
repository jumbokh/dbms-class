 ### 實驗報告：數據庫組成結構與SQL命令語法

#### 實驗目的：
1. 理解數據庫的基本組成結構。
2. 掌握數據庫管理系統（DBMS）的基本操作。
3. 學會使用SQL命令語法進行基本的數據庫操作。

#### 實驗步驟：

**一、數據庫組成結構**

1. **介紹數據庫的基本概念**
   - 資料表（Table）
   - 欄位（Column）
   - 紀錄（Row）
   - 關鍵字（Key）

2. **實驗操作：創建一個簡單的資料表**
   ```sql
   CREATE TABLE Student (
       StudentID INT PRIMARY KEY,
       FirstName VARCHAR(50),
       LastName VARCHAR(50),
       Age INT,
       Email VARCHAR(100)
   );
   ```

**二、數據庫管理系統的基本操作**

1. **介紹DBMS的基本概念**
   - 連接到數據庫
   - 創建和刪除資料庫
   - 創建和刪除資料表

2. **實驗操作：使用SQL命令進行基本的DBMS操作**
   ```sql
   -- 連接到數據庫
   USE mydatabase;

   -- 創建資料庫
   CREATE DATABASE mydatabase;

   -- 刪除資料庫
   DROP DATABASE mydatabase;
   ```

**三、SQL命令語法及使用方式**

1. **介紹SQL的基本概念**
   - 選擇（SELECT）
   - 插入（INSERT INTO）
   - 更新（UPDATE）
   - 刪除（DELETE）

2. **實驗操作：使用SQL命令進行基本的數據庫操作**
   ```sql
   -- 插入記錄
   INSERT INTO Student (StudentID, FirstName, LastName, Age, Email)
   VALUES (1, 'John', 'Doe', 20, 'john.doe@example.com');

   -- 選擇所有記錄
   SELECT * FROM Student;

   -- 更新記錄
   UPDATE Student
   SET Email = 'new.email@example.com'
   WHERE StudentID = 1;

   -- 刪除記錄
   DELETE FROM Student
   WHERE StudentID = 1;
   ```

**四、實驗報告**

1. **實驗目的**
   - 確認學生理解了數據庫的基本組成結構。
   - 確認學生掌握了DBMS的基本操作。
   - 確認學生學會了使用SQL命令語法進行基本的數據庫操作。

2. **實驗步驟總結**
   - 學生需要按照上述步驟進行操作，並記錄下每一步的操作過程和結果。
   - 學生需要提交一個實驗報告，報告中應包括以下內容：
     - 實驗目的
     - 實驗步驟
     - 操作過程和結果截图或描述
     - 遇到的問題及解決方案

**附加資料：**
- SQL命令語法的手冊或教程。
- 數據庫管理系統（如MySQL、SQLite）的安裝指南。

---

這個實驗設計旨在幫助初學本科生理解數據庫的基本概念和操作，並通過實際操作來加深對這些概念的理解。希望這個實驗報告能夠幫助學生更好地掌握數據庫管理和SQL命令語法。