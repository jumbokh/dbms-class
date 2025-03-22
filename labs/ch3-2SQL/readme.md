下面整理提取了简报 “第3章 关系数据库标准语言SQL（2）--3.3.pptx” 中各部分的示例（例3.16～例3.70），并按查询类型进行分类说明，供大家参考学习。以下内容均以简体中文呈现。

---

### 一、单表查询示例

| 例号    | 示例描述                                             | 关键SQL语句示例                                             |
|---------|------------------------------------------------------|-------------------------------------------------------------|
| 例3.16  | 查询全体学生的学号与姓名                             | ```sql<br>SELECT Sno, Sname<br>FROM Student;<br>```        |
| 例3.17  | 查询全体学生的姓名、学号、主修专业                     | ```sql<br>SELECT Sname, Sno, Smajor<br>FROM Student;<br>```  |
| 例3.18  | 查询全体学生的详细记录（全部列）                     | ```sql<br>SELECT Sno, Sname, Ssex, Sbirthdate, Smajor<br>FROM Student;<br>``` |
| 例3.19  | 查询全体学生的姓名及其年龄（通过日期计算）           | ```sql<br>SELECT Sname, (extract(year from current_date) - extract(year from Sbirthdate)) AS 年龄<br>FROM Student;<br>``` |
| 例3.20  | 查询全体学生的姓名、出生日期和主修专业（附带字符串）   | ```sql<br>SELECT Sname, 'Date of Birth: ', Sbirthdate, Smajor<br>FROM Student;<br>``` |
- **例3.19**：查询全体学生的姓名及其年龄（通过日期计算）
  ```sql
  select Sno, Sname, (extract(year from current_date)-extract(year from Sbirthdate)) "年齡"
  from student;
  ```
- **例3.25**： 查询年龄在20~23岁（包括20岁和23岁）之间的学生的学生的姓名、出生年月和主修专业
  ```sql
  SELECT Sname, Sbirthdate, Smajor
  FROM Student
  WHERE extract(year from current_date) - extract(year from Sbirthdate) BETWEEN 20 AND 23; 
  ```
- **例3.28**： 查询既不是计算机科学与技术专业也不是信息安全专业学生的姓名和性别
  ```sql
   SELECT Sname,Ssex
   FROM Student
   WHERE Smajor NOT IN ( '计算机科学与技术','信息安全' );
  ```


另外，示例中还介绍了如何利用 DISTINCT 去除重复行（例3.21），以及在 WHERE 子句中用比较、范围（BETWEEN）、集合（IN/NOT IN）及字符匹配（LIKE）等谓词构造查询（例3.22～例3.35）。  
例如：  
- **例3.29**：查询学号为“20180003”的学生详细情况  
  ```sql
  SELECT *
  FROM Student
  WHERE Sno LIKE '20180003';
  ```
- **例3.30**：查询所有姓“刘”的学生  
  ```sql
  SELECT Sname, Sno, Ssex
  FROM Student
  WHERE Sname LIKE '刘%';
  ```
- **例3.34**： 查询DB_Design课程的课程号和学分
    ```sql
      SELECT Cno,Ccredit
      FROM     Course
      WHERE  Cname LIKE 'DB\_Design' ESCAPE '\';
    ```
- fix
  ```sql
    SELECT Cno,Ccredit
    FROM     Course
    WHERE  Cname LIKE 'DB\_Design' ESCAPE '\\';
  ```
- **例3.35**： 查询以“DB_”开头，且倒数第三个字符为 i的课程的详细情况。
    ```sql
    SELECT *
    FROM Course 
    WHERE Cname LIKE 'DB＼_%i__' ESCAPE '\＼';
    ```
- **例3.39**：查询选修了81003号课程的学生的学号及其成绩，查询结果按分数的降序排列
     ```sql
  		SELECT Sno,Grade
	  	FROM SC
	  	WHERE Cno='81003'
	  	ORDER BY Grade DESC;
     ```
- **例3.40**：查询全体学生选修课程情况，查询结果先按照课程号升序排列，同一课程中按成绩降序排列。
     ```sql
	SELECT *
	FROM SC
	ORDER BY Cno,grade DESC;         
     ```
