CREATE DATABASE 联络人;
USE 联络人;
CREATE TABLE 联络资料
(
	编号 char(4) NOT NULL,
	姓名 varchar(12) NOT NULL,
	性别 char(2) NULL,
	电话 varchar(15) NULL,
	生日 datetime NULL,
PRIMARY KEY (编号)
); 
