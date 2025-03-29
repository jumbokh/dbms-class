以下整理了簡報中出現的部分範例，每個範例均包括了題目描述（問題）與相應的 SQL 解答（解答）。由於簡報內容較多，下列只摘錄部分重點範例：

---

### 1. 單表查詢範例

- **例3.16**  
  **問題：** 查詢全體學生的學號與姓名  
  **解答：**  
  ```sql
  SELECT Sno, Sname
  FROM Student;
  ```

- **例3.17**  
  **問題：** 查詢全體學生的姓名、學號與主修專業  
  **解答：**  
  ```sql
  SELECT Sname, Sno, Smajor
  FROM Student;
  ```

- **例3.18**  
  **問題：** 查詢全體學生的詳細記錄  
  **解答：**  
  ```sql
  SELECT Sno, Sname, Ssex, Sbirthdate, Smajor 
  FROM Student;
  ```  
  或直接使用星號：
  ```sql
  SELECT *
  FROM Student;
  ```

- **例3.19**  
  **問題：** 查詢全體學生的姓名及其年齡  
  **解答：**  
  ```sql
  SELECT Sname, (extract(year from current_date) - extract(year from Sbirthdate)) "年齡" 
  FROM Student;
  ```  
  *說明：利用 extract 函數計算當前年份與學生出生年份的差值，得出年齡。*

- **例3.20**  
  **問題：** 查詢全體學生的姓名、出生日期及主修專業，並在結果中顯示文字說明  
  **解答：**  
  ```sql
  SELECT Sname, 'Date of Birth:', Sbirthdate, Smajor
  FROM Student;
  ```

---

### 2. 關於重複值與條件查詢

- **例3.21**  
  **問題：** 查詢選修了課程的學生學號（注意可能有重複值）  
  **解答：**  
  ```sql
  SELECT Sno
  FROM SC;
  ```  
  或若要明確指定全部行：
  ```sql
  SELECT ALL Sno
  FROM SC;
  ```

- **例3.22**  
  **問題：** 查詢主修“計算機科學與技術”專業的學生姓名  
  **解答：**  
  ```sql
  SELECT Sname
  FROM Student
  WHERE Smajor = '計算機科學與技術';
  ```

- **例3.23**  
  **問題：** 查詢所有 2000 年（含）以後出生的學生姓名及性別  
  **解答：**  
  ```sql
  SELECT Sname, Ssex 
  FROM Student    
  WHERE extract(year from Sbirthdate) >= 2000;
  ```

- **例3.24**  
  **問題：** 查詢考試成績不及格（小於 60 分）的學生學號  
  **解答：**  
  ```sql
  SELECT DISTINCT Sno
  FROM SC
  WHERE Grade < 60;
  ```

- **例3.25**  
  **問題：** 查詢年齡介於 20 到 23 歲（含 20 與 23）的學生姓名、出生日期及主修專業  
  **解答：**  
  ```sql
  SELECT Sname, Sbirthdate, Smajor
  FROM Student
  WHERE extract(year from current_date) - extract(year from Sbirthdate) BETWEEN 20 AND 23;
  ```

- **例3.26**  
  **問題：** 查詢年齡不在 20～23 歲之間的學生姓名、出生日期及主修專業  
  **解答：**  
  ```sql
  SELECT Sname, Sbirthdate, Smajor
  FROM Student
  WHERE extract(year from current_date) - extract(year from Sbirthdate) NOT BETWEEN 20 AND 23;
  ```

---

### 3. 字符匹配與 IN 條件

- **例3.27**  
  **問題：** 查詢主修“計算機科學與技術”及“信息安全”專業的學生姓名與性別  
  **解答：**  
  ```sql
  SELECT Sname, Ssex
  FROM Student
  WHERE Smajor IN ('計算機科學與技術', '信息安全');
  ```

- **例3.28**  
  **問題：** 查詢既不是“計算機科學與技術”也不是“信息安全”專業的學生姓名與性別  
  **解答：**  
  ```sql
  SELECT Sname, Ssex
  FROM Student
  WHERE Smajor NOT IN ('計算機科學與技術', '信息安全');
  ```

