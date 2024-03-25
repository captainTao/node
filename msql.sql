-- 创建数据库learjdbc:
DROP DATABASE IF EXISTS learnjdbc;
CREATE DATABASE learnjdbc;

-- 如果你运行的是最新版MySQL 8.x，需要调整一下CREATE USER语句
-- 创建登录用户learn/口令learnpassword
CREATE USER IF NOT EXISTS learn@'%' IDENTIFIED BY 'learnpassword';
GRANT ALL PRIVILEGES ON learnjdbc.* TO learn@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- 创建表students:
USE learnjdbc;
CREATE TABLE students (
  id BIGINT AUTO_INCREMENT NOT NULL,
  name VARCHAR(50) NOT NULL,
  gender TINYINT(1) NOT NULL,
  grade INT NOT NULL,
  score INT NOT NULL,
  PRIMARY KEY(id)
) Engine=INNODB DEFAULT CHARSET=UTF8;

-- 插入初始数据:
INSERT INTO students (name, gender, grade, score) VALUES ('小明', 1, 1, 88);
INSERT INTO students (name, gender, grade, score) VALUES ('小红', 1, 1, 95);
INSERT INTO students (name, gender, grade, score) VALUES ('小军', 0, 1, 93);
INSERT INTO students (name, gender, grade, score) VALUES ('小白', 0, 1, 100);
INSERT INTO students (name, gender, grade, score) VALUES ('小牛', 1, 2, 96);
INSERT INTO students (name, gender, grade, score) VALUES ('小兵', 1, 2, 99);
INSERT INTO students (name, gender, grade, score) VALUES ('小强', 0, 2, 86);
INSERT INTO students (name, gender, grade, score) VALUES ('小乔', 0, 2, 79);
INSERT INTO students (name, gender, grade, score) VALUES ('小青', 1, 3, 85);
INSERT INTO students (name, gender, grade, score) VALUES ('小王', 1, 3, 90);
INSERT INTO students (name, gender, grade, score) VALUES ('小林', 0, 3, 91);
INSERT INTO students (name, gender, grade, score) VALUES ('小贝', 0, 3, 77);