---

### 二、聚集函数与分组查询

| 例号    | 示例描述                                                     | 关键SQL语句示例                                             |
|---------|--------------------------------------------------------------|-------------------------------------------------------------|
| 例3.41  | 查询学生总人数                                               | ```sql<br>SELECT COUNT(*) FROM Student;<br>```              |
| 例3.42  | 查询选修了课程的学生人数（使用DISTINCT）                     | ```sql<br>SELECT COUNT(DISTINCT Sno) FROM SC;<br>```         |
| 例3.43  | 计算选修81001号课程学生的平均成绩                             | ```sql<br>SELECT AVG(Grade)<br>FROM SC<br>WHERE Cno='81001';<br>``` |
| 例3.44  | 查询选修1号课程的学生最高分数                                   | ```sql<br>SELECT MAX(Grade)<br>FROM SC<br>WHERE Cno='81001';<br>``` |
| 例3.45  | 查询学号为20180003学生选修课程的总学分数（联表查询）             | ```sql<br>SELECT SUM(Ccredit)<br>FROM SC, Course<br>WHERE Sno='20180003' AND SC.Cno = Course.Cno;<br>``` |
| 例3.46  | 求各个课程号及选修该课程的人数（分组查询）                       | ```sql<br>SELECT Cno, COUNT(Sno)<br>FROM SC<br>GROUP BY Cno;<br>``` |
| 例3.47  | 查询2019年第2学期选修课程数大于10门的学生                      | ```sql<br>SELECT Sno<br>FROM SC<br>WHERE Semester='20192'<br>GROUP BY Sno<br>HAVING COUNT(*) > 10;<br>``` |
| 例3.48  | 查询平均成绩大于等于90分的学生（分组后使用HAVING）               | ```sql<br>SELECT Sno, AVG(Grade)<br>FROM SC<br>GROUP BY Sno<br>HAVING AVG(Grade) >= 90;<br>``` |
| 例3.49  | 查询选修“数据库系统概论”课程成绩排名前10的学生（使用ORDER BY与LIMIT） | ```sql<br>SELECT Sno<br>FROM SC, Course<br>WHERE Course.Cname='数据库系统概论' AND SC.Cno=Course.Cno<br>ORDER BY Grade DESC<br>LIMIT 10;<br>``` |
| 例3.50  | 查询平均成绩排名在第3-5名的学生（使用LIMIT和OFFSET）             | ```sql<br>SELECT Sno, AVG(Grade)<br>FROM SC<br>GROUP BY Sno<br>ORDER BY AVG(Grade) DESC<br>LIMIT 5 OFFSET 2;<br>``` |
- **例3.46**： 求各个课程号及选修该课程的人数
     ```sql
      SELECT Cno,COUNT(Sno)
      FROM    SC
      GROUP BY Cno; 
     ```
- **例3.47**：查询2019年第2学期选修了10门以上课程的学生学号
- 
      ```sql
       SELECT Sno
       FROM  SC
       WHERE Semester='20192'               
       GROUP BY Sno                       
       HAVING COUNT(*) >10;             
      ```
---

### 三、连接查询示例