- **例3.29**  
  **問題：** 查詢學號為 20180003 的學生詳細情況  
  **解答：**  
  ```sql
  SELECT *
  FROM Student
  WHERE Sno LIKE '20180003';
  ```  
  （此語句與 `WHERE Sno = '20180003'` 效果等價）

- **例3.30**  
  **問題：** 查詢所有姓“劉”的學生姓名、學號及性別  
  **解答：**  
  ```sql
  SELECT Sname, Sno, Ssex
  FROM Student
  WHERE Sname LIKE '劉%';
  ```

- **例3.31**  
  **問題：** 查詢 2018 級學生的學號及姓名（注意學號為字符類型）  
  **解答：**  
  ```sql
  SELECT Sno, Sname
  FROM Student
  WHERE Sno LIKE '2018%';
  ```

- **例3.32**  
  **問題：** 查詢課程號以“81”開頭、且最後一位為“6”的課程名稱及課程號  
  **解答：**  
  ```sql
  SELECT Cname, Cno 
  FROM Course 
  WHERE Cno LIKE '81__6';
  ```  
  *說明：由於課程號固定長度為 5 個字符，因此中間用兩個底線匹配任意字符。*

- **例3.33**  
  **問題：** 查詢所有不姓“劉”的學生姓名、學號及性別  
  **解答：**  
  ```sql
  SELECT Sname, Sno, Ssex
  FROM Student
  WHERE Sname NOT LIKE '劉%';
  ```

---

### 4. 進階查詢與聚集函數

- **例3.34**  
  **問題：** 查詢課程名稱為 “DB_Design” 的課程號及學分（注意轉義下劃線）  
  **解答：**  
  ```sql
  SELECT Cno, Ccredit
  FROM Course
  WHERE Cname LIKE 'DB\_Design' ESCAPE '\';
  ```

- **例3.35**  
  **問題：** 查詢以“DB_”開頭且倒數第三個字符為 i 的課程的詳細情況  
  **解答：**  
  ```sql
  SELECT *
  FROM Course 
  WHERE Cname LIKE 'DB\_%i__' ESCAPE '＼';
  ```

- **例3.36**  
  **問題：** 查詢有選課記錄但沒有成績的學生學號與課程號  
  **解答：**  
  ```sql
  SELECT Sno, Cno
  FROM SC
  WHERE Grade IS NULL;
  ```

- **例3.37**  
  **問題：** 查詢有成績記錄的學生學號與課程號  
  **解答：**  
  ```sql
  SELECT Sno, Cno
  FROM SC
  WHERE Grade IS NOT NULL;
  ```

- **例3.38**  
  **問題：** 查詢主修“計算機科學與技術”且 2000 年（含）以後出生的學生學號、姓名及性別  
  **解答：**  
  ```sql
  SELECT Sno, Sname, Ssex
  FROM Student
  WHERE Smajor = '計算機科學與技術' 
    AND extract(year from Sbirthdate) >= 2000;
  ```

- **例3.39**  
  **問題：** 查詢選修了 81003 號課程的學生學號及其成績，結果按分數降序排列  
  **解答：**  
  ```sql
  SELECT Sno, Grade
  FROM SC
  WHERE Cno = '81003'
  ORDER BY Grade DESC;
  ```

- **例3.40**  
  **問題：** 查詢全體學生的選課情況，結果先按課程號升序排列，同一課程中按成績降序排列  
  **解答：**  
  ```sql
  SELECT *
  FROM SC
  ORDER BY Cno, Grade DESC;
  ```

- **例3.41**  
  **問題：** 查詢學生總人數  
  **解答：**  
  ```sql
  SELECT COUNT(*)
  FROM Student;
  ```

- **例3.42**  
  **問題：** 查詢選修了課程的學生人數（去重）  
  **解答：**  
  ```sql
  SELECT COUNT(DISTINCT Sno)
  FROM SC;
  ```

