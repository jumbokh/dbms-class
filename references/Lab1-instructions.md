### **《数据库管理概论》实验课程设计**
#### **实验：数据库的组成结构、数据库管理系统的基本操作及SQL命令语法**
**实验时长**：4小时  
**实验目标**：
1. 了解数据库的基本组成结构，包括表、字段、数据类型、索引等。
2. 熟悉数据库管理系统（DBMS）的基本操作，包括数据库创建、用户管理、权限控制等。
3. 掌握SQL的基本语法，包括数据查询（SELECT）、数据操作（INSERT、UPDATE、DELETE）、表结构定义（CREATE、ALTER、DROP）等。
4. 能够通过实践操作，建立简单的数据库并执行基本SQL语句。

---

## **实验1：数据库的组成结构**
**实验时间**：1小时  
**实验内容**：
- 认识数据库的基本组成（数据库、表、字段、数据类型、主键、外键、索引）。
- 使用 MySQL 创建数据库和表，并查看其结构。

**实验步骤**：
1. **安装与启动 MySQL**
   - 启动 MySQL Server 并使用 MySQL Workbench 或命令行连接数据库。
   - 进入 MySQL 命令行：
     ```sql
     mysql -u root -p
     ```
   
2. **创建数据库**：
   - 创建一个名为 `university` 的数据库：
     ```sql
     CREATE DATABASE university;
     ```
   - 选择数据库：
     ```sql
     USE university;
     ```

3. **创建表**：
   - 创建 `students` 表：
     ```sql
     CREATE TABLE students (
         student_id INT PRIMARY KEY AUTO_INCREMENT,
         name VARCHAR(50) NOT NULL,
         age INT,
         major VARCHAR(50)
     );
     ```
   - 查看表结构：
     ```sql
     DESC students;
     ```

4. **添加索引**
   - 在 `students` 表的 `name` 字段上创建索引：
     ```sql
     CREATE INDEX idx_name ON students(name);
     ```
   - 查看索引：
     ```sql
     SHOW INDEX FROM students;
     ```

**实验结果**：
- 学生将成功创建数据库 `university`，并创建 `students` 表及索引。

---

## **实验2：数据库管理系统的基本操作**
**实验时间**：1小时  
**实验内容**：
- 用户管理：创建新用户、赋予权限、回收权限。
- 数据库备份与恢复。

**实验步骤**：
1. **创建用户并赋予权限**
   - 创建用户 `student_user` 并赋予访问 `university` 数据库的权限：
     ```sql
     CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'password123';
     GRANT ALL PRIVILEGES ON university.* TO 'student_user'@'localhost';
     FLUSH PRIVILEGES;
     ```
   - 验证权限：
     ```sql
     SHOW GRANTS FOR 'student_user'@'localhost';
     ```

2. **回收权限**
   - 取消 `student_user` 的 DELETE 权限：
     ```sql
     REVOKE DELETE ON university.* FROM 'student_user'@'localhost';
     ```
   - 再次查看权限：
     ```sql
     SHOW GRANTS FOR 'student_user'@'localhost';
     ```

3. **备份与恢复**
   - 使用 MySQL 进行数据库备份：
     ```bash
     mysqldump -u root -p university > university_backup.sql
     ```
   - 删除数据库：
     ```sql
     DROP DATABASE university;
     ```
   - 还原数据库：
     ```bash
     mysql -u root -p < university_backup.sql
     ```

**实验结果**：
- 学生将掌握用户权限管理、数据库备份与恢复的基本方法。

---

## **实验3：SQL 基本操作（增删改查）**
**实验时间**：1小时  
**实验内容**：
- 使用 `INSERT` 插入数据。
- 使用 `SELECT` 查询数据。
- 使用 `UPDATE` 修改数据。
- 使用 `DELETE` 删除数据。

**实验步骤**：
1. **插入数据**
   ```sql
   INSERT INTO students (name, age, major) VALUES
   ('Alice', 20, 'Computer Science'),
   ('Bob', 21, 'Mathematics'),
   ('Charlie', 22, 'Physics');
   ```

2. **查询数据**
   - 查询所有学生：
     ```sql
     SELECT * FROM students;
     ```
   - 查询年龄大于 20 岁的学生：
     ```sql
     SELECT * FROM students WHERE age > 20;
     ```
   - 只查询 `name` 和 `major`：
     ```sql
     SELECT name, major FROM students;
     ```

3. **更新数据**
   - 修改 `Bob` 的专业：
     ```sql
     UPDATE students SET major = 'Statistics' WHERE name = 'Bob';
     ```

4. **删除数据**
   - 删除 `Charlie` 的记录：
     ```sql
     DELETE FROM students WHERE name = 'Charlie';
     ```

**实验结果**：
- 学生将成功插入、查询、更新、删除 `students` 表中的数据。

---

## **实验4：表结构定义（创建、修改、删除）**
**实验时间**：1小时  
**实验内容**：
- 创建新表 `courses`。
- 修改表结构。
- 删除表。

**实验步骤**：
1. **创建 `courses` 表**
   ```sql
   CREATE TABLE courses (
       course_id INT PRIMARY KEY AUTO_INCREMENT,
       course_name VARCHAR(100) NOT NULL,
       credits INT CHECK (credits > 0)
   );
   ```

2. **修改表结构**
   - 添加 `department` 字段：
     ```sql
     ALTER TABLE courses ADD COLUMN department VARCHAR(50);
     ```
   - 修改 `course_name` 的数据类型：
     ```sql
     ALTER TABLE courses MODIFY COLUMN course_name TEXT;
     ```

3. **删除表**
   - 删除 `courses` 表：
     ```sql
     DROP TABLE courses;
     ```

**实验结果**：
- 学生将学会创建、修改、删除表结构。

---

## **实验总结**
通过本实验，学生将：
1. 了解数据库的基本组成结构，能够创建数据库和表。
2. 熟悉数据库管理系统的基本操作，包括用户管理和数据库备份恢复。
3. 掌握 SQL 语法，能够进行数据查询和操作。
4. 具备修改和删除表结构的能力，为后续学习打下基础。

**实验报告要求**：
- 记录实验过程中执行的 SQL 语句及其输出结果。
- 总结实验过程中的问题及解决方案。