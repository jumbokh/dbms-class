-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1:3307
-- 产生时间： 2025-03-06 16:02:34
-- 服务器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `school`
--

-- --------------------------------------------------------

--
-- 资料表结构 `员工`
--

CREATE TABLE `员工` (
  `身份证字号` char(10) NOT NULL,
  `姓名` varchar(12) DEFAULT NULL,
  `城市` char(5) DEFAULT NULL,
  `街道` varchar(30) DEFAULT NULL,
  `电话` char(12) DEFAULT NULL,
  `薪水` decimal(10,2) DEFAULT NULL,
  `保险` decimal(10,2) DEFAULT NULL,
  `扣税` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 倾印资料表的资料 `员工`
--

INSERT INTO `员工` (`身份证字号`, `姓名`, `城市`, `街道`, `电话`, `薪水`, `保险`, `扣税`) VALUES
('A123456789', '陈庆新', '台北', '信义路', '02-11111111', 80000.00, 5000.00, 2000.00),
('A221304680', '郭富城', '台北', '忠孝东路', '02-55555555', 35000.00, 1000.00, 800.00),
('A222222222', '杨金欉', '桃园', '中正路', '03-11111111', 80000.00, 4500.00, 2000.00),
('D333300333', '王心零', '桃园', '经国路', NULL, 50000.00, 2500.00, 1000.00),
('D444403333', '刘得华', '新北', '板桥区文心路', '04-55555555', 25000.00, 500.00, 500.00),
('E444006666', '小龙女', '新北', '板桥区中正路', '04-55555555', 25000.00, 500.00, 500.00),
('F213456780', '陈小安', '新北', '新店区四维路', NULL, 50000.00, 3000.00, 1000.00),
('F332213046', '张无忌', '台北', '仁爱路', '02-55555555', 50000.00, 1500.00, 1000.00),
('H098765432', '李鸿章', '基隆', '信四路', '02-33111111', 60000.00, 4000.00, 1500.00);

-- --------------------------------------------------------

--
-- 资料表结构 `学生`
--

CREATE TABLE `学生` (
  `学号` char(4) NOT NULL,
  `姓名` varchar(12) NOT NULL,
  `性别` char(2) DEFAULT NULL,
  `电话` varchar(15) DEFAULT NULL,
  `生日` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 倾印资料表的资料 `学生`
--

INSERT INTO `学生` (`学号`, `姓名`, `性别`, `电话`, `生日`) VALUES
('S001', '陈会安', '男', '02-22222222', '2003-09-03'),
('S002', '江小鱼', '女', '03-33333333', '2004-02-02'),
('S003', '张无忌', '男', '04-44444444', '2002-05-03'),
('S004', '陈小安', '男', '05-55555555', '2002-06-13'),
('S005', '孙燕之', '女', '06-66666666', NULL),
('S006', '周杰轮', '男', '02-33333333', '2003-12-23'),
('S007', '蔡一零', '女', '03-66666666', '2003-11-23'),
('S008', '刘得华', '男', '02-11111122', '2003-02-23');

-- --------------------------------------------------------

--
-- 资料表结构 `教授`
--

CREATE TABLE `教授` (
  `教授编号` char(4) NOT NULL,
  `职称` varchar(10) DEFAULT NULL,
  `科系` varchar(5) DEFAULT NULL,
  `身份证字号` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 倾印资料表的资料 `教授`
--

INSERT INTO `教授` (`教授编号`, `职称`, `科系`, `身份证字号`) VALUES
('I001', '教授', 'CS', 'A123456789'),
('I002', '教授', 'CS', 'A222222222'),
('I003', '副教授', 'CIS', 'H098765432'),
('I004', '讲师', 'MATH', 'F213456780');

-- --------------------------------------------------------

--
-- 资料表结构 `班级`
--

CREATE TABLE `班级` (
  `教授编号` char(4) NOT NULL,
  `学号` char(4) NOT NULL,
  `课程编号` char(5) NOT NULL,
  `上课时间` time DEFAULT NULL,
  `教室` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 倾印资料表的资料 `班级`
--

INSERT INTO `班级` (`教授编号`, `学号`, `课程编号`, `上课时间`, `教室`) VALUES
('I001', 'S001', 'CS101', '12:00:00', '180-M'),
('I001', 'S005', 'CS101', '12:00:00', '180-M'),
('I001', 'S006', 'CS101', '12:00:00', '180-M'),
('I001', 'S003', 'CS213', '09:00:00', '622-G'),
('I001', 'S005', 'CS213', '09:00:00', '622-G'),
('I001', 'S001', 'CS349', '15:00:00', '380-L'),
('I001', 'S003', 'CS349', '15:00:00', '380-L'),
('I002', 'S003', 'CS121', '08:00:00', '221-S'),
('I002', 'S008', 'CS121', '08:00:00', '221-S'),
('I002', 'S001', 'CS222', '13:00:00', '100-M'),
('I002', 'S002', 'CS222', '13:00:00', '100-M'),
('I002', 'S004', 'CS222', '13:00:00', '100-M'),
('I003', 'S001', 'CS203', '10:00:00', '221-S'),
('I003', 'S002', 'CS203', '14:00:00', '327-S'),
('I003', 'S006', 'CS203', '10:00:00', '221-S'),
('I003', 'S008', 'CS203', '10:00:00', '221-S'),
('I003', 'S001', 'CS213', '12:00:00', '500-K'),
('I003', 'S006', 'CS213', '12:00:00', '500-K'),
('I004', 'S002', 'CS111', '15:00:00', '321-M'),
('I004', 'S003', 'CS111', '15:00:00', '321-M'),
('I004', 'S005', 'CS111', '15:00:00', '321-M');

-- --------------------------------------------------------

--
-- 资料表结构 `课程`
--

CREATE TABLE `课程` (
  `课程编号` char(5) NOT NULL,
  `名称` varchar(30) DEFAULT NULL,
  `学分` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 倾印资料表的资料 `课程`
--

INSERT INTO `课程` (`课程编号`, `名称`, `学分`) VALUES
('CS101', '计算机概论', 4),
('CS111', '线性代数', 4),
('CS121', '离散数学', 4),
('CS203', '程序语言', 3),
('CS205', '网页程序设计', 3),
('CS213', '物件导向程序设计', 2),
('CS222', '数据库管理系统', 3),
('CS349', '物件导向分析', 3);

--
-- 已倾印资料表的索引
--

--
-- 资料表索引 `员工`
--
ALTER TABLE `员工`
  ADD PRIMARY KEY (`身份证字号`);

--
-- 资料表索引 `学生`
--
ALTER TABLE `学生`
  ADD PRIMARY KEY (`学号`);

--
-- 资料表索引 `教授`
--
ALTER TABLE `教授`
  ADD PRIMARY KEY (`教授编号`),
  ADD KEY `身份证字号` (`身份证字号`);

--
-- 资料表索引 `班级`
--
ALTER TABLE `班级`
  ADD PRIMARY KEY (`教授编号`,`课程编号`,`学号`),
  ADD KEY `学号` (`学号`),
  ADD KEY `课程编号` (`课程编号`);

--
-- 资料表索引 `课程`
--
ALTER TABLE `课程`
  ADD PRIMARY KEY (`课程编号`);

--
-- 已倾印资料表的限制式
--

--
-- 资料表的限制式 `教授`
--
ALTER TABLE `教授`
  ADD CONSTRAINT `教授_ibfk_1` FOREIGN KEY (`身份证字号`) REFERENCES `员工` (`身份证字号`);

--
-- 资料表的限制式 `班级`
--
ALTER TABLE `班级`
  ADD CONSTRAINT `班级_ibfk_1` FOREIGN KEY (`学号`) REFERENCES `学生` (`学号`),
  ADD CONSTRAINT `班级_ibfk_2` FOREIGN KEY (`课程编号`) REFERENCES `课程` (`课程编号`),
  ADD CONSTRAINT `班级_ibfk_3` FOREIGN KEY (`教授编号`) REFERENCES `教授` (`教授编号`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