- **例3.43**  
  **問題：** 計算選修 81001 號課程的學生平均成績  
  **解答：**  
  ```sql
  SELECT AVG(Grade)
  FROM SC
  WHERE Cno = '81001';
  ```

- **例3.44**  
  **問題：** 查詢選修 1 號課程的學生最高分  
  **解答：**  
  ```sql
  SELECT MAX(Grade)
  FROM SC
  WHERE Cno = '81001';
  ```

- **例3.45**  
  **問題：** 查詢學號為 20180003 的學生選修課程的總學分  
  **解答：**  
  ```sql
  SELECT SUM(Ccredit)
  FROM SC, Course
  WHERE Sno = '20180003'
    AND SC.Cno = Course.Cno;
  ```

---

### 5. 分組與聚集查詢

- **例3.46**  
  **問題：** 求各個課程號及選修該課程的學生人數  
  **解答：**  
  ```sql
  SELECT Cno, COUNT(Sno)
  FROM SC
  GROUP BY Cno;
  ```

- **例3.47**  
  **問題：** 查詢 2019 年第 2 學期選修了超過 10 門課程的學生學號  
  **解答：**  
  ```sql
  SELECT Sno
  FROM SC
  WHERE Semester = '20192'
  GROUP BY Sno
  HAVING COUNT(*) > 10;
  ```

- **例3.48**  
  **問題：** 查詢平均成績大於等於 90 分的學生學號與平均成績  
  **解答：**  
  ```sql
  SELECT Sno, AVG(Grade)
  FROM SC
  GROUP BY Sno
  HAVING AVG(Grade) >= 90;
  ```  
  *注意：不能在 WHERE 子句中直接使用聚集函數*

- **例3.49**  
  **問題：** 查詢選修“數據庫系統概論”課程的成績排名前 10 名的學生學號  
  **解答：**  
  ```sql
  SELECT Sno
  FROM SC, Course
  WHERE Course.Cname = '數據庫系統概論'
    AND SC.Cno = Course.Cno
  ORDER BY Grade DESC
  LIMIT 10;
  ```

- **例3.50**  
  **問題：** 查詢平均成績排名在第 3 至第 5 名的學生學號及平均成績  
  **解答：**  
  ```sql
  SELECT Sno, AVG(Grade)
  FROM SC
  GROUP BY Sno
  ORDER BY AVG(Grade) DESC
  LIMIT 5 OFFSET 2;
  ```

---

### 6. 連接查詢範例

- **例3.51**  
  **問題：** 查詢每個學生及其選修課程的情況  
  **解答：**  
  ```sql
  SELECT Student.*, SC.*
  FROM Student, SC
  WHERE Student.Sno = SC.Sno;
  ```

- **例3.52**  
  **問題：** 查詢每個學生的學號、姓名、性別、出生日期、主修專業及其選修課程的課程號與成績  
  **解答：**  
  ```sql
  SELECT Student.Sno, Sname, Ssex, Sbirthdate, Smajor, Cno, Grade     
  FROM Student, SC
  WHERE Student.Sno = SC.Sno;
  ```

- **例3.53**  
  **問題：** 查詢選修 81002 號課程且成績在 90 分以上的所有學生的學號和姓名  
  **解答：**  
  ```sql
  SELECT Student.Sno, Sname
  FROM Student, SC
  WHERE Student.Sno = SC.Sno  
    AND SC.Cno = '81002' 
    AND SC.Grade > 90;
  ```

- **例3.54**  
  **問題：** 查詢每一門課的間接先修課（即先修課的先修課）  
  **解答：**  
  ```sql
  SELECT FIRST.Cno, SECOND.Cpno
  FROM Course FIRST, Course SECOND
  WHERE FIRST.Cpno = SECOND.Cno 
    AND SECOND.Cpno IS NOT NULL;
  ```

- **例3.55**  
  **問題：** 以 Student 表為主體，列出每個學生的基本資料及其選課情況（若無選課則顯示 NULL）  
  **解答：**  
  ```sql
  SELECT Student.Sno, Sname, Ssex, Sbirthdate, Smajor, Cno, Grade
  FROM Student LEFT OUTER JOIN SC ON (Student.Sno = SC.Sno);
  ```