| 例号    | 示例描述                                                         | 关键SQL语句示例                                             |
|---------|------------------------------------------------------------------|-------------------------------------------------------------|
| 例3.51  | 等值连接查询：查询每个学生及其选修课程的情况                      | ```sql<br>SELECT Student.*, SC.*<br>FROM Student, SC<br>WHERE Student.Sno = SC.Sno;<br>``` |
| 例3.52  | 自然连接查询：查询每个学生的详细信息及其选课情况（去除重复属性）      | ```sql<br>SELECT Student.Sno, Sname, Ssex, Sbirthdate, Smajor, Cno, Grade<br>FROM Student, SC<br>WHERE Student.Sno = SC.Sno;<br>``` |
| 例3.53  | 复合条件连接查询：查询选修81002号课程且成绩大于90分的学生            | ```sql<br>SELECT Student.Sno, Sname<br>FROM Student, SC<br>WHERE Student.Sno = SC.Sno AND SC.Cno = '81002' AND SC.Grade > 90;<br>``` |
| 例3.54  | 自身连接查询：查询每门课的间接先修课（通过Course表的自身连接实现）      | ```sql<br>SELECT FIRST.Cno, SECOND.Cpno<br>FROM Course AS FIRST, Course AS SECOND<br>WHERE FIRST.Cpno = SECOND.Cno AND SECOND.Cpno IS NOT NULL;<br>``` |
| 例3.55  | 外连接查询：以Student为主，列出所有学生及其选课情况，若无选课则显示NULL    | ```sql<br>SELECT Student.Sno, Sname, Ssex, Sbirthdate, Smajor, Cno, Grade<br>FROM Student LEFT OUTER JOIN SC ON Student.Sno = SC.Sno;<br>``` |
| 例3.56  | 多表连接查询：查询每个学生的学号、姓名、选修课程名称及成绩              | ```sql<br>SELECT Student.Sno, Sname, Cname, Grade<br>FROM Student, SC, Course<br>WHERE Student.Sno = SC.Sno AND SC.Cno = Course.Cno;<br>``` |

---

### 四、嵌套查询示例

| 例号    | 示例描述                                                         | 关键SQL语句示例                                             |
|---------|------------------------------------------------------------------|-------------------------------------------------------------|
| 例3.57  | 嵌套查询（带IN）：查询与“刘晨”在同一主修专业的学生（提供多种解法）    | 解法一：<br>```sql<br>SELECT Sno, Sname, Smajor<br>FROM Student<br>WHERE Smajor IN (SELECT Smajor FROM Student WHERE Sname='刘晨');<br>```<br>解法二（用自身连接）：<br>```sql<br>SELECT S1.Sno, S1.Sname, S1.Smajor<br>FROM Student S1, Student S2<br>WHERE S1.Smajor = S2.Smajor AND S2.Sname='刘晨';<br>``` |
| 例3.58  | 嵌套查询（带IN）：查询选修了课程名为“信息系统概论”的学生的学号和姓名       | ```sql<br>SELECT Sno, Sname<br>FROM Student<br>WHERE Sno IN (<br>    SELECT Sno<br>    FROM SC<br>    WHERE Cno IN (<br>         SELECT Cno<br>         FROM Course<br>         WHERE Cname='信息系统概论'<br>    )<br>);<br>``` |
| 例3.59  | 嵌套查询（带比较运算符）：找出每个学生超过其选修课程平均成绩的课程号         | ```sql<br>SELECT Sno, Cno<br>FROM SC x<br>WHERE Grade >= (SELECT AVG(Grade) FROM SC y WHERE y.Sno = x.Sno);<br>``` |
| 例3.60  | 嵌套查询（带ANY/ALL）：查询非计算机专业中，比计算机专业任一学生年龄小的学生信息  | ```sql<br>SELECT Sname, Sbirthdate, Smajor<br>FROM Student<br>WHERE Sbirthdate > ANY (SELECT Sbirthdate FROM Student WHERE Smajor = '计算机科学与技术')<br>  AND Smajor <> '计算机科学与技术';<br>``` |
| 例3.61  | 嵌套查询（带ALL）：查询非计算机专业中，比计算机专业所有学生年龄都小的学生信息   | ```sql<br>SELECT Sname, Sbirthdate<br>FROM Student<br>WHERE Sbirthdate > ALL (SELECT Sbirthdate FROM Student WHERE Smajor='计算机科学与技术')<br>  AND Smajor <> '计算机科学与技术';<br>``` |
| 例3.62  | 嵌套查询（带EXISTS）：查询选修了81001号课程的学生姓名                     | ```sql<br>SELECT Sname<br>FROM Student<br>WHERE EXISTS (SELECT * FROM SC WHERE Sno = Student.Sno AND Cno='81001');<br>``` |
| 例3.63  | 嵌套查询（带NOT EXISTS）：查询未选修81001号课程的学生姓名                  | ```sql<br>SELECT Sname<br>FROM Student<br>WHERE NOT EXISTS (SELECT * FROM SC WHERE Sno = Student.Sno AND Cno='81001');<br>``` |
| 例3.64  | 嵌套查询（用EXISTS实现全称量词）：查询选修了全部课程的学生姓名               | ```sql<br>SELECT Sname<br>FROM Student<br>WHERE NOT EXISTS (<br>    SELECT *<br>    FROM Course<br>    WHERE NOT EXISTS (<br>         SELECT *<br>         FROM SC<br>         WHERE Sno = Student.Sno AND Cno = Course.Cno<br>    )<br>);<br>``` |
| 例3.65  | 嵌套查询（用EXISTS实现逻辑蕴涵）：查询至少选修了学生20180002所选全部课程的学生学号 | 示例较复杂，可理解为：对于每门课程 y，如果20180002选修了 y，则学生 x 也必须选修 y。详细写法见简报内容。 |

