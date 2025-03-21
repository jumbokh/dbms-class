以下是從簡報中擷取的例3.1～例3.15內容：

---

**例3.1 – 定義模式**  
為用戶 **WANG** 定義一個“學生選課”模式 **S-C-SC**  
```sql
CREATE SCHEMA “S-C-SC” AUTHORIZATION WANG;
```

---

**例3.2 – 定義模式（隱含模式名）**  
使用以下語句定義模式，其中未指定模式名，系統隱含模式名為用戶名 **WANG**  
```sql
CREATE SCHEMA AUTHORIZATION WANG;
```

---

**例3.3 – 創建模式並定義基本表**  
為用戶 **ZHANG** 創建一個模式 **Test**，並在其中定義一個表 **Tab1**  
```sql
CREATE SCHEMA Test AUTHORIZATION Zhang
CREATE TABLE Tab1(
    Col1 SMALLINT,
    Col2 INT,
    Col3 CHAR(20),
    Col4 NUMERIC(10,3),
    Col5 DECIMAL(5,2)
);
```

---

**例3.4 – 刪除模式**  
刪除模式 **Test**（同時刪除其中定義的對象，如表 **Tab1**）  
```sql
DROP SCHEMA Test CASCADE;
```

---

**例3.5 – 建立“學生”表 Student**  
創建 **Student** 表，並設置主鍵與唯一約束  
```sql
CREATE TABLE Student          
(
    Sno   CHAR(8) PRIMARY KEY,   -- Sno 為主碼  
    Sname VARCHAR(20) UNIQUE,    -- Sname 取唯一值  
    Ssex  CHAR(6),
    Sbirthdate Date,
    Smajor VARCHAR(40)
);
```

---

**例3.6 – 建立“課程”表 Course**  
創建 **Course** 表，並定義主鍵和外鍵（Cpno 作為直接先修課的外鍵）  
```sql
CREATE TABLE Course
(
    Cno    CHAR(5) PRIMARY KEY,
    Cname  VARCHAR(40) NOT NULL,            
    Ccredit SMALLINT,
    Cpno   CHAR(5),
    FOREIGN KEY (Cpno) REFERENCES Course(Cno)
);
```

---

**例3.7 – 建立“學生選課”表 SC**  
創建 **SC** 表，設置由 **Sno** 和 **Cno** 組成的複合主鍵，同時定義外鍵  
```sql
CREATE TABLE SC
(
    Sno           CHAR(8),
    Cno           CHAR(5),
    Grade         SMALLINT,          -- 成績  
    Semester      CHAR(5),           -- 開課學期  
    Teachingclass CHAR(8),           -- 學生所選修的教學班  
    PRIMARY KEY (Sno, Cno),          -- 複合主鍵  
    FOREIGN KEY (Sno) REFERENCES Student(Sno),
    FOREIGN KEY (Cno) REFERENCES Course(Cno)
);
```

---

**例3.8 – 修改表：新增列**  
向 **Student** 表增加“郵箱地址”列 **Semail**，數據類型為字符型  
```sql
ALTER TABLE Student ADD Semail VARCHAR(30);
```

---

**例3.9 – 修改表：更改數據類型**  
將 **Student** 表中出生日期 **Sbirthdate** 的數據類型由 **DATE** 型改為 **VARCHAR(20)**  
```sql
ALTER TABLE Student ALTER COLUMN Sbirthdate TYPE VARCHAR(20);
```

---

**例3.10 – 修改表：添加唯一約束**  
為 **Course** 表增加課程名稱唯一約束條件  
```sql
ALTER TABLE Course ADD UNIQUE(Cname);
```

---

**例3.11 – 刪除表**  
刪除 **Student** 表，並選擇 **CASCADE**（同時刪除依賴對象，如索引、視圖等）  
```sql
DROP TABLE Student CASCADE;
```

---

**例3.12 – 刪除表時處理依賴對象**  

*情形一：RESTRICT*  
當 **Student** 表上存在依賴的視圖（例如已建立的 **CS_Student** 視圖）時，使用 **RESTRICT** 會導致刪除失敗：  
```sql
DROP TABLE Student RESTRICT;
```
系統返回錯誤信息，提示存在依賴對象，故表不能被刪除。

*情形二：CASCADE*  
使用 **CASCADE** 刪除 **Student** 表，系統同時自動刪除依賴對象（例如 **CS_Student** 視圖）：  
```sql
DROP TABLE Student CASCADE;
```
執行後，該表及其依賴的視圖均被刪除。

---

**例3.13 – 建立索引**  
為“學生選課”數據庫中的 **Student**、**Course** 和 **SC** 三個表建立索引：  
- 在 **Student** 表上，按學生姓名升序建立唯一索引  
- 在 **Course** 表上，按課程名稱升序建立唯一索引  
- 在 **SC** 表上，按學號升序、課程號降序建立唯一索引  
```sql
CREATE UNIQUE INDEX Idx_StuSname ON Student(Sname);
CREATE UNIQUE INDEX Idx_CouCname ON Course(Cname);
CREATE UNIQUE INDEX Idx_SCCno ON SC(Sno ASC, Cno DESC);
```

---

**例3.14 – 修改索引名稱**  
將 **SC** 表上原來的索引 **Idx_SCCno** 改名為 **Idx_SCSnoCno**  
```sql
ALTER INDEX Idx_SCCno RENAME TO Idx_SCSnoCno;
```

---

**例3.15 – 刪除索引**  
刪除 **Student** 表的索引 **Idx_StuSname**  
```sql
DROP INDEX Idx_StuSname;
```

---

以上即為簡報中例3.1至例3.15的完整內容。