- **例3.56**  
  **問題：** 查詢每個學生的學號、姓名、選修的課程名稱及成績  
  **解答：**  
  ```sql
  SELECT Student.Sno, Sname, Cname, Grade
  FROM Student, SC, Course
  WHERE Student.Sno = SC.Sno
    AND SC.Cno = Course.Cno;
  ```

---

### 7. 嵌套查詢與集合查詢

- **例3.57**  
  **問題：** 查詢與“劉晨”在同一主修專業的學生（可用不相關子查詢或自身連接）  
  **解答（方法一，不相關子查詢）：**  
  ```sql
  SELECT Sno, Sname, Smajor
  FROM Student
  WHERE Smajor IN (SELECT Smajor FROM Student WHERE Sname = '劉晨');
  ```
  **解答（方法二，自身連接）：**  
  ```sql
  SELECT S1.Sno, S1.Sname, S1.Smajor
  FROM Student S1, Student S2
  WHERE S1.Smajor = S2.Smajor
    AND S2.Sname = '劉晨';
  ```

- **例3.58**  
  **問題：** 查詢選修課程名為“信息系統概論”的學生學號和姓名  
  **解答：**  
  ```sql
  SELECT Sno, Sname
  FROM Student
  WHERE Sno IN (
      SELECT Sno
      FROM SC
      WHERE Cno IN (
          SELECT Cno
          FROM Course
          WHERE Cname = '信息系統概論'
      )
  );
  ```

- **例3.59**  
  **問題：** 找出每個學生在其選修課程中成績不低於自己選課平均分的課程號  
  **解答（直接嵌套查詢）：**  
  ```sql
  SELECT Sno, Cno
  FROM SC x
  WHERE Grade >= (
      SELECT AVG(Grade)
      FROM SC y
      WHERE y.Sno = x.Sno
  );
  ```
  **解答（基於派生表）：**  
  ```sql
  SELECT SC.Sno, SC.Cno
  FROM SC, (
      SELECT Sno, AVG(Grade) AS Avg_grade
      FROM SC
      GROUP BY Sno
  ) AS Avg_SC
  WHERE SC.Sno = Avg_SC.Sno
    AND SC.Grade >= Avg_SC.Avg_grade;
  ```

- **例3.60**  
  **問題：** 查詢非“計算機科學與技術”專業中，比“計算機科學與技術”專業任意一個學生年齡（出生日期）小的學生（即出生日期更晚）  
  **解答：**  
  ```sql
  SELECT Sname, Sbirthdate, Smajor
  FROM Student
  WHERE Sbirthdate > ANY (
      SELECT Sbirthdate
      FROM Student
      WHERE Smajor = '計算機科學與技術'
  )
    AND Smajor <> '計算機科學與技術';
  ```

- **例3.61**  
  **問題：** 查詢非“計算機科學與技術”專業中，比“計算機科學與技術”專業所有學生年齡都小的學生  
  **解答：**  
  ```sql
  SELECT Sname, Sbirthdate
  FROM Student
  WHERE Sbirthdate > ALL (
      SELECT Sbirthdate
      FROM Student
      WHERE Smajor = '計算機科學與技術'
  )
    AND Smajor <> '計算機科學與技術';
  ```

- **例3.62**  
  **問題：** 查詢所有選修了 81001 號課程的學生姓名（利用 EXISTS）  
  **解答：**  
  ```sql
  SELECT Sname
  FROM Student
  WHERE EXISTS (
      SELECT *
      FROM SC
      WHERE Sno = Student.Sno
        AND Cno = '81001'
  );
  ```

- **例3.63**  
  **問題：** 查詢沒有選修 81001 號課程的學生姓名  
  **解答：**  
  ```sql
  SELECT Sname
  FROM Student
  WHERE NOT EXISTS (
      SELECT *
      FROM SC
      WHERE Sno = Student.Sno
        AND Cno = '81001'
  );
  ```

