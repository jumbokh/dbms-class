-- 1. 建立資料庫 (若已存在同名資料庫可視情況選擇是否先DROP)
CREATE DATABASE IF NOT EXISTS StudentSelection;
USE StudentSelection;

-- 2. 建立 Student 表
--   Sno: 學號(主鍵)
--   Sname: 姓名
--   Ssex: 性別
--   Sbirthdate: 出生日期
--   Smajor: 主修專業
CREATE TABLE IF NOT EXISTS Student (
    Sno         CHAR(8)       NOT NULL,
    Sname       VARCHAR(20)   NOT NULL,
    Ssex        CHAR(1),
    Sbirthdate  DATE,
    Smajor      VARCHAR(50),
    PRIMARY KEY (Sno)
);

-- 3. 建立 Course 表
--   Cno: 課程號(主鍵)
--   Cname: 課程名
--   Ccredit: 學分
--   Cpno: 先修課(可為NULL)
CREATE TABLE IF NOT EXISTS Course (
    Cno     CHAR(5)       NOT NULL,
    Cname   VARCHAR(50)   NOT NULL,
    Ccredit INT,
    Cpno    CHAR(5),
    PRIMARY KEY (Cno),
    FOREIGN KEY (Cpno) REFERENCES Course(Cno)
);

-- 4. 建立 SC 表(學生選課記錄)
--   Sno: 學號(外鍵 -> Student.Sno)
--   Cno: 課程號(外鍵 -> Course.Cno)
--   Grade: 成績
--   Semester: 選課學期
--   Teachingclass: 教學班
--   這裡假設 (Sno, Cno, Semester) 組合為主鍵
CREATE TABLE IF NOT EXISTS SC (
    Sno             CHAR(8)     NOT NULL,
    Cno             CHAR(5)     NOT NULL,
    Grade           INT,
    Semester        CHAR(5),
    Teachingclass   VARCHAR(10),
    PRIMARY KEY (Sno, Cno, Semester),
    FOREIGN KEY (Sno) REFERENCES Student(Sno),
    FOREIGN KEY (Cno) REFERENCES Course(Cno)
);

-- 5. 插入 Student 表示例資料
INSERT INTO Student (Sno, Sname, Ssex, Sbirthdate, Smajor) VALUES
('20180001', '李勇',   '男', '2000-03-08', '信息安全'),
('20180002', '刘晨',   '女', '1999-09-01', '计算机科学与技术'),
('20180003', '王敏',   '女', '2001-08-01', '计算机科学与技术'),
('20180004', '张立',   '男', '2000-01-08', '计算机科学与技术'),
('20180205', '陈新奇', '男', '2001-11-01', '信息管理与信息系统'),
('20180306', '赵明',   '男', '2000-06-12', '数据科学与大数据技术'),
('20180307', '王佳佳', '女', '2001-12-07', '数据科学与大数据技术');

-- 6. 插入 Course 表示例資料
INSERT INTO Course (Cno, Cname, Ccredit, Cpno) VALUES
('81001', '程序设计基础与C语言', 4,    NULL),
('81002', '数据结构',         4,    '81001'),
('81003', '数据库系统概论',   4,    '81002'),
('81004', '信息系统概论',     4,    '81003'),
('81005', '操作系统',         4,    '81001'),
('81006', 'Python语言',       3,    '81002'),
('81007', '离散数学',         4,    NULL),
('81008', '大数据技术概论',   4,    '81003');

-- 7. 插入 SC 表示例資料 (學生選課記錄)
INSERT INTO SC (Sno, Cno, Grade, Semester, Teachingclass) VALUES
('20180001', '81001', 85, '20192', '81001-01'),
('20180001', '81002', 96, '20201', '81002-01'),
('20180001', '81003', 87, '20202', '81003-01'),

('20180002', '81001', 80, '20192', '81001-02'),
('20180002', '81002', 98, '20201', '81002-01'),
('20180002', '81003', 71, '20202', '81003-02'),

('20180003', '81001', 81, '20192', '81001-01'),
('20180003', '81002', 76, '20201', '81002-02'),

('20180004', '81001', 56, '20192', '81001-02'),
('20180004', '81003', 97, '20201', '81003-02'),

('20180205', '81003', 68, '20202', '81003-01');

-- 如果需要的話可以再執行 COMMIT 或檢查是否使用了事務控制
COMMIT;