CREATE TABLE `websites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL DEFAULT '' COMMENT '站点名称',
  `url` varchar(255) NOT NULL DEFAULT '',
  `alexa` int(11) NOT NULL DEFAULT '0' COMMENT 'Alexa 排名',
  `country` char(10) NOT NULL DEFAULT '' COMMENT '国家',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `websites` VALUES ('1', 'Google', 'https://www.google.cm/', '1', 'USA'), ('2', '淘宝', 'https://www.taobao.com/', '13', 'CN'), ('3', '菜鸟教程', 'http://www.runoob.com', '5892', ''), ('4', '微博', 'http://weibo.com/', '20', 'CN'), ('5', 'Facebook', 'https://www.facebook.com/', '3', 'USA');

==================================================================

windows安装msql:  http://blog.csdn.net/u013235478/article/details/50623693
mac安装mysql: http://www.cnblogs.com/chenmo-xpw/p/6102933.html
接口测试对mysql: http://www.cnblogs.com/weke/articles/6399482.html


数据库Oracle学习： http://blog.csdn.net/qq_25409579?viewmode=contents
主外键： http://blog.csdn.net/bingqingsuimeng/article/details/51595560


在ubuntu上安装mysql:
https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-18-04

• sudo apt update 
• sudo apt install mysql-server 
• sudo mysql_secure_installation

检查mysql用户账户：
$ sudo mysql
$ mysql> SELECT user,authentication_string,plugin,host FROM mysql.user;

mac:

1.brew install mysql

We've installed your MySQL database without a root password. To secure it run:
    mysql_secure_installation

MySQL is configured to only allow connections from localhost by default

To connect run:
    mysql -uroot

To have launchd start mysql now and restart at login:
  brew services start mysql
Or, if you don't want/need a background service you can just run:
  mysql.server start

2.bash mysql.server start

3.mysql -uroot (-p)


增删改查：insert into / delete from /update..set /select * from 
insert into students (name, sex, age) values("孙丽华", "女", 21);
delete from students where age<20;
update students set school='JingHua', contry='CNA' where id =1;
select * from students where id<5 and age>20;


////////////////////////////////////////////////////////////////////////////////////////

数据库知识点：
1.增删改查，排序，过滤，总结，分组,统计
2.对数据存储的理解
3.主外键
4.多表查询
5.乐观锁，悲观锁
6.orcle用例设计
7.金融app用例设计
8.如何执行存储
9.存储与python间的关系
10.数据库自动化与python
11.聚合函数
12.sql语句导入文本执行

什么是聚合函数
查询时需要做一些数据统计，比如：查询职员表中各部门职员的平均薪水，各部门的员工人数。当需要统计的数据并不能在职员表里直观列出，而是需要根据现有的数据计算得到结果，这种功能可以使用聚合函数来实现，即：将表的全部数据划分为几组数据，每组数据统计出一个结果。
因为是多行数据参与运算返回一行结果，也称作分组函数、多行函数、集合函数。用到的关键字：
GOURP BY 按什么分组
HAVING 进一步限制分组结果
Select count(*),e.EMPNAME from EMP e where 1=1 group by  e.EMPNAME ; 按照员工进行分组，并查询出相同员工的名字以及数量。

select count(*) from students where age <= 26 group by sex;


增删改查、升序降序、连接查询、存储过程、主外键等数据库和测试案例

Oracle 的左右链接以及sql用例   
有+号的表不全部显示，对面的表全部显示。
口诀:右外连接+在左  左外连接+在右 有+不全显  无+就全显

左外连接 (左边的表不加限制)
右外连接(右边的表不加限制)
全外连接(左右两表都不加限制)
右外连接
Select   e.EMPNO,e.EMPNAME  from DEPT d,EMPT e where  d.DEPTNO(+)=e.DEPTNO；
左外连接
Select   e.EMPNO,e.EMPNAME  from DEPT d,EMPT e where  d.DEPTNO=e.DEPTNO(+)；


String：字符串常量
StringBuffer：字符串变量  线程安全 
StringBuilder: 字符串变量  线程非安全

//////////////////////////////////////////////////////////////////////////////
复制表格框架：
create table a like b;

复制表格：
create table qq select * from students where sex = "女";
create table qq select name, age from students where sex = "女";

check:
alter table students add check (sex="女" or sex="男");

order by:
升序（ASC）也可以是降序（DESC），缺省是升序。
select * from students order by age;
select * from students order by age desc, id asc; //两个条件

查询嵌套：
select * from students where age in (select age from students where sex = '女');

去掉重复的查询：
select distinct * from students;
select distinct name, sex, age from students;

查询为空的，非空的：
select * from students where count is null;
select * from students where contry is not null;

查询前五条数据：
select * from students limit 5; // 从第0条开始取5个数据
select age from students limit 3,5; // 从第三条开始取5个数据

统计count:
select count(*) from students where sex = '女';
select count(name) from students where sex = '男';
select count(tel),count(school),count(contry) from students where sex = '女';
+-------------+
| count(name) |
+-------------+
|           6 |
+-------------+

统计min/max:
select min(age) from students where sex = '女';
select max(age) from students where sex = '女';
+----------+
| min(age) |
+----------+
|       23 |
+----------+

统计sum,avg:
select avg(age) from students where sex = '女';
select sum(age) from students where sex = '女';
+----------+
| avg(age) |
+----------+
|  25.0000 |
+----------+

查询两个表：
select ss.age, students.name from ss, students where ss.age = students.age;

笛卡尔积：
select ss.name, students.age from ss, students;

group，having:
mysql> select sex, count(*) from students where age <= 26 group by sex;
+-----+----------+
| sex | count(*) |
+-----+----------+
| 女  |        5 |
| 男  |        5 |
+-----+----------+

mysql> select age, count(*) from students where sex = '女' group by age having age <= 26;
+-----+----------+
| age | count(*) |
+-----+----------+
|  23 |        1 |
|  24 |        1 |
|  26 |        3 |
+-----+----------+

// 且用and
mysql> select count(*) from students where score >= 90 and gender = 1;
+----------+
| count(*) |
+----------+
|        4 |
+----------+

mysql> select gender, count(*) from students where score >= 90 group by gender having gender =1;
+--------+----------+
| gender | count(*) |
+--------+----------+
|      1 |        4 |
+--------+----------+

mysql> select gender, count(*) from students where score >= 90 and gender = 1;
+--------+----------+
| gender | count(*) |
+--------+----------+
|      1 |        4 |
+--------+----------+


<--------------------------------------------------------->
mysql> select * from students order by name;
+----+--------+--------+-------+
| id | name   | sub    | score |
+----+--------+--------+-------+
|  1 | 王刚   | 数学   |    76 |
|  5 | 王刚   | 语文   |    82 |
|  8 | 王刚   | 外语   |    76 |
|  4 | 王帅   | 外语   |    99 |
|  7 | 王帅   | 语文   |    78 |
|  9 | 王帅   | 数学   |    80 |
|  2 | 王海   | 语文   |    92 |
|  3 | 王海   | 数学   |    72 |
| 10 | 王海   | 外语   |    97 |
+----+--------+--------+-------+
9 rows in set (0.00 sec)

// 列出每个人对应的最高分；
mysql> select name, max(score) as max_score from students group by name; 
+--------+-----------+
| name   | max_score |
+--------+-----------+
| 王刚   |        82 |
| 王帅   |        99 |
| 王海   |        97 |
+--------+-----------+
3 rows in set (0.00 sec)


// 列出每门课的最高分，并列出其他项目
mysql> select sub, score, name, id from students where score in (select max(score) as max_score from students where score>90 group by sub);
+--------+-------+--------+----+
| sub    | score | name   | id |
+--------+-------+--------+----+
| 语文   |    92 | 王海   |  2 |
| 外语   |    99 | 王帅   |  4 |
+--------+-------+--------+----+
2 rows in set (0.00 sec)



mysql> select id, grade, gender, score as max_sc from students where score in (select max(score) from students group by gender);
+----+-------+--------+--------+
| id | grade | gender | max_sc |
+----+-------+--------+--------+
|  4 |     1 |      0 |    100 |
|  6 |     2 |      1 |     99 |
+----+-------+--------+--------+
2 rows in set (0.00 sec)

mysql> select id, grade, gender, score as max_sc from students where score in (select max(score) from students group by grade);
+----+-------+--------+--------+
| id | grade | gender | max_sc |
+----+-------+--------+--------+
|  4 |     1 |      0 |    100 |
|  6 |     2 |      1 |     99 |
| 11 |     3 |      0 |     91 |
+----+-------+--------+--------+
3 rows in set (0.00 sec)

mysql> select id, grade, gender, score as max_sc from students where score in (select max(score) from students group by gender);
+----+-------+--------+--------+
| id | grade | gender | max_sc |
+----+-------+--------+--------+
|  4 |     1 |      0 |    100 |
|  6 |     2 |      1 |     99 |
+----+-------+--------+--------+
2 rows in set (0.00 sec)


////////////////////////////////////////////////////////////////////////////////////////


提升sql查询速度：

refer to : https://mp.weixin.qq.com/s/aIaIxVMsR1aYG-zfVqC-GQ
提升查询速度的方向：一是提升硬件(内存、cpu、硬盘)，二是在软件上优化（加索引、优化sql；优化sql不在本文阐述范围之内）。


索引类型：
MySQL的索引类型有5种：
主键索引、普通索引、唯一索引、全文索引、组合索引（多列索引）

普通索引（index）：  仅仅只是为了提高查询的速度。
唯一索引（unique index）： 防止数据出现重复
主键索引（primary key）：引保证数据的唯一性,而且不能为NULL
全文索引（fulltext key）：从字段中提取的特别关键词
组合索引（多列索引）：创建在多列上的索引


索引语法：
查看某张表的索引：show index from 表名；
创建普通索引：alter table 表名 add index  索引名 (加索引的列)
创建组合索引：alter table 表名 add index  索引名 (加索引的列1,加索引的列2)
删除某张表的索引：drop index 索引名 on 表名;

性能测试：
用存储过程插入一千万条数据，然后进行对比...........


////////////////////////////////////////////////////////////////////////////////////////

在mysql中检查编码格式，用如下命令，一般用utf-8
mysql> show variables like '%char%';

+--------------------------+------------------------------------------------------+
| character_set_client     | utf8                                                 |
| character_set_connection | utf8                                                 |
| character_set_database   | utf8                                                 |
| character_set_filesystem | binary                                               |
| character_set_results    | utf8                                                 |
| character_set_server     | utf8                                                 |
| character_set_system     | utf8                                                 |
| character_sets_dir       | /usr/local/Cellar/mysql/5.7.19/share/mysql/charsets/ |
+--------------------------+------------------------------------------------------+
8 rows in set (0.06 sec)


付费的商用数据库：
  w Oracle，典型的高富帅；
  w SQL Server，微软自家产品，Windows定制专款；
  w DB2，IBM的产品，听起来挺高端；
  w Sybase，曾经跟微软是好基友，后来关系破裂，现在家境惨淡。

免费数据库：
  w MySQL，大家都在用，一般错不了；
  w PostgreSQL，学术气息有点重，其实挺不错，但知名度没有MySQL高；
  w sqlite，嵌入式数据库，适合桌面和移动应用。


Linux下mysql命令 导入 导出sql文件
导出数据库
直接使用命令：
mysqldump -u root -p abc >abc.sql
然后回车输入密码就可以了；
mysqldump -u 数据库链接用户名 -p  目标数据库 > 存储的文件名
文件会导出到当前目录下
导入数据库（sql文件）
mysql -u 用户名 -p  数据库名 < 数据库名.sql
mysql -u abc -p abc < abc.sql
注意sql文件必须在当前目录下，如果不在当前目录下需要在< 之后加上具体sql文件路径
>  mysql -u root samp_db < /Users/captain/Desktop/test.sql 
sql命令行下导入：
mysql> source /Users/captain/Desktop/test.sql;
NoSQL
MySQL的相关概念介绍
MySQL 为关系型数据库(Relational Database Management System), 这种所谓的"关系型"可以理解为"表格"的概念, 一个关系型数据库由一个或数个表格组成, 如图所示的一个表格:

  • 表头(header): 每一列的名称;
  • 列(row): 具有相同数据类型的数据的集合;
  • 行(col): 每一行用来描述某个人/物的具体信息;
  • 值(value): 行的具体信息, 每个值必须与该列的数据类型相同;
  • 键(key): 表中用来识别某个特定的人\物的方法, 键的值在当前列中具有唯一性。
 
Windows下MySQL的配置
以 MySQL 5.1 免安装版为例, 下载 mysql-noinstall-5.1.69-win32.zip ( 官方下载页:http://dev.mysql.com/downloads/mysql/5.1.html#downloads )
配置步骤:
1. 将下载的 mysql-noinstall-5.1.69-win32.zip 解压至需要安装的位置, 如: C:\Program Files;
2. 在安装文件夹下找到 my-small.ini 配置文件, 将其重命名为 my.ini , 打开进行编辑, 在 [client] 与 [mysqld] 下均添加一行: default-character-set = gbk
3. 打开 Windows 环境变量设置, 新建变量名 MYSQL_HOME , 变量值为 MySQL 安装目录路径, 这里为 C:\Program Files\mysql-5.1.69-win32
4. 在 环境变量 的 Path 变量中添加 ;%MYSQL_HOME%\bin;
5. 安装 MySQL 服务, 打开Windows命令提示符, 执行命令: mysqld --install MySQL --defaults-file="my.ini" 提示"Service successfully installed."表示成功;
 
MySQL服务的启动、停止与卸载
在 Windows 命令提示符下运行:
启动: net start MySQL
停止: net stop MySQL
卸载: sc delete MySQL
 
MySQL脚本的基本组成
与常规的脚本语言类似, MySQL 也具有一套对字符、单词以及特殊符号的使用规定, MySQL 通过执行 SQL 脚本来完成对数据库的操作, 该脚本由一条或多条MySQL语句(SQL语句 + 扩展语句)组成, 保存时脚本文件后缀名一般为 .sql。在控制台下, MySQL 客户端也可以对语句进行单句的执行而不用保存为.sql文件。
标识符
标识符用来命名一些对象, 如数据库、表、列、变量等, 以便在脚本中的其他地方引用。MySQL标识符命名规则稍微有点繁琐, 这里我们使用万能命名规则: 标识符由字母、数字或下划线(_)组成, 且第一个字符必须是字母或下划线。
对于标识符是否区分大小写取决于当前的操作系统, Windows下是不敏感的, 但对于大多数 linux\unix 系统来说, 这些标识符大小写是敏感的。
 
关键字:
 
MySQL的关键字众多, 这里不一一列出, 在学习中学习。 这些关键字有自己特定的含义, 尽量避免作为标识符。
 
语句:
MySQL语句是组成MySQL脚本的基本单位, 每条语句能完成特定的操作, 他是由 SQL 标准语句 + MySQL 扩展语句组成。
 
函数:
MySQL函数用来实现数据库操作的一些高级功能, 这些函数大致分为以下几类: 字符串函数、数学函数、日期时间函数、搜索函数、加密函数、信息函数。
 
MySQL中的数据类型
MySQL有三大类数据类型, 分别为数字、日期\时间、字符串, 这三大类中又更细致的划分了许多子类型:
  • 数字类型
    ○ 整数: tinyint、smallint、mediumint、int、bigint
    ○ 浮点数: float、double、real、decimal
  • 日期和时间: date、time、datetime、timestamp、year
  • 字符串类型
    ○ 字符串: char、varchar
    ○ 文本: tinytext、text、mediumtext、longtext
    ○ 二进制(可用来存储图片、音乐等): tinyblob、blob、mediumblob、longblob
这里不能详细对这些类型进行介绍了, 篇幅可能会很长, 详细介绍参见: 《MySQL数据类型》 :http://www.cnblogs.com/zbseoag/archive/2013/03/19/2970004.html
 
使用MySQL数据库
登录到MySQL
当 MySQL 服务已经运行时, 我们可以通过MySQL自带的客户端工具登录到MySQL数据库中, 首先打开命令提示符, 输入以下格式的命名:
mysql -h 主机名 -u 用户名 -p
  • -h : 该命令用于指定客户端所要登录的MySQL主机名, 登录当前机器该参数可以省略;
  • -u : 所要登录的用户名;
  • -p : 告诉服务器将会使用一个密码来登录, 如果所要登录的用户名密码为空, 可以忽略此选项。
以登录刚刚安装在本机的MySQL数据库为例, 在命令行下输入 mysql -u root -p 按回车确认, 如果安装正确且MySQL正在运行, 会得到以下响应:
Enter password:
若密码存在, 输入密码登录, 不存在则直接按回车登录, 按照本文中的安装方法, 默认 root 账号是无密码的。登录成功后你将会看到 Welecome to the MySQL monitor... 的提示语。
然后命令提示符会一直以 mysql> 加一个闪烁的光标等待命令的输入, 输入 exit 或 quit 退出登录。
创建一个数据库
使用 create database 语句可完成对数据库的创建, 创建命令的格式如下:
create database 数据库名 [其他选项];
例如我们需要创建一个名为 samp_db 的数据库, 在命令行下执行以下命令:
create database samp_db character set gbk;
为了便于在命令提示符下显示中文, 在创建时通过 character set gbk 将数据库字符编码指定为 gbk。创建成功时会得到 Query OK, 1 row affected(0.02 sec) 的响应。
注意: MySQL语句以分号(;)作为语句的结束, 若在语句结尾不添加分号时, 命令提示符会以 -> 提示你继续输入(有个别特例, 但加分号是一定不会错的);
提示: 可以使用 show databases; 命令查看已经创建了哪些数据库。
选择所要操作的数据库
要对一个数据库进行操作, 必须先选择该数据库, 否则会提示错误:
ERROR 1046(3D000): No database selected
两种方式对数据库进行使用的选择:
一: 在登录数据库时指定, 命令: mysql -D 所选择的数据库名 -h 主机名 -u 用户名 -p
例如登录时选择刚刚创建的数据库: mysql -D samp_db -u root -p
二: 在登录后使用 use 语句指定, 命令: use 数据库名;
use 语句可以不加分号, 执行 use samp_db 来选择刚刚创建的数据库, 选择成功后会提示: Database changed
创建数据库表
使用 create table 语句可完成对表的创建, create table 的常见形式:
create table 表名称(列声明);
以创建 students 表为例, 表中将存放 学号(id)、姓名(name)、性别(sex)、年龄(age)、联系电话(tel) 这些内容:
  create table students
  （
    id int unsigned not null auto_increment primary key,
    name char(8) not null,
    sex char(4) not null,
    age tinyint unsigned not null,
    tel char(13) null default "-"
  );
        
对于一些较长的语句在命令提示符下可能容易输错, 因此我们可以通过任何文本编辑器将语句输入好后保存为 createtable.sql 的文件中, 通过命令提示符下的文件重定向执行执行该脚本。
打开命令提示符, 输入: mysql -D samp_db -u root -p < createtable.sql
(提示: 1.如果连接远程主机请加上 -h 指令; 2. createtable.sql 文件若不在当前工作目录下需指定文件的完整路径。)
语句解说:
create table tablename(columns) 为创建数据库表的命令, 列的名称以及该列的数据类型将在括号内完成;
括号内声明了5列内容, id、name、sex、age、tel为每列的名称, 后面跟的是数据类型描述, 列与列的描述之间用逗号(,)隔开;
以 "id int unsigned not null auto_increment primary key" 行进行介绍:
  • "id" 为列的名称;
  • "int" 指定该列的类型为 int(取值范围为 -8388608到8388607), 在后面我们又用 "unsigned" 加以修饰, 表示该类型为无符号型, 此时该列的取值范围为 0到16777215;
  • "not null" 说明该列的值不能为空, 必须要填, 如果不指定该属性, 默认可为空;
  • "auto_increment" 需在整数列中使用, 其作用是在插入数据时若该列为 NULL, MySQL将自动产生一个比现存值更大的唯一标识符值。在每张表中仅能有一个这样的值且所在列必须为索引列。
  • "primary key" 表示该列是表的主键, 本列的值必须唯一, MySQL将自动索引该列。
下面的 char(8) 表示存储的字符长度为8, tinyint的取值范围为 -127到128, default 属性指定当该列值为空时的默认值。
更多的数据类型请参阅 《MySQL数据类型》 :http://www.cnblogs.com/zbseoag/archive/2013/03/19/2970004.html
提示: 1. 使用 show tables; 命令可查看已创建了表的名称; 2. 使用 describe 表名; 命令可查看已创建的表的详细信息。
 


//////////////////////////////////////////////////////////////////////////////
操作MySQL数据库
增删改查：insert into / delete from /update..set /select * from 
insert into students (name, sex, age) values("孙丽华", "女", 21);
delete from students where age<20;
update students set school='JingHua', contry='CNA' where id =1;
select * from students where id<5 and age>20;

向表中插入数据
insert 语句可以用来将一行或多行数据插到数据库表中, 使用的一般形式如下:
insert [into] 表名 [(列名1, 列名2, 列名3, ...)] values (值1, 值2, 值3, ...);
其中 [] 内的内容是可选的, 例如, 要给 samp_db 数据库中的 students 表插入一条记录, 执行语句:
insert into students values(NULL, "王刚", "男", 20, "13811371377");
按回车键确认后若提示 Query Ok, 1 row affected (0.05 sec) 表示数据插入成功。 若插入失败请检查是否已选择需要操作的数据库。
有时我们只需要插入部分数据, 或者不按照列的顺序进行插入, 可以使用这样的形式进行插入:
insert into students (name, sex, age) values("孙丽华", "女", 21);
查询表中的数据
select 语句常用来根据一定的查询规则到数据库中获取数据, 其基本的用法为:
select 列名称 from 表名称 [查询条件];
例如要查询 students 表中所有学生的名字和年龄, 输入语句 select name, age from students; 执行结果如下:
  mysql> select name, age from students;
  +--------+-----+
  | name   | age |
  +--------+-----+
  | 王刚   |  20 |
  | 孙丽华 |  21 |
  | 王永恒 |  23 |
  | 郑俊杰 |  19 |
  | 陈芳   |  22 |
  | 张伟朋 |  21 |
  +--------+-----+
  6 rows in set (0.00 sec)
mysql>
也可以使用通配符 * 查询表中所有的内容, 语句: select * from students;
按特定条件查询:
where 关键词用于指定查询条件, 用法形式为: select 列名称 from 表名称 where 条件;
以查询所有性别为女的信息为例, 输入查询语句: select * from students where sex="女";
where 子句不仅仅支持 "where 列名 = 值" 这种名等于值的查询形式, 对一般的比较运算的运算符都是支持的, 例如 =、>、<、>=、<、!= 以及一些扩展运算符 is [not] null、in、like 等等。 还可以对查询条件使用 or 和 and 进行组合查询, 以后还会学到更加高级的条件查询方式, 这里不再多做介绍。
示例:
查询年龄在21岁以上的所有人信息: select * from students where age > 21;
查询名字中带有 "王" 字的所有人信息: select * from students where name like "%王%";
查询id小于5且年龄大于20的所有人信息: select * from students where id<5 and age>20;
更新表中的数据
update 语句可用来修改表中的数据, 基本的使用形式为:
update 表名称 set 列名称=新值 where 更新条件;
使用示例:
将id为5的手机号改为默认的"-": update students set tel=default where id=5;
将所有人的年龄增加1: update students set age=age+1;
将手机号为 13288097888 的姓名改为 "张伟鹏", 年龄改为 19: 
update students set name="张伟鹏", age=19 where tel="13288097888";
更新多项：
update students set school='JingHua', contry='CNA' where id =1;
多条件更新：
update students set school='MIT'where sex='女' and age=23;
删除表中的数据
delete 语句用于删除表中的数据, 基本用法为:
delete from 表名称 where 删除条件;
使用示例:
删除id为2的行: delete from students where id=2;
删除所有年龄小于21岁的数据: delete from students where age<20;
删除表中的所有数据: delete from students;
 

-------------------------------------------------
创建后表的修改
alter table xx
add/drop/change
rename/drop/create
下列语句可以混合使用：
mysql> alter table students change contr contry char(4), change address addr char(8), drop job, add married char(4);
alter table 语句用于创建后对表的修改, 基础用法如下:
添加列
基本形式: alter table 表名 add 列名 列数据类型 [after 插入位置];
增加多列： mysql> alter table students add schl char(10), add major char(10);
示例:
在表的最后追加列 address: alter table students add address char(60);
在名为 age 的列后插入列 birthday: alter table students add birthday date after age;
修改列
基本形式: alter table 表名 change 列名称 列新名称 新数据类型;
示例:
将表 tel 列改名为 telphone: alter table students change tel telphone char(13) default "-";
将 name 列的数据类型改为 char(16): alter table students change name name char(16) not null;
删除列
基本形式: alter table 表名 drop 列名称;
示例:
删除 birthday 列: alter table students drop birthday;

重命名表
基本形式: alter table 表名 rename 新表名;
示例:
重命名 students 表为 workmates: alter table students rename workmates;
删除整张表
基本形式: drop table 表名;
示例: 删除 workmates 表: drop table workmates;
删除整个数据库
基本形式: drop database 数据库名;
示例: 删除 samp_db 数据库: drop database samp_db;
复制整张表
create table b like a --全部复制A表的结构 
复制表格：
create table qq select * from students where sex = "女";
create table qq select name, age from students where sex = "女";



附录
修改 root 用户密码
按照本文的安装方式, root 用户默认是没有密码的, 重设 root 密码的方式也较多, 这里仅介绍一种较常用的方式。
使用 mysqladmin 方式:
打开命令提示符界面, 执行命令: mysqladmin -u root -p password 新密码
执行后提示输入旧密码完成密码修改, 当旧密码为空时直接按回车键确认即可。
可视化管理工具 MySQL Workbench
尽管我们可以在命令提示符下通过一行行的输入或者通过重定向文件来执行mysql语句, 但该方式效率较低, 由于没有执行前的语法自动检查, 输入失误造成的一些错误的可能性会大大增加, 这时不妨试试一些可视化的MySQL数据库管理工具, MySQL Workbench 就是 MySQL 官方 为 MySQL 提供的一款可视化管理工具, 你可以在里面通过可视化的方式直接管理数据库中的内容, 并且 MySQL Workbench 的 SQL 脚本编辑器支持语法高亮以及输入时的语法检查, 当然, 它的功能强大, 绝不仅限于这两点。
MySQL Workbench官方介绍: http://www.mysql.com/products/workbench/
MySQL Workbench 下载页: http://dev.mysql.com/downloads/tools/workbench/

来自 <http://www.cnblogs.com/mr-wid/archive/2013/05/09/3068229.html> 



check:
alter table students add check (sex="女" or sex="男");

order by:
select * from students order by age;

查询嵌套：
select * from students where age in (select age from students where sex = '女');

复制表格：
create table qq select * from students where sex = "女";
create table qq select name, age from students where sex = "女";




/////////////////////////////////////////////////////////////

https://blog.51cto.com/13767724/2170047
.新建用户
  1.2 创建用户：
  create user 'username'@'host' identified by 'password';
  insert into mysql.user(Host,User,Password) values("localhost","test",password("1234"));
  SHOW GRANTS FOR 'root'@'%'; //查看
  注意：此处的"localhost"，是指该用户只能在本地登录，不能在另外一台机器上远程登录。如果想远程登录的话，将"localhost"改为"%"，表示在任何一台电脑上都可以登录。也可以指定某台机器可以远程登录
2.为用户授权
  授权格式：grant 权限 on 数据库. to 用户名@登录主机 identified by "密码";
  2.1 登录MYSQL（有ROOT权限），这里以ROOT身份登录：
  mysql -u root -p
  密码
2.2 首先为用户创建一个数据库(testDB)：
  CREATE DATABASE mydb CHARACTER SET utf8 COLLATE utf8generalci; //创建库，指定字符集
  create database testDB;
2.3 授权test用户拥有testDB数据库的所有权限（某个数据库的所有权限）：
  grant all privileges on testDB. * to test@localhost identified by "1234";
  flush privileges;//刷新系统权限表
  格式：grant 权限 on 数据库. to 用户名@登录主机 identified by "密码";
2.4 如果想指定部分权限给一用户，可以这样来写:
  grant select,insert,update,delete on . to test1@"%" Identified by "abc";
  flush privileges; //刷新系统权限表
2.5 授权test用户拥有所有数据库的某些权限：
  grant select,delete,update,create,drop on . * to test@"%" identified by "1234";
  test用户对所有数据库都有select,delete,update,create,drop 权限。
  @"%" 表示对所有非本地主机授权，不包括localhost。（localhost地址设为127.0.0.1，如果设为真实的本地地址，不知道是否可以，没有验证。）
  对localhost授权：加上一句grant all privileges on testDB. to test@localhost identified by '1234';即可。
取消用户权限
  revoke all on . from localhost@'localhost'; //取消
  SHOW GRANTS FOR 'localhost'@'localhost'; //查看
3. 删除用户
  Delete FROM mysql.user Where User='test' and Host='localhost';
  flush privileges;
  drop database testDB; //删除用户的数据库
  删除账户及权限：drop user 用户名@'%';
  drop user 用户名@ localhost;
4. 修改指定用户密码
  update mysql.user set password=password('新密码') where User="test" and Host="localhost";
  flush privileges;
5. 列出所有数据库
  show database;
6. 切换数据库
  use '数据库名';
7. 列出所有表
  show tables;
8. 显示数据表结构escribe 表名;
9. 删除数据库和数据表
  drop database 数据库名;
  drop table 数据表名;
10. MySql ip限制
  select user,host from user;
  grant all on * . * to root@'%' identified by 'mysqlpassword'; //#代表


------------------------------------------------------------------------------------
Create tableà建表时必须明确指明表空间/索引表空间
1.创建普通表
create table A(id int not null primary key,name varchar(50))
 
2.复制其他表的结构
   create table b like a --全部复制A表的结构
 
   create table c as (select * from a ) definition only;  --用definition only去复制其他表的结构，可以值复制其他表的某个字段
   create table d(id) as (select id from a) definition only;
 
3.创建表的时候不写日志 —  可以大大的节约存储空间
  create table e (id int,name varchar(50))not logged initially in+表空间
 
在原来的表上面添加一个字段名
alter table q add column name varchar(60)
UNIQUE 约束唯一标识数据库表中的每条记录,并且是非空的集合
UNIQUE 和 PRIMARY KEY 约束均为列或列集合提供了唯一性的保证。
PRIMARY KEY 拥有自动定义的 UNIQUE 约束。
 
  请注意，每个表可以有多个 UNIQUE 约束，但是每个表只能有一个 PRIMARY KEY 约束。
主键
主键必须包含唯一值，主键不是null值。
1.单个主键的创建
  A.在创建表格的时候同时创建主键
    例1：create table sq_test
      (
      id int not null primary key,
      name varchar(50)
      )
     例2：create table sq_test1
      (
      id int not null,
      name varchar(50),
      primary key(id)
      )
  B.创建表后，在表中添加主键
     例： Alter Table sq_test1 add primary key(id)
 
       删除主键：alter table sq_test1 drop primary key
 
2.多个主键的创建
   Constraint PK_name primary key(字段名1,字段名2)/PK_name可以随意命名
    
A.创建表的同时创建多个主键
    例1：Create Table SQ
      (
        id int not null,
        name varchar(50) not null,
        constraint pk_key primary key(id, name)
        )
  删除多个主键：alter table sq drop constraint pk_key
  
b.表创建成功后，为表增加多个主键
例2：   alter table sq add constraint pk_key1 primary key(ID, name)
    
 
 
 
 
 
 
外键
Foreign key; 一个表中的 foreign key 指向另一个表中的 primary key
Foreign key reference table_name(主键字段名)
 
1.一个外键
    例1：create table test1
    (
      Id_o int not null,
      ID int,
      primary key(id_o),
      foreign key(id) references SQ8(ID)
      )
   例2：create table test1
    (
      Id_o int not null primary key,
      name varchar(50) not null,
      ID int foreign key references SQ8(ID)
      )
建好表后为其添加一个外键
alter table test1 add foreign key(id) references sq8(id)
 
2.多个外键
Constraint 
 
例1：create table test1
    (
      Id_o int not null primary key,
      name varchar(50) not null,
      ID int,--foreign key references SQ8(ID)
      constraint fk_key foreign key(id)
      references sq8(id)
      )
  例2：alter table test1 add constraint fk_key foreign key(ID) references sq8(id)
 
删除多个外键：alter table test1 drop constraint fk_key
    或者alter table test1 drop foreign key fk_key
 
删除一个外键：
 
 
Check
CHECK 约束用于限制列中的值的范围。
如果对单个列定义 CHECK 约束，那么该列只允许特定的值。
如果对一个表定义 CHECK 约束，那么此约束会在特定的列中对值进行限制。
 
alter table xsxx add check(sex='男' or sex='女')--限定该表中的性别sex这列只能是男or女
 
create table re
(id int not null,name varchar(255) not null, sex varchar(4) check(sex='男' or sex='女'))性别sex这一列只能输入男或者女，输入其他信息会报错。
 
CREATE TABLE Persons
(
Id_P int NOT NULL,
LastName varchar(255) NOT NULL,
FirstName varchar(255),
Address varchar(255),
City varchar(255),
CONSTRAINT chk_Person CHECK (Id_P>0 AND City='Sandnes')
)
对多个字段进行check的动作，constraint+名字+check(条件)
 
Default
约束向列中插入默认值
A. City varchar(255) default 'sandnes'
b.  create table da
(id int,rq date default current_date)--给日期定义个默认值是当前时间
c. 
create table ttt (
id smallint,
dt1 date with default current_date,
dt2 time with default current_time,
dt3 timestamp with default current_timestamp,
name char(3) with default 'hgm'
)
D.删除掉表中默认值
alter table ttt alter  name set default 'sss'--修改默认值，修改后的值对前面已经插入的数据不会有任何的影响
alter table ttt alter  column name set default 'sss'
上面的两个语句的结果是相同的
 
alter table ttt alter name drop default--删除掉默认值
 
 
null
  NULL 值的处理方式与其他值不同。
  NULL 用作未知的或不适用的值的占位符。
无法使用比较运算符来测试 NULL 值，比如 =, <, 或者 <>。
我们只能用is null和is not null来进行判断
 
 
Order by
ORDER BY 语句用于根据指定的列对结果集进行排序。
ORDER BY 语句默认按照升序对记录进行排序。
如果您希望按照降序对记录进行排序，可以使用 DESC 关键字。
ORDER BY to_char(ORDER_DATE,'YYYYMMDD') DESC NULLS LAST/first
*如果order by中指定了表达式nulls last表示null值得记录将排在最后（不管是ASC还是DESC）
*如果order by中指定了表达式nulls first表示null值得记录将排在最前（不管是ASC还是DESC）
 
 
 
Insert into
12. 插入单条数据
insert into a(id) values(1)--可对某个表的某条字段进行插入
commit;
13. 插入多条数据
insert into a values(2,'a'),(3,'b'),(4,'c')
commit;
14. 从另一表提取数据插入
   insert into b select * from a  --提取另一个表的所有数据来插入
commit;
insert into c(id) select id from a  --只插入A表中的ID字段所有的信息
commit;
insert into xscj(id,yw,sx,yy) select id,yw,sx,yy from xscj
利用多元表来插入数据
  insert into e
  select 1,'b' from sysibm.dual
  union all
  select 2,'e' from SYSIBM.DUAL
  commit;
   
   
字段类型
15. 数值型
  Smallint -----精度为5位
  Int    -------精度为10位
  Bigint   ------精度为19位
16. 字符型
  Varchar-----变长字符串，需要指定长度，一个中文字占4个字节
  Char ---------定长字符串
  Clob ---------大对象字符串，
17. 日期型
  Date
  Time
  Timestamp
  整型和字符型在插入的 时候可以兼容
   
   
Select
18. 基础用法
select * from e
19. 嵌套查询：单行子查询，多行子查询，内部视图子查询，多列子查询
select * from e where id in(select id from a where name='a')
select * from f where id=1 and name='zhangsan'
select * from f where id=1 or id=3
--select * from f where id in (1,3),两句话的查询结果一样
 
case when
select id,
case WHEN  name='e' then 'amanda'--可添加多个when---then---语句
else 'song'
end
as name
from e
如果name=e就改为amanda，其他的就改成song
 
Decode--- 
select name, decode(id,'2','two','1','one','null') as id from e
如果ID=2就改为two，如果ID=1就改为one
一个字符段只能给出一个条件去修改，当有多个条件的时候只会根据第一个条件去修改
 
对于多元表中decode的用法
select decode(1,1,1,2,1) from SYSIBM.dual
第一个数据是就是需要修改的值得原来的值
Decode,后面可以是字段类型也可以是一个数值
  select decode(2,2,'null') from sysibm.dual--满足条件输出null值
  select decode(2,3,4) from sysibm.dual--若是没有匹配的值也会输出null
  select decode(2,sum(1+1),substr('12323',2,1))from sysibm.dual--可以decode中嵌入函数
  select decode(null,'a1','1','a2','2',null,'null','not know!') from sysibm.dual;--返回字符串null
decode(1,2,1)后面默认的值是null，所以最后会返回一个null值
update stu3 set yy=decode(yy,67.5,90,yy)当不满足条件的时候，保持原字段的值不变。
 
 
 
update + case when
  --利用case when来按照判断条件来更新表中工资的数据，小于1000的增加10%...其余的不更新
  update zg set sal=case when sal<1000 then sal*1.1
                    when sal between 100 and 1500 then sal*1.05
                    else null
                    end 
   
 
 
update
1．更新一个字段
 update e set(id)=5 where name='e'--where后面主要是跟筛选的条件语句
 commit;
2.  更新多个字段 
  update h set(name,sal)=(select name,sal from f where h.id=f.id) 
 
update q set(yw,sx,yy)=(select yw,sx,yy from XSCJ a where  q.id=a.id)where exists(select 1 from xscj a where a.id=q.id)--用另一个表的数据来更新Q表的数据
update stu3 a set yw=(select yw from stu2 b where a.id=b.id)—更新的前一个表A的数据要比后面一个表b的数据的多，否则会报错。
 
 
union/union all, except/except all,  distinct, intersect
A： UNION 运算符 
UNION 运算符通过组合其他两个结果表（例如 TABLE1 和 TABLE2）并消去表中任何重复行而派生出一个结果表。当 ALL 随 UNION 一起使用时（即 UNION ALL），不消除重复行。两种情况下，派生表的每一行不是来自 TABLE1 就是来自 TABLE2。  
 B： EXCEPT 运算符 
EXCEPT 运算符通过包括所有在 TABLE1 中但不在 TABLE2 中的行并消除所有重复行而派生出一个结果表。当 ALL 随 EXCEPT 一起使用时 (EXCEPT ALL)，不消除重复行。  
C： INTERSECT 运算符 
INTERSECT 运算符通过只包括 TABLE1 和 TABLE2 中都有的行并消除所有重复行而派生出一个结果表。当 ALL 随 INTERSECT 一起使用时 (INTERSECT ALL)，不消除重复行。 
注：使用运算词的几个查询结果行必须是一致的。
例如 union 的用法
  SELECT * FROM JL
    UNION ALL --取两张表的并集保留所有重复记录
  SELECT * FROM ZG
   
  SELECT * FROM JL
   UNION  ---取两张表的并集（保留一条重复记录）
   SELECT * FROM ZG
   
  SELECT DISTINCT* FROM JL –去掉表中的重复记录并保留一条重复记录
   
  select 1,2,3 from SYSIBM.DUAL
      union 
     select 4,5,6 from sysibm.dual
输出值：

   
select 1,2,3 from SYSIBM.DUAL
      union all
       select 4,5,6 from sysibm.dual
  输出值：

 
     select 1,2,3 from SYSIBM.DUAL
      union all
     select 'a','b','c' from sysibm.dual
会报错
 
  select 1,'a',3 from SYSIBM.DUAL
      union 
     select 'a','b','c' from sysibm.dual
会报错
 
select 1,2,3 from SYSIBM.DUAL
union 
select 1,2,3 from sysibm.dual
 
输出值：123
 
select 1,2,3 from SYSIBM.DUAL
union all
select 1,2,3 from sysibm.dual
输出值：123
        123
 
select 1 a,2 b,3 c from SYSIBM.DUAL
except—使用except all
select 1 a,2 b,3 c from sysibm.dual
except/except all前后的查询语句的结果一样的时候，会是一个空的显示。
 
Union/union all，except/except all前后的字段类型要对应的一样
Except：运算符通过包括所有在 TABLE1 中但不在 TABLE2 中的行并消除所有重复行而派生出一个结果表。当 ALL 随 EXCEPT 一起使用时 (EXCEPT ALL)，不消除重复行。
     select 1,'a',3 from SYSIBM.DUAL
    except
     select 1,'b',5 from sysibm.dual
输出值：

select 1,'a',3 from SYSIBM.DUAL
    except all
     select 1,'b',3 from sysibm.dual
输出值

 
   
   
   
   
   
   
   
   
Distinct—去除所有字段相同的记录
select distinct * from h
select distinct id,name from q2--删除表中重复的id，name来显示
 
row_number()的用法--去除重复的数据的记录
delete from (
select * from(
select id,sal,name, 
row_number() 
over(partition by id + order by 等函数来约束选择的内容)as num from h)
where num>1
)
select id,name,sal from h group by id,name,sal --用group by 来进行重复数据的删除
 
DELETE jl
 WHERE numb IN (SELECT numb
                  FROM jl
                GROUP BY numb, name, sal
                HAVING count (*) > 1)
Group by
Where和having子句都用来筛选数据，但是where是针对原数据进行筛选，而having子句只是针对汇总后的结果进行筛选
 
order by后跟着多个字段，默认排序是先对第一个字段升序排序，然后再排第二个字段，以此类推，所以如果在应用中仅仅需要长序排序可以不用加order by 参数，毕竟这会影响性能,默认的是升序，DESC是降序
 
 
exists/not exists     in/not in
select * from f where id in (select id from h where sal>100)
select * from f where id not in (select id from h where sal>100)
select * from f where exists (select * from h where f.id=h.id)
select * from f where not exists (select * from h where f.id=h.id)
select * from( select 1 a,2 b,3 c,null d from sysibm.dual)a
   
in/not in
  from (select 1 a,2 b,3 c from sysibm.dual)a
   where a.a not in
(select a from (select 1 a,3 b,4 c from sysibm.dual))
 
输出值：是为空，没有任何值得输出，包括空值。

 
上面的not in也可以写成not exists
select a.* 
  from (select 1 a,2 b,3 c from sysibm.dual)a
where not exists(select 1 from
(select 1 a,3 b,4 c from sysibm.dual)b where a.a = b.a);
    
 
 
 
 
在in/not in中当子查询有null值得时候，不会有任何数据的输出
select a.*
  from (select 1 a,2 b,null c from sysibm.dual)a
  where a.a not in(select b.c from (select 1 a,2 b,null c from sysibm.dual)b)
输出值：

 
 
在exists/not exists中当null=null是一个假的条件，所有返回的是一个假
Exists/not exists后面的子查询是返回的一个真假的判断，并不会返回具体的值
select a.*
    from (select null a,1 b,2 c from sysibm.dual)a 
  where exists
  (select 1 from (select 1 a,null b, 3 c from sysibm.dual)b 
  where a.a = b.b)
输出值：

  select a.*
    from (select null a,1 b,2 c from sysibm.dual)a 
  where not exists
  (select 1 from (select 1 a,null b, 3 c from sysibm.dual)b
  where a.a = b.b)
输出值：
Null，1,2
 
 
 
 
 
delete,   alter,     drop
1.delete from 表的内容/+条件（删除部分内容） --消耗事务日志
2.alter table +表名 activate not logged initially empty with table  ---删除内容，不消耗事务日志，但是删除了整张表数据
3.drop table+表名，删除内容+表结构
***先用alter,再用drop，来删除表，可以马上清空表空间。
 
 
 
Join,   full join,   left join,   right join  输出的时候是以行为基准的，与每个表有多少列没有任何关系--
select * from f join h on f.id=h.id --两个表中相同的字段进行关联
select * from f full join h on f.id=h.id
select * from f left join h on f.id=h.id
select * from f right join h on f.id=h.id
 
1.
select a.*
     from ( select 1 a, 2 b,3 c,null d from sysibm.dual)a 
     left join (  select 1 a, 2 b,3 c, null d, 4 e from
     sysibm.dual)b
  on (a.a = b.a);--输出值：1.2.3.null就是输出A表的信息
若on后面的条件不成立，
若是a.* 的话就会输出a表的信息，
若是right join就会输出右边的表的信息，其余的信息全部是null
 
2.
   select b.*
     from ( select 1 a, 2 b,3 c,null d from sysibm.dual)a 
     left join (  select 1 a, 2 b,3 c, null d, 4 e from 
     sysibm.dual)b
      on (a.a = b.a)--输出值：1.2.3.null.4,就是输出B表的信息
  3.
    select a.*
     from ( select 1 a, 2 b,3 c,null d from sysibm.dual)a 
     left join (  select 1 a, 2 b,3 c, null d, 4 e from
     sysibm.dual)b
    on (a.d = b.d);--输出值：1.2.3.null输出A表的信息
    
     4.有疑问  整个题干内容有疑问？
      select b.*
     from ( select 1 a, 2 b,3 c,null d from sysibm.dual)a 
     left join (  select 1 a, 2 b,3 c, null d, 4 e from sysibm.dual)b
  on (a.d = b.d);   --输出值：null,null.null.null.null输出B表的信息，但是因为空=空是一个不成立的条件，返回的B表输出的信息是空值
   
join两张表取交集
full join两张表取并集
left join以左边的表为基准来输出两个表
right join以右边的表为基准来输出两个表
 
 
 
create table code1 (id int ,name varchar(255),yw decimal(3,1),sx decimal(3,1),yy decimal(3,1))
insert into code1
select 1,'张三',67.5,89,98 from sysibm.dual
union all
select 2, '李四',78,87,45 from sysibm.dual
union all
select 3, '王五',67,89,45 from sysibm.dual

commit;

select * from CODE1;

create table code2 like code1; 

insert into CODE2
select * from code1;

commit;

1、把CODE2表中张三的英语成绩修改为99;
update code2 set(yy)=11 where name='张三';

2、用code2表中的英语成绩去修改code1表中的英语成绩；


update code1 a set (yy) =
(select yy from code2 b where a.ID = b.id) where
exists(select 1 from code2 b where a.ID = b.id);

update q set(yw,sx,yy)=(select yw,sx,yy from XSCJ a where  q.id=a.id)where exists(select 1 from xscj a where a.id=34454)--exists返回的值是fail的时候，不会进行update的动作,但是命令是可以被执行的

3、把CODE2表中张三的英语成绩修改为99，数学成绩修改为67;
update code2 set yy=99,sx=67 where name='张三'


4、用CODE2表中学习成绩去更新CODE1表中的成绩，当学生小于60则不修改；


update code1 a
      set (yw,sx,yy)=(select yw,sx,yy from code2 b where a.id=b.id and a.yw>60 and a.sx>60 and a.yy>60)
  where exists(select 1 from code2 b where a.id=b.id and a.yw>60 and a.sx>60 and a.yy>60);
 
exists与update的用法
 
1.增加一个字段列，并 插入另一个表的相同列的数据
在Q中增加一个name的字段列，并把Q2的name的数据插入到Q中
alter table q add column name varchar(60)
update q set(name)=(select name from q2 where q2.id=q.id) where exists (select * from q2 where q.id=q2.id)
 
2.substr()字符串的截取。
select SUBSTR (12345,2,3) from sysibm.dual --substr(字段，开始字段，结束字段)字符串的截取， 结果是---234
 
 
 select a.*
  from(select 1 a,null b from SYSIBM.dual)a  join (select 1 a,null b,2 c from SYSIBM.DUAl)b on (a.b=b.b)
不会有任何值得输出，输出为空
 
select a.*
  from(select 1 a,null b from SYSIBM.dual)a left join (select 1 a,null b,2 c from SYSIBM.DUAl)b on (a.b=b.b)
  输出A表的信息
 
select a.*
  from(select 1 a,null b from SYSIBM.dual)a full join (select 1 a,null b,2 c from SYSIBM.DUAl)b on (a.b=b.b)
输出的是，null null
            1   null
     
  select a.*
  from(select 1 a,null b from SYSIBM.dual)a right join (select 1 a,null b,2 c from SYSIBM.DUAl)b on (a.b=b.b)
输出的是： null null
 
 
 select b.*
  from(select 1 a,null b from SYSIBM.dual)a left join (select 1 a,null b,2 c from SYSIBM.DUAl)b on (a.b=b.b)
输出的是： null null  null
 
 
select 1,2,3 from SYSIBM.DUAL
      union 
     select 4,5,6 from sysibm.dual
 
MERGE
MERGE=INSERT＋UPDATE, 根据一张表或子查询的连接条件对另外一张表进行查询，连接条件匹配上的进行UPDATE或者DELETE，无法匹配的执行INSERT, MERGE语句的UPDATE不能修改用于连接的列，否则会报错. 只有单个matched 只做更新操作不做插入操作，只有单个not matched只做插入操作不做更新操作。
把所有的信息更新到zg3的表中
MERGE INTO zg3
 USING  (select * from jl3)a --jl3--可以用子查询来代替
    ON (zg3.NUMB = a.NUMB)
WHEN  MATCHED and zg3.name='lisi'--还可以在后面增加条件
THEN
   UPDATE SET zg3.SAL =a.SAL 
WHEN NOT MATCHED--matched
THEN
   INSERT VALUES (a.NUMB, a.NAME, a.SAL);
例如：在公司里数据库里有经理表，也有员工表，有些经理是从员工晋升到得经理，但同时其信息也没有在从员工表中删除。在某些情况下，为了使信息统一，我们要将两张表合并成一张表。如下例题如果经理的工号存在于职工表之中，这时就按条件更新工资，如果经理的工号不在职工表中就将这个经理信息插入到职工表中，就完成了两张表的合并
 
MERGE INTO ZG -—若zg表是空的话，该语句也可以执行，只不过是插入整个jl表中的数据。
 USING JL --也可以用子查询 如（SELECT * FROM XX）
    ON (ZG.NUMB=JL.NUMB)
WHEN MATCHED--者还可以加条件  AND NAME='LISI'
THEN
   UPDATE SET zg.name=jl.name,zg.sal=jl.sal
  --  如果要删除用 DELETE 就可以了
WHEN NOT MATCHED
THEN
   INSERT VALUES (JL.NUMB, JL.NAME, JL.SAL)
 
当工资大的时候才更新工资的数据
merge into zg a
using jl b on(b.numb=a.numb)
when matched and b.sal>a.sal then update set a.sal=b.sal
when not matched then insert values(b.numb,b.name,b.sal)
 
MERGE的结构是不能改变的的，when+matched/not matched+条件语句
例子：
MERGE INTO CM_DISTRICT A USING 
        (
            SELECT ID, PARENT_ID, NAME, IN_USE 
              FROM CM_TEMP_DISTRICT
        ) B ON (A.ID = B.ID)  
        WHEN MATCHED THEN UPDATE SET
            A.PARENT_ID = B.PARENT_ID,
            A.NAME = B.NAME,
            A.IN_USE = B.IN_USE,
            A.ID = B.ID
        WHEN NOT MATCHED THEN  
            INSERT (ID, PARENT_ID, NAME, IN_USE)  
            VALUES (B.ID, B.PARENT_ID, B.NAME, B.IN_USE);
这个语句是正确的，可执行的。
 
MERGE INTO clp_call_${month()} a
    USING  tmp_clp_call_01  B
       ON (A.PHONE_NO=B.PHONE_NO)
    WHEN NOT MATCHED THEN 
    INSERT (A.PHONE_NO) 
  VALUES (B.PHONE_NO)
   
   
 
 
 
递归查询
递归查询通常有3个部分需要定义：
一：一个公共表达式形式的虚拟表。
二：一个初始化表。
三：一个与虚拟表进行完全内连接的辅助表。
需要使用UNION all合并上边3个查询，然后用select从递归输出中得到最终的结果。
大体上如下形式
with XX(x1,x2,x3) as  -------@0
(
 select a.s,a.s1 from a  ----@1
 union all  ----@2
 select * from a,xx where a.s=xx.x1 ------@3
)
select ... from xx where .... -------@4
@0:为with体，即虚拟表
@1:为初始化表，这里需要定义初始化的一些行，也就是你递归的出发点，或者说父行，这部分逻辑只执行一次，它的结果作为虚拟表递归的初始化内容。
@2:这里必须用UNION all
@3:这里需要定义递归的条件（辅助表），这里定义递归的逻辑，需要注意的是父行和子行进行连接的时候逻辑一定要清楚父子关系，不然很容易变成死循环的，这里首先将初始化表的结果作为条件进行查询，在把执行的结果添加到虚拟表中，只要这里能查询出来记录，那么就会进行下一步递归循环。
@4:这里就是对虚拟表的查询语句。
第一：建一张有层次关系的表并插入数据
 
WITH TEMPTAB (DEPTID, DEPTNAME, EMPCOUNT, SUPERDEPT,LEVEL) --LEVEL表示第几层的意思
     AS (SELECT ROOT.DEPTID,
                ROOT.DEPTNAME,
                ROOT.EMPCOUNT,
                ROOT.SUPERDEPT,
                1
           FROM DEPARTMENTS ROOT
          WHERE DEPTNAME = 'ZZAO'
         UNION ALL
         SELECT SUB.DEPTID,SUB.DEPTNAME ,SUB.EMPCOUNT, SUB.SUPERDEPT, LEVEL+1
           FROM DEPARTMENTS SUB, TEMPTAB SUPER
          WHERE SUB.SUPERDEPT = SUPER.DEPTID
)
  SELECT *  FROM TEMPTAB WHERE LEVEL= 2
原来的表

执行后的表

 
 
常用函数
1.avg（）
用于返回所查列的平均值，返回值类型跟原有字段类型相同
*如果所查记录中有空值null，则不计算该条数（如：所查字段有十条记录，其中有一条此字段为null，则只求9个字段的平均值）；可以使用distinct，平均值是去掉重复行后求平均值。
select avg(distinct yw) from xscj--利用distinct去掉重复的记录，是去掉YW成绩相同的学生的记录
select avg(yw) from(select distinct * from xscj)--去掉的是所有字段重复的记录
 
2.COUNT
返回结果行数，通常用*，所有行总数
如果指定具体字段，count(字段名)，这个字段如果是integer，则为null值的行，不记录行数；
可以使用distinct，则计算去掉重复行后的记录行数，此时，指定的字段类型不能是：LONG VARCHAR, LONG VARGRAPHIC, BLOB, CLOB, DBCLOB, DATALINK, XML, 返回的值，同样不记录有null的行数
如果使用all 参数，则指定的字段值也不记录null行数
Varchar的字段类型是可以进行count的
 
select count(*) from xscj where yw is null
union all
select count(*) from xscj where YW is not null
输出的值：

 
 
select count(distinct yw) from xscj --消除相同的语文成绩的记录
select count(yw) from (select distinct * from XSCJ)--消除全部消息相同的记录
 
 
3.max
返回最大值，其所查字段类型要求为内置类型,不能是LONG VARCHAR, LONG VARGRAPHIC, BLOB, CLOB, DBCLOB, DATALINK
查找最高分的学生的信息
select id,yw from xscj where yw in (select max(yw) from xscj)
 
4.min
返回最小值，其所查字段类型要求为内置类型,但不能是LONG VARCHAR, LONG VARGRAPHIC, BLOB, CLOB, DBCLOB, DATALINK
查看数学成绩最小的的学生信息
select * from xscj where sx in (select min(sx) from XSCJ)
 
5.sum
求和运算，参数类型要求内置数值类型。
SUM 函数返回数值列的总数（总额）
学生成绩总和计算
select id,yw,sx,yy,yw+sx+yy as sum from XSCJ
select sum(yw) from XSCJ
行转列
select id,name,sum(decode(KM,'语文',cj)) 语文,sum(decode(KM,'数学',cj) )数学,sum(decode(KM,'英语',cj)) 英语
   from XS2
   group by id,name
 
   select id,name,
sum(case when km='语文' then cj end) 语文,
sum(case when km='数学' then cj end) 数学,
sum(case when km='英语' then cj end) 英语
  from XS2
  group by id,name;
两种方式都可以实现行转换成列
 
 
 
 
标量函数
1.ABS、ABSVAL，取绝对值
返回绝对值，参数类型要求为内置数值类型  
 
select id,yw,sx,yy,abs(1) from XSCJ
select id,yw,sx,yy,absval(1) from XSCJ
两个的结果输出是一样的
输出值：

2. ASCII
返回字符串最左边的字符的ASCII，如果参数类型为graphic string ，转换成character string进行处理，对于varchar ，最大长度限制为4000byte；clob 最大长度限制为1048576 bytes；long varchar类型 先转换成clob处理
返回结果始终为integer
   
第33～126号(共94个)是字符，其中第48～57号为0～9十个阿拉伯数字；65～90号为
26个大写英文字母，97～122号为26个小写英文字母，其余为一些标点符号、运算符号等
select ASCII ('a') from sysibm.dual--输出97
select ASCII ('123G') from sysibm.dual--输出第一个字符的ACSII值，49
 
3.celling—向上取整
返回大于或等于expression的最小整数，参数要求为内置数值类型
Values(ceiling(213.4))   返回：214
4. FLOOR—向下取整
功能：返回小于或等于 expression 的最大整数。
参数 ：要求为内置数字类型。
与celling相反
values(floor(-89.8)) --输出值是-90
5.char
有五种不同类型转换成character类型：character、datetime、integer、decimal、floating-point
到character转换，如果指定长度，则按固定长度截取字符，不够长，则在右边补空格。（参数为CHAR, VARCHAR, LONG VARCHAR, or CLOB类型）
datetime 到character转换，参数类型可为：date, time, or timestamp可支持时间标准：ISO、USA、EUR、JIS、LOCAL。
integer 到character转换，参数类型可为：SMALLINT, INTEGER, or BIGINT
smallint 返回6位长字符串，integer返回11位长字符串，bigint返回20位长字符串， 不够长就在右边补空格。
decimal 到 character转换，转换过程中，如字段字义类似decimal(5,5)，则转换过程中，整数部分的0则不转换，位数不够，则在右边补0。
floating-point到character，参数类型可为DOUBLE or REAL，转换成以科学记数法显示字符，并且长度固定为24位(char(24))，不够24位，则在右边补空格
例55，则显示5.5E1
 
6.character_length()与char_length()是相等的
功能：返回指定字符串的长度，要求指定字符串是内置character or graphic string.
注：此函数与length功能类似，区别是length可以求数值类型、时间、和binary 串
length:返回字符串所占的字节数,是计算字段的长度一个汉字是算三个字符,一个数字或字母算一个字符.
char_length:返回字符串所占的字符数,不管汉字还是数字或者是字母都算是一个字符
 
 
7. LTRIM（SYSFUN模式）
功能：删除字符串前面的空格。
参数：内置character string 类型，对于varchar ，最大长度为4000bytes，对于CLOB类型，最大长度为1048576bytes
select LTRIM ('    jisuuep') from sysibm.dual--删除字符串前面的空格
8.LTRIM（SYSIBM模式）
功能：删除字符串前面的空格。
参数：CHAR, VARCHAR, GRAPHIC, or VARGRAPHIC，支持LONG VARCHAR and CLOB类型
9. TRIM，ltrim,Rtrimà对字符串的影响大于对数字的影响
功能：去掉字符串首尾指定的字符，如果不指定，则去掉首或尾空格。
参数：BOTH, LEADING, or TRAILING指定去掉首尾、首、尾位置上的指定字符；strip-character指定要去掉的单字符；string-expression目标字符串，类型要求为CHAR, VARCHAR, GRAPHIC, or VARGRAPHIC 数据类型。
注：如果只指定string-expression参数，则默让支掉首尾空格
 
select TRIM (leading 's' from 'ssssdedfe') from SYSIBM.dual--输出值是dedfe，
select TRIM (both 'd' from 'dddddegesgedddd') from sysibm.dual
select trim(trailing 'd' from 'ddddssssssdddd') from sysibm.dual
当首尾位置上的指定字符有多个的时候，都会被去掉
10.round
>>-ROUND--(--expression1--,--expression2--)--------------------><
功能：返回将 expression1 四舍五入到小数点右边第 expression2 位后的值。如果 expression2 为负数，则将 expression1在左边第 |expression2| 位做四舍五入。 1、如两参数都为正数，则返回结果是expression1参数小数点后保留expression2位，并做四舍五入运算。2、如果expression2为负数，则返回expression1在左边第 |expression2| 位做四舍五入运算后的结果,如果expression2绝对值加1大于expression2整数位，并做四啥五入运算，结果expression2绝对值加1位上的值为0，则返回0值。
 
   VALUES (
     ROUND(873.726, 2),
     ROUND(873.726, 1),
     ROUND(873.726, 0),
     ROUND(873.726,-1),
     ROUND(873.726,-2),
     ROUND(873.726,-3),
     ROUND(873.726,-4) )
输出值：

VALUES (
     ROUND(3.5, 0),
     ROUND(3.1, 0),
     ROUND(-3.1, 0),
     ROUND(-3.5,0) )
输出值

*trunc
该函数不对指定小数前或后的部分做相应舍入选择处理，而统统截去
select trunc(98.762,-2),trunc(98.762,-1),trunc(98.762,0),trunc(98.762,1),trunc(98.762,2) from sysibm.dual

 
 
values(round(344.56335,4))--输出值：345.56340
11.substr
功能：从string串中，start指定的位置取length长度的字符串
参数：string 要求为character string 、 a binary string、graphic string；start为整型，取值范围1到string串实际长度，指定起始的字符位置；length为整型，取值范围0到(the length attribute of string或者是字段定义长度) - start + 1
values(substr('dfdgssaa',3,5))--从第三位开始截取，一共截取五位数，返回dgssa
values(substr(null,3,5))--返回一个空值

 
select substr(name,2,4) from xscj
 
12.concat与||是相同的效果
功能：将两个字符串连接起来，如果两个参数中，有任一为null，则返加null。
values(concat('a','d'))--返回ad
values(concat(null,'d'))--返回空值—>

 
13.Replace
select REPLACE('amanda','an','song') from SYSIBM.dual
—输出值：amsongda
把第一个字段中有第二个字段相同的部分替换成第三个字段。
select 'qweer'||'ert' from sysibm.dual
select id||name from stu
 
13.nvl
Nvl(string,replace_with)
a.string是null的时候，返回replace_with的值
b.string非空的时候，返回string的值
c.两个都为空的时候返回null
*nvl2
Nvl2(E1,E2,E3)
a.E1为Null的时候返回E3
B.E2为null的时候返回E2
select id,yw from xscj where nvl(yw,0) like '%'--利用nvl这个函数来对yw成绩这列数据进行一个null的处理，这样查询出来的结果中就会包含空值得行数
 
 
时间函数
1.day，返回日期部分，不包括年月àselect day(current timestamp) from sysibm.dual
2.date,返回日期àselect date(current timestamp) from sysibm.dual--返回2016/9/11
3.year,返回日期年的部分 –>select year(current timestamp) from sysibm.dual
4.monthà SELECT MONTH(CURRENT TIMESTAMP) FROM SYSIBM.DUAL--MONTH() 返回月
5.HOUR
SELECT HOUR(CURRENT TIMESTAMP) FROM SYSIBM.DUAL --返回小时
6.MINUTE
SELECT MINUTE(CURRENT TIMESTAMP) FROM SYSIBM.DUAL --返回分钟
7 second
SELECT SECOND(CURRENT TIMESTAMP) FROM SYSIBM.DUAL--返回秒
8. SELECT DAYOFWEEK(CURRENT TIMESTAMP) FROM SYSIBM.DUAL --返回值’1’代表周日依次类推
9 DAYOFWEEK_ISO
SELECT DAYOFWEEK_ISO(CURRENT TIMESTAMP) FROM SYSIBM.DUAL --返回值’1’代表周一依次类推
10 DAYNAME
SELECT DAYNAME(CURRENT TIMESTAMP) FROM SYSIBM.DUAL---返回星期名字
由于返回的值为英文  所以为了方便阅读我们将其转换为中文，可以分别用case when 和decode 来实现
select case when DAYNAME(CURRENT DATE)='Sunday' THEN '星期日' END 今天星期几 FROM SYSIBM.DUAL  ---用CASE WHEn
select decode(dayname(current date),'Sunday','星期天',DAYNAME(CURRENT DATE)) as 星期几 from sysibm.dual --用decode
 
11 DAYS
SELECT DAYS(CURRENT TIMESTAMP) FROM SYSIBM.DUAL--DAYS(ARG):返回日期的整数表示法，距离0001-01-01来的天数
12 MONTHNAME/dayofyear
SELECT MONTHNAME(CURRENT TIMESTAMP) FROM SYSIBM.DUAL  --返回月份名字
SELECT DAYOFYEAR(CURRENT TIMESTAMP) FROM SYSIBM.DUAL--返回当前日期在这年中年内的第几天
13 WEEK 和WEEK _ISO
Week功能：返回指定时间所在周的星期日在当年是第几周，返加1-54的整数。
参数：一定为date, timestamp类型，或者是有效的date 或 timestamp格式字符串；
 
Week_iso
功能：返回指定时间所在周的星期4在当年是第几周，返回1-53的整数。
参数：为date, timestamp类型，或者为有效有date, timestamp格式字符串，不能为CLOB nor a LONG VARCHAR串。
注：此函数是以星期1为一周的开始；如果指定的日期是本年未的日期，所在的周的星期四是在下一年初，则返回1，为下一年的第一周，
如果星期四是在本年未，则返回当年的最后一周是第几周。如果指定日期是一年的年初，所在周的周四在本年，则返回1，否则返回上一年最后一周的周数。
14.to_date
select * from  nmn  where shijian between  to_date('2009-01-01 04:12:34','yyyy-mm-dd HH24:MI:SS') and
 to_date('20090105121212','yyyy-mm-dd HH24:MI:SS')
 
 
15.timestamp_format
功能：将timestamp 格式的string-expression串，转换成format-string格的timestamp
string-expression参数，为character类型的timestamp格式串（符合format-string指定的格式），串长度最大不能超过254； format-string参数，用于转换后的timestamp显示格式，如'YYYY-MM-DD HH24:MI:SS'
 
VALUES (
          TIMESTAMP_FORMAT ('2009-01-3 12:33:2(或者写成20090103123302)','YYYY-MM-DD HH24:MI:SS'), 'CC'
)
--年月日前面的0不能省掉，
To_date(string, format)
Timestamp_format (string, format)
时间的格式：yyyy-mm-dd hh24:mi:ss
 
 
16.add_months(date1,number)->返回的值是date+number,是对月份进行加减
 
17.months_between(date1,date2)à返回值是date1-date2，
date1与date2相同的时候返回0，
date1与date2年和日相同的话，返回月之差
date1与date2年月相同的话，返回的是日（date1-date2）/31
 
获取系统本身的时间
select timestamp(current timestamp) from sysibm.dual
 
字符转日期
select to_date('2005-01-01 13:14:20','yyyy-MM-dd HH24:mi:ss') from sysibm.dual;--输出值：2005/1/1 13:14:20
 
日期转字符
select to_char('2005-1-2 13:14:29','yyyy-mm-dd hh24:mi:ss') from 
sysibm.dual--输出值：2005-01-02 13:14:29
 
对日期进行计算
select date(current date + 3 YEARS + 2 MONTHS + 15 DAYS )from sysibm.dual--使用英语来执行日期和时间计算
select time(current timestamp) from sysibm.dual--截取日期中的时分秒
 
 
建立索引
create index 索引名 on table_name(字段1，字段2)
create index j on zg(numb,name)à 因为在表中可能用一个字段有重复， 这时就可以使用复合字段来查询
 
CREATE INDEX IDX_NAME
   ON TABLENAME (（SUBSTR(字段1，1，12)）)---非唯一索引（这里面是可以用函数来替代字段的）
 
CREATE UNIQUE INDEX IDX_NAME
   ON TABLENAME (字段)  --唯一索引
 
CREATE UNIQUE INDEX IDX_NAME
   ON TABLENAME (字段1)    INCLUDE（字段2）--纯索引
 
13：索引的用法（）
索引是表的一个或多个列的键值的有序列表，它能确保一个列和多个列值的唯一性，提高对表的查询效率，（注意索引只能建在非空字段上）
按不同方法可分为：
1：唯一索引和非唯一索引
2：聚簇索引和非聚簇索引 
语法 CREATE INDEX IDX_表名 ON 表名（字段1，字段2,……..）
 
CREATE INDEX IDX_NAME
   ON TABLENAME (字段1，字段2)  因为在表中可能用一个字段有重复， 这时就可以使用复合字段来查询
CREATE INDEX IDX_NAME
   ON TABLENAME (（SUBSTR(字段1，1，12)）)---非唯一索引（这里面是可以用函数来替代字段的）
 
CREATE UNIQUE INDEX IDX_NAME
   ON TABLENAME (字段)  --唯一索引
 
CREATE UNIQUE INDEX IDX_NAME
   ON TABLENAME (字段1)    INCLUDE（字段2）--纯索引
 
 
注意：1：（聚簇索引与非聚簇索引，在一个表中，最多只能有一个聚簇索引，但是可以拥有256个非聚簇索引，对于聚簇索引，数据的物理存放顺序与索引的顺序是相同的，都是有序的，这能大大提高检索数据的能力，在非聚簇索引中，数据的物理存放顺序与数据的插入顺序是相同的，是紊乱的，但是索引的顺序与数据的存放顺序是不相同的）聚集索引和非聚集索引都可以是唯一的。只要列中的数据是唯一的，就可以为同一个表创建一个唯一聚集索引和多个唯一非聚集索引。
2:在生成主键的同时会自动在列上生成唯一性索引，就没有必要再在它上面建索引，默认情况下此索引即聚簇索引。不过可以在生成约束时指定生成非聚簇索引
3：索引要占用另外的表空间，索引会经常失效
 
比如说：A表存放的学生的学号、姓名等信息，
B表存放的学生的学号、课程表等信息、你现在只有姓名，但是你要查看这个学生的课程表，那你只能关联A.B两个表
如果表没得索引的话，那这两个表关联就会扫描全表数据
如果你给A.B表的学号这一列都建一个索引
那么关联的时候就只会扫描学号这列数据，如果找到对应的数据就会输出相关的所有数据
这样就不会去扫描全表的数据了 
 
存储过程
create table PK_TAB1
(
   ID INT,
   NAME VARCHAR(20)
);
 
create  procedure insert_info1 (ids int,names varchar(20))
begin
  insert into PK_TAB1 (
     ID
    ,NAME
  ) VALUES (
     ids
    ,names
  );
end    ----这是创建的语法
call EASYMAN1.insert_info1 (1,'22');
select * from PK_TAB1;
 
 
别名，不能用引号括起来，
Tablename +别名
Tablename as +别名
 
 
 
例子：
1.一道SQL语句面试题，关于group by
表内容：
2005-05-09 胜
2005-05-09 胜
2005-05-09 负
2005-05-09 负
2005-05-10 胜
2005-05-10 负
2005-05-10 负

如果要生成下列结果, 该如何写sql语句?

            胜 负
2005-05-09 2 2
2005-05-10 1 2
 
方法一：select date,sum(case when result='胜' then 1 else 0 end)胜,sum(case when result='负' then 1 else 0 end)负 from ball group by date
当result是胜的时候，输出1，但是sum是求和的函数，所以会对满足条件的部分进行求和的运算。
方法二：
select date,sum(decode(result,'胜',1,0))胜,sum(decode(result,'负',1,0))负 from ball group by date
case when和decode可以达到相同的效果。
 
2. 对所有员工,如果该员工职位是MANAGER，并且在DALLAS工作那么就给他薪金加15％；
如果该员工职位是CLERK，并且在NEW YORK工作那么就给他薪金扣除5％;其他情况不作处理
create table yg
(zw varchar(255),
add varchar(225),
xz decimal(5,1)
)
insert into yg values('manager','dellas',4321),('clerk','new york',6432),('work','chengdu',1235)
commit;
 select * from yg
update yg set xz=case when zw='manager' and add='dellas' then xz*1.15 
                      when zw='clerk' and add='new york' then xz*0.95
                      else xz
                      end
3.行转列

 
create table lx(year int,month int,amout decimal(3,1))
insert into  lx values(1991,1,1.1),(1991,2,1.3),(1991,3,1.3),(1991,4,1.4),
                      (1992,1,1.1),(1992,2,1.2),(1992,3,1.3),(1992,4,1.4)
                      commit;
 select YEAR,sum(decode(month,'1',amout))m1,sum(decode(month,'2',amout))m2,sum(decode(month,'3',amout))m3,sum(decode(month,'4',amout))m4
 from lx group by year
 
4. --删除除了自动编号不同的,其他都相同的学生的冗余的信息
create table lx1
(no1 int , id int,name varchar(255),kmbh int,km varchar(255),cj decimal(4,1)
)
insert into lx1 values(1,2005001,'张三',0001,'数学',69),(2,2005002,'李四',0001,'数学',89),(3,2005001,'张三',0001,'数学',69)
commit;
 
delete lx1 where no1 not in(select min(no1) from lx1 group by id,name,kmbh,km,cj)--按照分组选择最小的编号，当编号不包含在这里的时候就进行删除的动作
 
当一个为null时候，会返回null值
1.in/not in
2.函数concat
select CONCAT('dddg',null) from sysibm.dual，输出null值





mysql常用
-----------------------------
-----------------------------

Mysql语句中，优先级:  and >  or

1.导出整个数据库
mysqldump -u 用户名 -p --default-character-set=latin1 数据库名 > 导出的文件名(数据库默认编码是latin1)
mysqldump -u wcnc -p smgp_apps_wcnc > wcnc.sql

2.导出一个表
mysqldump -u 用户名 -p 数据库名 表名> 导出的文件名
mysqldump -u wcnc -p smgp_apps_wcnc users> wcnc_users.sql

3.导出一个数据库结构
mysqldump -u wcnc -p -d –add-drop-table smgp_apps_wcnc >d:wcnc_db.sql
-d 没有数据 –add-drop-table 在每个create语句之前增加一个drop table

4.导入数据库

A:常用source 命令
进入mysql数据库控制台，
如mysql -u root -p
mysql>use 数据库
然后使用source命令，后面参数为脚本文件(如这里用到的.sql)
mysql>source wcnc_db.sql

B:使用mysqldump命令
mysqldump -u username -p dbname < filename.sql

C:使用mysql命令
mysql -u username -p -D dbname < filename.sql

一、启动与退出
1、进入MySQL：启动MySQL Command Line Client（MySQL的DOS界面），直接输入安装时的密码即可。此时的提示符是：mysql>
2、退出MySQL：quit或exit

二、库操作

1、创建数据库
命令：create database <数据库名>
例如：建立一个名为xhkdb的数据库
mysql> create database xhkdb; 

2、显示所有的数据库
命令：show databases （注意：最后有个s）
mysql> show databases;

3、删除数据库
命令：drop database <数据库名>
例如：删除名为 xhkdb的数据库
mysql> drop database xhkdb;

4、连接数据库
命令： use <数据库名>
例如：如果xhkdb数据库存在，尝试存取它：
mysql> use xhkdb;
屏幕提示：Database changed

5、查看当前使用的数据库
mysql> select database();

6、当前数据库包含的表信息：
mysql> show tables; （注意：最后有个s）


三、表操作，操作之前应连接某个数据库

1、建表
命令：create table <表名> ( <字段名1> <类型1> [,..<字段名n> <类型n>]);
mysql> create table MyClass(
> id int(4) not null primary key auto_increment,
> name char(20) not null,
> sex int(4) not null default '0',
> degree double(16,2));

2、获取表结构
命令： desc 表名，或者show columns from 表名
mysql>DESCRIBE MyClass
mysql> desc MyClass; 
mysql> show columns from MyClass;

3、删除表
命令：drop table <表名>
例如：删除表名为 MyClass 的表
mysql> drop table MyClass;

4、插入数据
命令：insert into <表名> [( <字段名1>[,..<字段名n > ])] values ( 值1 )[, ( 值n )]
例如，往表 MyClass中插入二条记录, 这二条记录表示：编号为1的名为Tom的成绩为96.45, 编号为2 的名为Joan 的成绩为82.99，编号为3 的名为Wang 的成绩为96.5.
mysql> insert into MyClass values(1,'Tom',96.45),(2,'Joan',82.99), (2,'Wang', 96.59);

5、查询表中的数据

1)、查询所有行
命令： select <字段1，字段2，...> from < 表名 > where < 表达式 >
例如：查看表 MyClass 中所有数据
mysql> select * from MyClass;

2）、查询前几行数据
例如：查看表 MyClass 中前2行数据
mysql> select * from MyClass order by id limit 0,2;
或者：
mysql> select * from MyClass limit 0,2;

6、删除表中数据
命令：delete from 表名 where 表达式
例如：删除表 MyClass中编号为1 的记录
mysql> delete from MyClass where id=1;

7、修改表中数据：update 表名 set 字段=新值,… where 条件
mysql> update MyClass set name='Mary' where id=1;
7、在表中增加字段：
命令：alter table 表名 add字段 类型 其他; 
例如：在表MyClass中添加了一个字段passtest，类型为int(4)，默认值为0 
mysql> alter table MyClass add passtest int(4) default '0'

8、更改表名：
命令：rename table 原表名 to 新表名; 
例如：在表MyClass名字更改为YouClass 
mysql> rename table MyClass to YouClass;
更新字段内容
update 表名 set 字段名 = 新内容
update 表名 set 字段名 = replace(字段名,'旧内容','新内容');
文章前面加入4个空格
update article set content=concat('　　',content);



字段类型
1．INT[(M)] 型： 正常大小整数类型 
2．DOUBLE[(M,D)] [ZEROFILL] 型： 正常大小(双精密)浮点数字类型 
3．DATE 日期类型：支持的范围是1000-01-01到9999-12-31。MySQL以YYYY-MM-DD格式来显示DATE值，但是允许你使用字符串或数字把值赋给DATE列 
4．CHAR(M) 型：定长字符串类型，当存储时，总是是用空格填满右边到指定的长度 
5．BLOB TEXT类型，最大长度为65535(2^16-1)个字符。 
6．VARCHAR型：变长字符串类型
5.导入数据库表 
（1）创建.sql文件 
（2）先产生一个库如auction.c:mysqlbin>mysqladmin -u root -p creat auction，会提示输入密码，然后成功创建。 
（2）导入auction.sql文件 
c:mysqlbin>mysql -u root -p auction < auction.sql。 
通过以上操作，就可以创建了一个数据库auction以及其中的一个表auction。 
6．修改数据库
（1）在mysql的表中增加字段： 
alter table dbname add column userid int(11) not null primary key auto_increment; 
这样，就在表dbname中添加了一个字段userid，类型为int(11)。 
7．mysql数据库的授权
mysql>grant select,insert,delete,create,drop 
on *.* (或test.*/user.*/..) 
to 用户名@localhost 
identified by '密码'； 
如：新建一个用户帐号以便可以访问数据库，需要进行如下操作： 
mysql> grant usage 
-> ON test.* 
-> TO testuser@localhost; 
Query OK, 0 rows affected (0.15 sec) 
此后就创建了一个新用户叫：testuser，这个用户只能从localhost连接到数据库并可以连接到test 数据库。下一步，我们必须指定testuser这个用户可以执行哪些操作： 
mysql> GRANT select, insert, delete,update 
-> ON test.* 
-> TO testuser@localhost; 
Query OK, 0 rows affected (0.00 sec) 
此操作使testuser能够在每一个test数据库中的表执行SELECT，INSERT和DELETE以及UPDATE查询操作。现在我们结束操作并退出MySQL客户程序： 
mysql> exit 
Bye9!
1:使用SHOW语句找出在服务器上当前存在什么数据库：
mysql> SHOW DATABASES;
2:2、创建一个数据库MYSQLDATA
mysql> Create DATABASE MYSQLDATA;
3:选择你所创建的数据库
mysql> USE MYSQLDATA; (按回车键出现Database changed 时说明操作成功！)
4:查看现在的数据库中存在什么表
mysql> SHOW TABLES;
5:创建一个数据库表
mysql> Create TABLE MYTABLE (name VARCHAR(20), sex CHAR(1));
6:显示表的结构：
mysql> DESCRIBE MYTABLE;
7:往表中加入记录
mysql> insert into MYTABLE values ("hyq","M");
8:用文本方式将数据装入数据库表中（例如D:/mysql.txt）
mysql> LOAD DATA LOCAL INFILE "D:/mysql.txt" INTO TABLE MYTABLE;
9:导入.sql文件命令（例如D:/mysql.sql）
mysql>use database;
mysql>source d:/mysql.sql;
10:删除表
mysql>drop TABLE MYTABLE;
11:清空表   root
mysql>delete from MYTABLE;
12:更新表中数据
mysql>update MYTABLE set sex="f" where name='hyq';


以下是无意中在网络看到的使用MySql的管理心得,
摘自:http://www1.xjtusky.com/article/htmldata/2004_12/3/57/article_1060_1.html
在windows中MySql以服务形式存在，在使用前应确保此服务已经启动，未启动可用net start mysql命令启动。而Linux中启动时可用“/etc/rc.d/init.d/mysqld start"命令，注意启动者应具有管理员权限。
刚安装好的MySql包含一个含空密码的root帐户和一个匿名帐户，这是很大的安全隐患，对于一些重要的应用我们应将安全性尽可能提高，在这里应把匿名帐户删除、 root帐户设置密码，可用如下命令进行：
use mysql;
delete from User where User="";
update User set Password=PASSWORD('newpassword') where User='root';
如果要对用户所用的登录终端进行限制，可以更新User表中相应用户的Host字段，在进行了以上更改后应重新启动数据库服务，此时登录时可用如下类似命令：
mysql -uroot -p;
mysql -uroot -pnewpassword;
mysql mydb -uroot -p;
mysql mydb -uroot -pnewpassword;
上面命令参数是常用参数的一部分，详细情况可参考文档。此处的mydb是要登录的数据库的名称。

在进行开发和实际应用中，用户不应该只用root用户进行连接数据库，虽然使用root用户进行测试时很方便，但会给系统带来重大安全隐患，也不利于管理技术的提高。我们给一个应用中使用的用户赋予最恰当的数据库权限。如一个只进行数据插入的用户不应赋予其删除数据的权限。MySql的用户管理是通过 User表来实现的，添加新用户常用的方法有两个，一是在User表插入相应的数据行，同时设置相应的权限；二是通过GRANT命令创建具有某种权限的用户。其中GRANT的常用用法如下：
grant all on mydb.* to NewUserName@HostName identified by "password" ;
grant usage on *.* to NewUserName@HostName identified by "password";
grant select,insert,update on mydb.* to NewUserName@HostName identified by "password";
grant update,delete on mydb.TestTable to NewUserName@HostName identified by "password";
若要给此用户赋予他在相应对象上的权限的管理能力，可在GRANT后面添加WITH GRANT OPTION选项。而对于用插入User表添加的用户，Password字段应用PASSWORD 函数进行更新加密，以防不轨之人窃看密码。对于那些已经不用的用户应给予清除，权限过界的用户应及时回收权限，回收权限可以通过更新User表相应字段，也可以使用REVOKE操作。
下面给出本人从其它资料(www.cn-java.com)获得的对常用权限的解释：
全局管理权限：
FILE: 在MySQL服务器上读写文件。
PROCESS: 显示或杀死属于其它用户的服务线程。
RELOAD: 重载访问控制表，刷新日志等。
SHUTDOWN: 关闭MySQL服务。
数据库/数据表/数据列权限：
Alter: 修改已存在的数据表(例如增加/删除列)和索引。
Create: 建立新的数据库或数据表。
Delete: 删除表的记录。
Drop: 删除数据表或数据库。
INDEX: 建立或删除索引。
Insert: 增加表的记录。
Select: 显示/搜索表的记录。
Update: 修改表中已存在的记录。
特别的权限：
ALL: 允许做任何事(和root一样)。
USAGE: 只允许登录--其它什么也不允许做。
---------------------




MYSQL常用命令
有很多朋友虽然安装好了mysql但却不知如何使用它。在这篇文章中我们就从连接MYSQL、修改密码、增加用户等方面来学习一些MYSQL的常用命令。

一、连接MYSQL
格式： mysql -h主机地址 -u用户名 －p用户密码
1、例1：连接到本机上的MYSQL
首先在打开DOS窗口，然后进入目录 mysqlbin，再键入命令mysql -uroot -p，回车后提示你输密码，如果刚安装好MYSQL，超级用户root是没有密码的，故直接回车即可进入到MYSQL中了，MYSQL的提示符是：mysql> 
2、例2：连接到远程主机上的MYSQL
假设远程主机的IP为：110.110.110.110，用户名为root,密码为abcd123。则键入以下命令：
mysql -h110.110.110.110 -uroot -pabcd123
（注:u与root可以不用加空格，其它也一样）
3、退出MYSQL命令： exit （回车）

二、修改密码
格式：mysqladmin -u用户名 -p旧密码 password 新密码
1、例1：给root加个密码ab12。首先在DOS下进入目录mysqlbin，然后键入以下命令
mysqladmin -uroot -password ab12
注：因为开始时root没有密码，所以-p旧密码一项就可以省略了。
2、例2：再将root的密码改为djg345
mysqladmin -uroot -pab12 password djg345

MYSQL常用命令（下）
一、操作技巧
1、如果你打命令时，回车后发现忘记加分号，你无须重打一遍命令，只要打个分号回车就可以了。也就是说你可以把一个完整的命令分成几行来打，完后用分号作结束标志就OK。
2、你可以使用光标上下键调出以前的命令。但以前我用过的一个MYSQL旧版本不支持。我现在用的是mysql-3.23.27-beta-win。

二、显示命令
1、显示数据库列表。
show databases;
刚开始时才两个数据库：mysql和test。mysql库很重要它里面有MYSQL的系统信息，我们改密码和新增用户，实际上就是用这个库进行操作。
2、显示库中的数据表：
use mysql； ／／打开库，学过FOXBASE的一定不会陌生吧
show tables;
3、显示数据表的结构：
describe 表名;
4、建库：
create database 库名;
5、建表：
use 库名；
create table 表名 (字段设定列表)；
6、删库和删表:
drop database 库名;
drop table 表名；
7、将表中记录清空：
delete from 表名;
8、显示表中的记录：
select * from 表名;

三、一个建库和建表以及插入数据的实例
drop database if exists school; //如果存在SCHOOL则删除
create database school; //建立库SCHOOL
use school; //打开库SCHOOL

create table teacher //建立表TEACHER
(
id int(3) auto_increment not null primary key,
name char(10) not null,
address varchar(50) default '深圳',
year date
); //建表结束

//以下为插入字段
insert into teacher values('','glchengang','深圳一中','1976-10-10');
insert into teacher values('','jack','深圳一中','1975-12-23');
注：在建表中（1）将ID设为长度为3的数字字段:int(3)并让它每个记录自动加一:auto_increment并不能为空:not null而且让他成为主字段primary key
（2）将NAME设为长度为10的字符字段
（3）将ADDRESS设为长度50的字符字段，而且缺省值为深圳。varchar和char有什么区别呢，只有等以后的文章再说了。
（4）将YEAR设为日期字段。
如果你在mysql提示符键入上面的命令也可以，但不方便调试。你可以将以上命令原样写入一个文本文件中假设为school.sql，然后复制到c:\下，并在DOS状态进入目录\mysql\bin，然后键入以下命令：
mysql -uroot -p密码 < c:\school.sql
如果成功，空出一行无任何显示；如有错误，会有提示。（以上命令已经调试，你只要将//的注释去掉即可使用）。

四、将文本数据转到数据库中
1、文本数据应符合的格式：字段数据之间用tab键隔开，null值用\n来代替.
例：
3 rose 深圳二中 1976-10-10
4 mike 深圳一中 1975-12-23

2、数据传入命令 load data local infile "文件名" into table 表名;
注意：你最好将文件复制到\mysql\bin目录下，并且要先用use命令打表所在的库 。
五、备份数据库：（命令在DOS的\mysql\bin目录下执行）
mysqldump --opt school>school.bbb
注释:将数据库school备份到school.bbb文件，school.bbb是一个文本文件，文件名任取，打开看看你会有新发现。


一.SELECT语句的完整语法为： 
SELECT[ALL|DISTINCT|DISTINCTROW|TOP] 
{*|talbe.*|[table.]field1[AS alias1][,[table.]field2[AS alias2][,…]]} 
FROM tableexpression[,…][IN externaldatabase] 
[WHERE…] 
[GROUP BY…] 
[HAVING…] 
[ORDER BY…] 
[WITH OWNERACCESS OPTION] 
说明： 
用中括号([])括起来的部分表示是可选的，用大括号({})括起来的部分是表示必须从中选择其中的一个。 

1 FROM子句 
FROM 子句指定了SELECT语句中字段的来源。FROM子句后面是包含一个或多个的表达式(由逗号分开)，其中的表达式可为单一表名称、已保存的查询或由 INNER JOIN、LEFT JOIN 或 RIGHT JOIN 得到的复合结果。如果表或查询存储在外部数据库，在IN 子句之后指明其完整路径。 
例：下列SQL语句返回所有有定单的客户： 
SELECT OrderID,Customer.customerID 
FROM Orders Customers 
WHERE Orders.CustomerID=Customers.CustomeersID

2 ALL、DISTINCT、DISTINCTROW、TOP谓词 
(1) ALL 返回满足SQL语句条件的所有记录。如果没有指明这个谓词，默认为ALL。 
例：SELECT ALL FirstName,LastName 
FROM Employees 
(2) DISTINCT 如果有多个记录的选择字段的数据相同，只返回一个。 
(3) DISTINCTROW 如果有重复的记录，只返回一个 
(4) TOP显示查询头尾若干记录。也可返回记录的百分比，这是要用 TOP N PERCENT子句（其中N 表示百分比） 
例：返回5%定货额最大的定单 
SELECT TOP 5 PERCENT* 
FROM [ Order Details] 
ORDER BY UnitPrice*Quantity*(1-Discount) DESC

3 用 AS 子句为字段取别名 
如果想为返回的列取一个新的标题，或者，经过对字段的计算或总结之后，产生了一个新的值，希望把它放到一个新的列里显示，则用AS保留。 
例：返回FirstName字段取别名为NickName 
SELECT FirstName AS NickName ,LastName ,City 
FROM Employees 
例：返回新的一列显示库存价值 
SELECT ProductName ,UnitPrice ,UnitsInStock ,UnitPrice*UnitsInStock AS valueInStock 
FROM Products

二 .WHERE 子句指定查询条件
1 比较运算符 
比较运算符 含义 
= 等于 
> 大于 
< 小于 
>= 大于等于 
<= 小于等于 
<> 不等于 
!> 不大于 
!< 不小于 

> ANY : 大于最小
< ANY：小于最大
> ALL：大于最大
< ALL：小于最小

例：返回96年1月的定单 
SELECT OrderID, CustomerID, OrderDate 
FROM Orders 
WHERE OrderDate>#1/1/96# AND OrderDate<#1/30/96# 
注意： 
Mcirosoft JET SQL 中，日期用‘#’定界。日期也可以用Datevalue()函数来代替。在比较字符型的数据时，要加上单引号’’，尾空格在比较中被忽略。 
例： 
WHERE OrderDate>#96-1-1# 
也可以表示为： 
WHERE OrderDate>Datevalue(‘1/1/96’) 
使用 NOT 表达式求反。 
例：查看96年1月1日以后的定单 
WHERE Not OrderDate<=#1/1/96# 

2 范围（BETWEEN 和 NOT BETWEEN） 
BETWEEN …AND…运算符指定了要搜索的一个闭区间。 
例：返回96年1月到96年2月的定单。 
WHERE OrderDate Between #1/1/96# And #2/1/96# 

3 列表（IN ，NOT IN） 
IN 运算符用来匹配列表中的任何一个值。IN子句可以代替用OR子句连接的一连串的条件。 
例：要找出住在 London、Paris或Berlin的所有客户 
SELECT CustomerID, CompanyName, ContactName, City 
FROM Customers 
WHERE City In(‘London’,’ Paris’,’ Berlin’) 

UPPER:字符串大写
SELECT ename, sal, job FROMempWHERE ename = UPPER('rose');

函数表达式：
SELECT ename, sal, job FROM empWHERE sal * 12 >100000;

去掉重复的查询：
select distinct * from students;
select distinct name, sex, age from students;


4 模式匹配(LIKE) 
LIKE运算符检验一个包含字符串数据的字段值是否匹配一指定模式。 
LIKE运算符里使用的通配符 
通配符 含义 
%  0到多个字符
_      单个字符
？ 任何一个单一的字符 
* 任意长度的字符 
# 0~9之间的单一数字 
[字符列表] 在字符列表里的任一值 
[！字符列表] 不在字符列表里的任一值 
- 指定字符范围，两边的值分别为其上下限 
例：返回邮政编码在（171）555-0000到（171）555-9999之间的客户 
SELECT CustomerID ,CompanyName,City,Phone 
FROM Customers 
WHERE Phone Like ‘(171)555-####’ 
LIKE运算符的一些样式及含义 
样式 含义 不符合 
LIKE ‘A*’ A后跟任意长度的字符 Bc,c255 
LIKE’5[*]’ 5*5 555 
LIKE’5?5’ 5与5之间有任意一个字符 55,5wer5 
LIKE’5##5’ 5235，5005 5kd5,5346 
LIKE’[a-z]’ a-z间的任意一个字符 5,% 
LIKE’[!0-9]’ 非0-9间的任意一个字符 0,1 
LIKE’[[]’ 1,* 


三 .用ORDER BY子句排序结果 
ORDER子句按一个或多个（最多16个）字段排序查询结果，可以是升序（ASC）也可以是降序（DESC），缺省是升序。ORDER子句通常放在SQL语句的最后。 
ORDER子句中定义了多个字段，则按照字段的先后顺序排序。 
例： 
SELECT ProductName,UnitPrice, UnitInStock 
FROM Products 
ORDER BY UnitInStock DESC , UnitPrice DESC, ProductName 
ORDER BY 子句中可以用字段在选择列表中的位置号代替字段名，可以混合字段名和位置号。 
例：下面的语句产生与上列相同的效果。 
SELECT ProductName,UnitPrice, UnitInStock 
FROM Products 
ORDER BY 1 DESC , 2 DESC,3 

四 .运用连接关系实现多表查询 
例：找出同一个城市中供应商和客户的名字 
SELECT Customers.CompanyName, Suppliers.ComPany.Name 
FROM Customers, Suppliers 
WHERE Customers.City=Suppliers.City 
例：找出产品库存量大于同一种产品的定单的数量的产品和定单 
SELECT ProductName,OrderID, UnitInStock, Quantity 
FROM Products, [Order Deails] 
WHERE Product.productID=[Order Details].ProductID 
AND UnitsInStock>Quantity 
另一种方法是用 Microsof JET SQL 独有的 JNNER JOIN 
语法： 
FROM table1 INNER JOIN table2 
ON table1.field1 comparision table2.field2 
其中comparision 就是前面WHERE子句用到的比较运算符。 
SELECT FirstName,lastName,OrderID,CustomerID,OrderDate 
FROM Employees 
INNER JOIN Orders ON Employees.EmployeeID=Orders.EmployeeID 
注意： 
INNER JOIN不能连接Memo OLE Object Single Double 数据类型字段。 
在一个JOIN语句中连接多个ON子句 
语法： 
SELECT fields 
FROM table1 INNER JOIN table2 
ON table1.field1 compopr table2.field1 AND 
ON table1.field2 compopr table2.field2 OR 
ON table1.field3 compopr table2.field3 
也可以 
SELECT fields 
FROM table1 INNER JOIN 
（table2 INNER JOIN [( ]table3 
[INNER JOER] [( ]tablex[INNER JOIN] 
ON table1.field1 compopr table2.field1 
ON table1.field2 compopr table2.field2 
ON table1.field3 compopr table2.field3 
外部连接返回更多记录，在结果中保留不匹配的记录，不管存不存在满足条件的记录都要返回另一侧的所有记录。 
FROM table [LEFT|RIGHT]JOIN table2 
ON table1.field1comparision table.field2 
用左连接来建立外部连接，在表达式的左边的表会显示其所有的数据 
例：不管有没有定货量，返回所有商品 
SELECT ProductName ,OrderID 
FROM Products 
LEFT JOIN Orders ON Products.PrductsID=Orders.ProductID 
右连接与左连接的差别在于：不管左侧表里有没有匹配的记录，它都从左侧表中返回所有记录。 
例：如果想了解客户的信息，并统计各个地区的客户分布，这时可以用一个右连接，即使某个地区没有客户，也要返回客户信息。 
空值不会相互匹配，可以通过外连接才能测试被连接的某个表的字段是否有空值。 
SELECT * 
FROM talbe1 
LEFT JOIN table2 ON table1.a=table2.c 
1 连接查询中使用Iif函数实现以0值显示空值 
Iif表达式： Iif(IsNull(Amount,0,Amout) 
例：无论定货大于或小于￥50，都要返回一个标志。 
Iif([Amount]>50,?Big order?,?Small order?) 


五. 分组和总结查询结果 
在SQL的语法里，GROUP BY和HAVING子句用来对数据进行汇总。GROUP BY子句指明了按照哪几个字段来分组，而将记录分组后，用HAVING子句过滤这些记录。 
GROUP BY 子句的语法 
SELECT fidldlist 
FROM table 
WHERE criteria 
[GROUP BY groupfieldlist [HAVING groupcriteria]] 
注：Microsoft Jet数据库 Jet 不能对备注或OLE对象字段分组。 
GROUP BY字段中的Null值以备分组但是不能被省略。 
在任何SQL合计函数中不计算Null值。 
GROUP BY子句后最多可以带有十个字段，排序优先级按从左到右的顺序排列。 
例：在‘WA’地区的雇员表中按头衔分组后，找出具有同等头衔的雇员数目大于1人的所有头衔。 
SELECT Title ,Count(Title) as Total 
FROM Employees 
WHERE Region = ‘WA’ 
GROUP BY Title 
HAVING Count(Title)>1 


JET SQL 中的聚积函数 
聚集函数 意义 
SUM ( ) 求和 
AVG ( ) 平均值 
COUNT ( ) 表达式中记录的数目 
COUNT (* ) 计算记录的数目 
MAX 最大值 
MIN 最小值 
VAR 方差 
STDEV 标准误差 
FIRST 第一个值 
LAST 最后一个值 


六. 用Parameters声明创建参数查询 
Parameters声明的语法: 
PARAMETERS name datatype[,name datatype[, …]] 
其中name 是参数的标志符,可以通过标志符引用参数. 
Datatype说明参数的数据类型. 
使用时要把PARAMETERS 声明置于任何其他语句之前. 
例: 
PARAMETERS[Low price] Currency,[Beginning date]datatime 
SELECT OrderID ,OrderAmount 
FROM Orders 
WHERE OrderAMount>[low price] 
AND OrderDate>=[Beginning date] 

七. 功能查询 
所谓功能查询,实际上是一种操作查询,它可以对数据库进行快速高效的操作.它以选择查询为目的,挑选出符合条件的数据,再对数据进行批处理.功能查询包括更新查询,删除查询,添加查询,和生成表查询.

1 更新查询 
UPDATE子句可以同时更改一个或多个表中的数据.它也可以同时更改多个字段的值. 
更新查询语法: 
UPDATE 表名 
SET 新值 
WHERE 准则 
例:英国客户的定货量增加5%,货运量增加3% 
UPDATE OEDERS 
SET OrderAmount = OrderAmount *1.1 
Freight = Freight*1.03 
WHERE ShipCountry = ‘UK’ 

2 删除查询 
DELETE子句可以使用户删除大量的过时的或冗于的数据. 
注:删除查询的对象是整个记录. 
DELETE子句的语法: 
DELETE [表名.*] 
FROM 来源表 
WHERE 准则 
例: 要删除所有94年前的定单 
DELETE * 
FROM Orders 
WHERE OrderData<#94-1-1# 

3 追加查询 
INSERT子句可以将一个或一组记录追加到一个或多个表的尾部. 
INTO 子句指定接受新记录的表 
valueS 关键字指定新记录所包含的数据值. 
INSERT 子句的语法: 
INSETR INTO 目的表或查询(字段1,字段2,…) 
valueS(数值1,数值2,…) 
例:增加一个客户 
INSERT INTO Employees(FirstName,LastName,title) 
valueS(‘Harry’,’Washington’,’Trainee’) 

4 生成表查询 
可以一次性地把所有满足条件的记录拷贝到一张新表中.通常制作记录的备份或副本或作为报表的基础. 
SELECT INTO子句用来创建生成表查询语法: 
SELECT 字段1,字段2,… 
INTO 新表[IN 外部数据库] 
FROM 来源数据库 
WHERE 准则 
例:为定单制作一个存档备份 
SELECT * 
INTO OrdersArchive 
FROM Orders 


八. 联合查询 
UNION运算可以把多个查询的结果合并到一个结果集里显示. 
UNION运算的一般语法: 
[表]查询1 UNION [ALL]查询2 UNION … 
例:返回巴西所有供给商和客户的名字和城市 
SELECT CompanyName,City 
FROM Suppliers 
WHERE Country = ‘Brazil’ 
UNION 
SELECT CompanyName,City 
FROM Customers 
WHERE Country = ‘Brazil’ 
注: 
缺省的情况下,UNION子句不返回重复的记录.如果想显示所有记录,可以加ALL选项 
UNION运算要求查询具有相同数目的字段.但是,字段数据类型不必相同. 
每一个查询参数中可以使用GROUP BY 子句 或 HAVING 子句进行分组.要想以指定的顺序来显示返回的数据,可以在最后一个查询的尾部使用OREER BY子句. 

九. 交叉查询 
交叉查询可以对数据进行总和,平均,计数或其他总和计算法的计算,这些数据通过两种信息进行分组:一个显示在表的左部,另一个显示在表的顶部. 
Microsoft Jet SQL 用TRANSFROM语句创建交叉表查询语法: 
TRANSFORM aggfunction 
SELECT 语句 
GROUP BY 子句 
PIVOT pivotfield[IN(value1 [,value2[,…]]) ] 
Aggfounction指SQL聚积函数, 
SELECT语句选择作为标题的的字段, 
GROUP BY 分组 
说明： 
Pivotfield 在查询结果集中创建列标题时用的字段或表达式,用可选的IN子句限制它的取值. 
value代表创建列标题的固定值. 
例:显示在1996年里每一季度每一位员工所接的定单的数目: 
TRANSFORM Count(OrderID) 
SELECT FirstName&’’&LastName AS FullName 
FROM Employees INNER JOIN Orders 
ON Employees.EmployeeID = Orders.EmployeeID 
WHERE DatePart(“yyyy”,OrderDate)= ‘1996’ 
GROUP BY FirstName&’’&LastName 
ORDER BY FirstName&’’&LastName 
POVOT DatePart(“q”,OrderDate)&’季度’ 

十 .子查询 
子查询可以理解为 套查询.子查询是一个SELECT语句. 
1 表达式的值与子查询返回的单一值做比较 
语法: 
表达式 comparision [ANY|ALL|SOME](子查询) 
说明： 
ANY 和SOME谓词是同义词,与比较运算符(=,<,>,<>,<=,>=)一起使用.返回一个布尔值True或 False.ANY的意思是,表达式与子查询返回的一系列的值逐一比较,只要其中的一次比较产生True结果,ANY测试的返回 True值(既WHERE子句的结果),对应于该表达式的当前记录将进入主查询的结果中.ALL测试则要求表达式与子查询返回的一系列的值的比较都产生 True结果,才回返回True值. 
例:主查询返回单价比任何一个折扣大于等于25%的产品的单价要高的所有产品 
SELECT * FROM Products 
WHERE UnitPrice>ANY 
(SELECT UnitPrice FROM[Order Details] WHERE Discount>0.25)
2 检查表达式的值是否匹配子查询返回的一组值的某个值 
语法: 
[NOT]IN(子查询) 
例:返回库存价值大于等于1000的产品. 
SELECT ProductName FROM Products 
WHERE ProductID IN 
(SELECT PrdoctID FROM [Order DEtails] 
WHERE UnitPrice*Quantity>= 1000)
3检测子查询是否返回任何记录 
语法: 
[NOT]EXISTS (子查询) 
例:用EXISTS检索英国的客户 
SELECT ComPanyName,ContactName 
FROM Orders 
WHERE EXISTS 
(SELECT * 
FROM Customers 
WHERE Country = ‘UK’ AND 
Customers.CustomerID= Orders.CustomerID)





/////////////////////////////////////////////////////////////////////