- **例3.64**  
  **問題：** 查詢選修了全部課程的學生姓名  
  **解答：**  
  ```sql
  SELECT Sname
  FROM Student
  WHERE NOT EXISTS (
      SELECT *
      FROM Course
      WHERE NOT EXISTS (
          SELECT *
          FROM SC
          WHERE Sno = Student.Sno
            AND Cno = Course.Cno
      )
  );
  ```

- **例3.65**  
  **問題：** 查詢至少選修了學生 20180002 選修的全部課程的學生學號  
  **解答：**  
  ```sql
  SELECT Sno
  FROM Student
  WHERE NOT EXISTS (
      SELECT *
      FROM SC AS SCX
      WHERE SCX.Sno = '20180002'
        AND NOT EXISTS (
            SELECT *
            FROM SC AS SCY
            WHERE SCY.Sno = Student.Sno
              AND SCY.Cno = SCX.Cno
        )
  );
  ```

- **例3.66**  
  **問題：** 查詢“計算機科學與技術”專業的學生與年齡不大於 19 歲學生的聯集  
  **解答：**  
  ```sql
  SELECT *
  FROM Student
  WHERE Smajor = '計算機科學與技術'
  UNION
  SELECT *
  FROM Student
  WHERE (extract(year from current_date) - extract(year from Sbirthdate)) <= 19;
  ```

- **例3.67**  
  **問題：** 查詢 2020 年第 2 學期選修了 81001 或 81002 課程的學生  
  **解答：**  
  ```sql
  SELECT Sno
  FROM SC
  WHERE Semester = '20202' AND Cno = '81001'
  UNION
  SELECT Sno
  FROM SC
  WHERE Semester = '20202' AND Cno = '81002';
  ```

- **例3.68**  
  **問題：** 查詢“計算機科學與技術”專業的學生與年齡不大於 19 歲學生的交集  
  **解答（方法一，利用 INTERSECT）：**  
  ```sql
  SELECT *
  FROM Student
  WHERE Smajor = '計算機科學與技術'
  INTERSECT
  SELECT *
  FROM Student
  WHERE (extract(year from current_date) - extract(year from Sbirthdate)) <= 19;
  ```  
  **解答（方法二，條件合併）：**  
  ```sql
  SELECT *
  FROM Student
  WHERE Smajor = '計算機科學與技術'
    AND (extract(year from current_date) - extract(year from Sbirthdate)) <= 19;
  ```

- **例3.69**  
  **問題：** 查詢既選修了 81001 又選修了 81002 課程的學生（交集）  
  **解答（方法一）：**  
  ```sql
  SELECT Sno
  FROM SC
  WHERE Cno = '81001'
  INTERSECT
  SELECT Sno
  FROM SC
  WHERE Cno = '81002';
  ```  
  **解答（方法二，利用 IN）：**  
  ```sql
  SELECT Sno
  FROM SC
  WHERE Cno = '81001'
    AND Sno IN (
        SELECT Sno
        FROM SC
        WHERE Cno = '81002'
    );
  ```

- **例3.70**  
  **問題：** 查詢“計算機科學與技術”專業中年齡大於 19 歲的學生（即“計算機科學與技術”專業學生與年齡不大於 19 歲學生的差集）  
  **解答（方法一，利用 EXCEPT）：**  
  ```sql
  SELECT *
  FROM Student
  WHERE Smajor = '計算機科學與技術'
  EXCEPT
  SELECT *
  FROM Student
  WHERE (extract(year from current_date) - extract(year from Sbirthdate)) <= 19;
  ```  
  **解答（方法二，直接條件）：**  
  ```sql
  SELECT *
  FROM Student
  WHERE Smajor = '計算機科學與技術'
    AND (extract(year from current_date) - extract(year from Sbirthdate)) > 19;
  ```

---

以上為簡報中抽取的部分範例，包括問題描述與相對應的 SQL 解答。根據簡報內容，範例涵蓋了單表查詢、條件查詢、連接查詢、嵌套查詢、集合查詢以及基於派生表的查詢等多個主題，讀者可依據需求參考與學習。