---

### 五、集合查询示例

| 例号    | 示例描述                                                         | 关键SQL语句示例                                             |
|---------|------------------------------------------------------------------|-------------------------------------------------------------|
| 例3.66  | 查询计算机专业的学生与年龄不大于19岁的学生（使用UNION合并）           | ```sql<br>SELECT * FROM Student WHERE Smajor='计算机科学与技术'<br>UNION<br>SELECT * FROM Student WHERE (extract(year from current_date) - extract(year from Sbirthdate)) <= 19;<br>``` |
| 例3.67  | 查询2020年第2学期选修81001或81002课程的学生                        | ```sql<br>SELECT Sno FROM SC WHERE Semester='20202' AND Cno='81001'<br>UNION<br>SELECT Sno FROM SC WHERE Semester='20202' AND Cno='81002';<br>``` |
| 例3.68  | 查询计算机专业与年龄不大于19岁的学生交集（使用INTERSECT）             | ```sql<br>SELECT * FROM Student WHERE Smajor='计算机科学与技术'<br>INTERSECT<br>SELECT * FROM Student WHERE (extract(year from current_date) - extract(year from Sbirthdate)) <= 19;<br>``` |
| 例3.69  | 查询既选修了81001又选修了81002课程的学生（交集）                     | ```sql<br>SELECT Sno FROM SC WHERE Cno='81001'<br>INTERSECT<br>SELECT Sno FROM SC WHERE Cno='81002';<br>``` |
| 例3.70  | 查询计算机专业中年龄大于19岁的学生（差集，即排除年龄不大于19的学生）      | ```sql<br>SELECT * FROM Student WHERE Smajor='计算机科学与技术'<br>EXCEPT<br>SELECT * FROM Student WHERE (extract(year from current_date) - extract(year from Sbirthdate)) <= 19;<br>``` |

---

### 六、基于派生表的查询示例

简报中还提到将子查询放在 FROM 子句中构造临时派生表，如下例：
- 例如：  
  ```sql
  SELECT Sno, Cno
  FROM SC, (SELECT Sno, AVG(Grade) AS Avg_grade FROM SC GROUP BY Sno) AS Avg_SC (Avg_sno, Avg_grade)
  WHERE SC.Sno = Avg_SC.Avg_sno AND SC.Grade >= Avg_SC.Avg_grade;
  ```
  此示例（在简报中属于例3.59的变体）用于找出每个学生超过自己选修课程平均成绩的课程号。
```sql
SELECT SC.Sno, SC.Cno
FROM SC
JOIN (
    SELECT Sno, AVG(Grade) AS Avg_grade 
    FROM SC 
    GROUP BY Sno
) AS Avg_SC ON SC.Sno = Avg_SC.Sno
WHERE SC.Grade >= Avg_SC.Avg_grade
LIMIT 0, 25;
```
---

以上即为“第3章 关系数据库标准语言SQL（2）--3.3.pptx”中各示例的提取与归纳。各示例详细展示了SQL查询语句的基本结构、单表查询、连接查询、嵌套查询、集合操作以及基于派生表的查询等内容，供大家在学习和实践中参考。
