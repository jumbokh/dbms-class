下面以表格的方式展示“业务员销售”情境下各表的结构，并附上部分SQL示例代码，供大家参考练习。所有内容均以简体中文输出。

---

### 1. 数据表结构概览

| 表名         | 字段名称       | 数据类型         | 约束说明                                  | 备注                           |
|--------------|----------------|------------------|-------------------------------------------|--------------------------------|
| **SalesRep** | RepID          | CHAR(6)          | 主键                                      | 业务员编号                     |
|              | RepName        | VARCHAR(30)      | 唯一约束（保证业务员姓名唯一）            | 业务员姓名                     |
|              | Email          | VARCHAR(50)      |                                           | 电子邮件                       |
|              | Phone          | CHAR(10)         |                                           | 联系电话                       |
|              | Region         | VARCHAR(20)      |                                           | 所属区域                       |
|              | HireDate       | DATE             |                                           | 入职日期（后续新增字段）       |
| **Customer** | CustID         | CHAR(6)          | 主键                                      | 客户编号                       |
|              | CustName       | VARCHAR(40)      | NOT NULL, 唯一约束                        | 客户名称                       |
|              | ContactPerson  | VARCHAR(30)      |                                           | 联系人                         |
|              | Phone          | VARCHAR(15)      |                                           | 电话号码（已调整数据类型）     |
|              | Address        | VARCHAR(100)     |                                           | 客户地址                       |
| **SalesRecord** | RecordID   | CHAR(8)          | 主键                                      | 销售记录编号                   |
|              | RepID          | CHAR(6)          | 外键，参照 SalesRep(RepID)                | 对应业务员编号                 |
|              | CustID         | CHAR(6)          | 外键，参照 Customer(CustID)               | 对应客户编号                   |
|              | SaleDate       | DATE             |                                           | 销售日期                       |
|              | Amount         | NUMERIC(10,2)    |                                           | 销售金额                       |

---

### 2. SQL示例代码

#### 2.1 定义模式  
为用户 SALES 定义一个销售管理模式 SalesDB。  
```sql
CREATE SCHEMA SalesDB AUTHORIZATION SALES;
```

#### 2.2 创建表

- **创建业务员表 SalesRep**  
```sql
CREATE TABLE SalesDB.SalesRep (
    RepID   CHAR(6) PRIMARY KEY,
    RepName VARCHAR(30) UNIQUE,
    Email   VARCHAR(50),
    Phone   CHAR(10),
    Region  VARCHAR(20)
);
```

- **创建客户表 Customer**  
```sql
CREATE TABLE SalesDB.Customer (
    CustID        CHAR(6) PRIMARY KEY,
    CustName      VARCHAR(40) NOT NULL UNIQUE,
    ContactPerson VARCHAR(30),
    Phone         VARCHAR(15),
    Address       VARCHAR(100)
);
```

- **创建销售记录表 SalesRecord**  
```sql
CREATE TABLE SalesDB.SalesRecord (
    RecordID CHAR(8) PRIMARY KEY,
    RepID    CHAR(6),
    CustID   CHAR(6),
    SaleDate DATE,
    Amount   NUMERIC(10,2),
    FOREIGN KEY (RepID) REFERENCES SalesDB.SalesRep(RepID),
    FOREIGN KEY (CustID) REFERENCES SalesDB.Customer(CustID)
);
```

#### 2.3 修改表结构（示例）

- **为 SalesRep 表新增入职日期 HireDate 字段**  
```sql
ALTER TABLE SalesDB.SalesRep
ADD HireDate DATE;
```

- **修改 Customer 表 Phone 字段数据类型为 VARCHAR(15)**  
（假设初始定义为 CHAR(10)时）
```sql
ALTER TABLE SalesDB.Customer
ALTER COLUMN Phone TYPE VARCHAR(15);
```

#### 2.4 插入示例数据

- **插入业务员数据**  
```sql
INSERT INTO SalesDB.SalesRep (RepID, RepName, Email, Phone, Region, HireDate)
VALUES ('R00001', '张三', 'zhangsan@example.com', '1380013800', '华东', '2022-03-15');
```

- **插入客户数据**  
```sql
INSERT INTO SalesDB.Customer (CustID, CustName, ContactPerson, Phone, Address)
VALUES ('C00001', '北京电子', '李四', '01088886666', '北京市朝阳区XX路');
```

- **插入销售记录数据**  
```sql
INSERT INTO SalesDB.SalesRecord (RecordID, RepID, CustID, SaleDate, Amount)
VALUES ('SR000001', 'R00001', 'C00001', '2023-07-20', 50000.00);
```

#### 2.5 创建索引示例

- **为 SalesRep 表 RepName 建立唯一索引**  
```sql
CREATE UNIQUE INDEX Idx_RepName ON SalesDB.SalesRep(RepName);
```

- **为 SalesRecord 表建立复合索引：先按 SaleDate 升序，再按 Amount 降序**  
```sql
CREATE INDEX Idx_SaleDate_Amount ON SalesDB.SalesRecord(SaleDate ASC, Amount DESC);
```

- **修改索引名称示例**  
将复合索引重新命名：  
```sql
ALTER INDEX Idx_SaleDate_Amount RENAME TO Idx_Sales_Date_Amount;
```

- **删除索引示例**  
删除 SalesRep 表上针对 RepName 建立的唯一索引：  
```sql
DROP INDEX Idx_RepName;
```

- **使用 CASCADE 删除 Customer 表及相关依赖对象**  
```sql
DROP TABLE SalesDB.Customer CASCADE;
```

---

通过上述表格展示和SQL示例，大家可以清晰了解“业务员销售”情境下各个数据表的结构与关系，并通过练习掌握创建、修改、索引、插入数据及删除表的操作。