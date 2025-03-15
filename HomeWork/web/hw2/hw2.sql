-- 1. 如果已存在 schoolDB 数据库，则先删除（谨慎操作）
DROP DATABASE IF EXISTS schoolDB;

-- 2. 创建数据库 schoolDB
CREATE DATABASE schoolDB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- 3. 切换到 schoolDB 数据库
USE schoolDB;

-- 4. 创建 Student 表
CREATE TABLE Student (
    Sno VARCHAR(20) NOT NULL,         -- 学号
    Sname VARCHAR(50) NOT NULL,         -- 姓名
    Ssex CHAR(1) NOT NULL,              -- 性别（‘男’或‘女’可以用‘M’、‘F’或直接汉字）
    Sbirthdate DATE NOT NULL,           -- 出生日期
    Smajor VARCHAR(50) NOT NULL,        -- 主修专业
    PRIMARY KEY (Sno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 5. 创建 Course 表
CREATE TABLE Course (
    Cno VARCHAR(20) NOT NULL,           -- 课程号
    Cname VARCHAR(100) NOT NULL,        -- 课程名称
    Ccredit INT NOT NULL,               -- 学分
    Cpno VARCHAR(20),                   -- 先修课程号（可为空）
    PRIMARY KEY (Cno),
    -- 如果 Cpno 不为空，可以参考同一表中的 Cno（这里采用 ON DELETE SET NULL）
    FOREIGN KEY (Cpno) REFERENCES Course(Cno)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 6. 创建 SC 表（学生选课关系）
CREATE TABLE SC (
    Sno VARCHAR(20) NOT NULL,           -- 学生学号
    Cno VARCHAR(20) NOT NULL,           -- 课程号
    Grade INT,                          -- 成绩
    Semester VARCHAR(10),               -- 学期，如 '20201' 表示2020年第一学期
    Teachingclass VARCHAR(20),          -- 教学班
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES Student(Sno)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Cno) REFERENCES Course(Cno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 7. 插入 Student 表样例数据
INSERT INTO Student (Sno, Sname, Ssex, Sbirthdate, Smajor) VALUES
('20180001', '张三', '男', '2000-03-08', '信息安全'),
('20180002', '李四', '女', '2001-05-12', '计算机科学与技术'),
('20180003', '王五', '男', '2000-12-15', '信息安全'),
('20180004', '赵六', '女', '2001-01-20', '信息管理'),
('20180005', '孙七', '男', '2001-07-07', '计算机科学与技术');

-- 8. 插入 Course 表样例数据
INSERT INTO Course (Cno, Cname, Ccredit, Cpno) VALUES
('81001', '数据库系统', 3, NULL),
('81002', '数据结构', 4, NULL),
('81003', '计算机网络', 3, '81002'),
('81005', '操作系统', 3, NULL),
('81007', '编译原理', 3, '81005');

-- 9. 插入 SC 表样例数据
-- 示例说明：每条记录表示某个学生选修了某门课程，以及其成绩、学期和教学班信息
INSERT INTO SC (Sno, Cno, Grade, Semester, Teachingclass) VALUES
-- 学生20180001选修了81001, 81002, 81003
('20180001', '81001', 85, '20201', 'A1'),
('20180001', '81002', 90, '20201', 'A1'),
('20180001', '81003', 88, '20201', 'A1'),
-- 学生20180002选修了81003, 81005, 81007（满足题目6要求：同时选修81005与81007）
('20180002', '81003', 92, '20201', 'B1'),
('20180002', '81005', 87, '20201', 'B1'),
('20180002', '81007', 80, '20201', 'B1'),
-- 学生20180003选修了81001, 81003
('20180003', '81001', 78, '20201', 'C1'),
('20180003', '81003', 82, '20201', 'C1'),
-- 学生20180004选修了81002, 81005, 81007（满足题目6要求：同时选修81005与81007）
('20180004', '81002', 85, '20201', 'D1'),
('20180004', '81005', 90, '20201', 'D1'),
('20180004', '81007', 88, '20201', 'D1'),
-- 学生20180005选修了81001, 81002
('20180005', '81001', 75, '20201', 'E1'),
('20180005', '81002', 80, '20201', 'E1');
