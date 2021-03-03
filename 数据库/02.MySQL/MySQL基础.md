
# 数据库的基本概念
	1. 数据库的英文单词： DataBase 简称 ： DB
	2. 什么数据库？
		* 用于存储和管理数据的仓库。
	
	3. 数据库的特点：
		1. 持久化存储数据的。其实数据库就是一个文件系统
		2. 方便存储和管理数据
		3. 使用了统一的方式操作数据库 -- SQL


# MySQL数据库
	1. MySQL服务启动
		1. 手动。
		2. cmd--> services.msc 打开服务的窗口
		3. 使用管理员打开cmd
			* net start mysql : 启动mysql的服务
			* net stop mysql:关闭mysql服务
	2. MySQL登录
		1. mysql -uroot -p密码
		2. mysql -hip -uroot -p连接目标的密码
		3. mysql --host=ip --user=root --password=连接目标的密

# SQL

	1.什么是SQL？
		Structured Query Language：结构化查询语言
		其实就是定义了操作所有关系型数据库的规则。每一种数据库操作的方式存在不一样的地方，称为“方言”。
		
	2.SQL通用语法
		1. SQL 语句可以单行或多行书写，以分号结尾。
		2. 可使用空格和缩进来增强语句的可读性。
		3. MySQL 数据库的 SQL 语句不区分大小写，关键字建议使用大写。
		4. 3 种注释
			* 单行注释: -- 注释内容 或 # 注释内容(mysql 特有) 
			* 多行注释: /* 注释 */
		
	3. SQL分类
		1) DDL(Data Definition Language)数据定义语言
			用来定义数据库对象：数据库，表，列等。关键字：create, drop,alter 等
		2) DML(Data Manipulation Language)数据操作语言
			用来对数据库中表的数据进行增删改。关键字：insert, delete, update 等
		3) DQL(Data Query Language)数据查询语言
			用来查询数据库中表的记录(数据)。关键字：select, where 等
		4) DCL(Data Control Language)数据控制语言(了解)
			用来定义数据库的访问权限和安全级别，及创建用户。关键字：GRANT， REVOKE 等

## DDL：操作数据库、表

	1. 操作数据库：CRUD
		1. C(Create):创建
			* 创建数据库：
				* create database 数据库名称;
			* 创建数据库，判断不存在，再创建：
				* create database if not exists 数据库名称;
			* 创建数据库，并指定字符集
				* create database 数据库名称 character set 字符集名;
	
			* 练习： 创建db4数据库，判断是否存在，并制定字符集为gbk
				* create database if not exists db4 character set gbk;
		2. R(Retrieve)：查询
			* 查询所有数据库的名称:
				* show databases;
			* 查询某个数据库的字符集:查询某个数据库的创建语句
				* show create database 数据库名称;
		3. U(Update):修改
			* 修改数据库的字符集
				* alter database 数据库名称 character set 字符集名称;
		4. D(Delete):删除
			* 删除数据库
				* drop database 数据库名称;
			* 判断数据库存在，存在再删除
				* drop database if exists 数据库名称;
		5. 使用数据库
			* 查询当前正在使用的数据库名称
				* select database();
			* 使用数据库
				* use 数据库名称;


	2. 操作表
		1. C(Create):创建
			1. 语法：
				create table 表名(
					列名1 数据类型1,
					列名2 数据类型2,
					....
					列名n 数据类型n
				);
				* 注意：最后一列，不需要加逗号（,）
				* 数据库类型：
					1. int：整数类型
						* age int,
					2. double:小数类型
						* score double(5,2)
					3. date:日期，只包含年月日，yyyy-MM-dd
					4. datetime:日期，包含年月日时分秒	 yyyy-MM-dd HH:mm:ss
					5. timestamp:时间错类型	包含年月日时分秒	 yyyy-MM-dd HH:mm:ss	
						* 如果将来不给这个字段赋值，或赋值为null，则默认使用当前的系统时间，来自动赋值
	
					6. varchar：字符串
						* name varchar(20):姓名最大20个字符
						* zhangsan 8个字符  张三 2个字符


			* 创建表
				create table student(
					id int,
					name varchar(32),
					age int ,
					score double(4,1),
					birthday date,
					insert_time timestamp
				);
			* 复制表：
				* create table 表名 like 被复制的表名;	  	
		2. R(Retrieve)：查询
			* 查询某个数据库中所有的表名称
				* show tables;
			* 查询表结构
				* desc 表名;
		3. U(Update):修改
			1. 修改表名
				alter table 表名 rename to 新的表名;
			2. 修改表的字符集
				alter table 表名 character set 字符集名称;
			3. 添加一列
				alter table 表名 add 列名 数据类型;
			4. 修改列名称 类型
				alter table 表名 change 列名 新列别 新数据类型;
				alter table 表名 modify 列名 新数据类型;
			5. 删除列
				alter table 表名 drop 列名;
		4. D(Delete):删除
			* drop table 表名;
			* drop table  if exists 表名 ;

* 客户端图形化工具：SQLYog

## DML：增删改表中数据

	1. 添加数据：
		* 语法：
			* insert into 表名(列名1,列名2,...列名n) values(值1,值2,...值n);
		* 注意：
			1. 列名和值要一一对应。
			2. 如果表名后，不定义列名，则默认给所有列添加值
				insert into 表名 values(值1,值2,...值n);
			3. 除了数字类型，其他类型需要使用引号(单双都可以)引起来
	2. 删除数据：
		* 语法：
			* delete from 表名 [where 条件]
		* 注意：
			1. 如果不加条件，则删除表中所有记录。
			2. 如果要删除所有记录
				1. delete from 表名; -- 不推荐使用。有多少条记录就会执行多少次删除操作
				2. TRUNCATE TABLE 表名; -- 推荐使用，效率更高 先删除表，然后再创建一张一样的表。
	3. 修改数据：
		* 语法：
			* update 表名 set 列名1 = 值1, 列名2 = 值2,... [where 条件];
	
		* 注意：
			1. 如果不加任何条件，则会将表中所有记录全部修改。



## DQL：查询表中的记录


### 1. 基础查询


```sql
* select * from 表名;
1. 语法：
	select
		字段列表
	from
		表名列表
	where
		条件列表
	group by
		分组字段
	having
		分组之后的条件
	order by
		排序
	limit
		分页限定
		
-- 多个字段的查询
	select 字段名1，字段名2... from 表名；
	* 注意：
		* 如果查询所有字段，则可以使用*来替代字段列表。
		
-- 去除重复：
		* distinct
		
-- 计算列
		* 一般可以使用四则运算计算一些列的值。（一般只会进行数值型的计算）
		* ifnull(表达式1,表达式2)：null参与的运算，计算结果都为null
			* 表达式1：哪个字段需要判断是否为null
			* 如果该字段为null后的替换值。
-- 起别名：
		* as：as也可以省略
```

### 2. 条件查询


```sql
1. where子句后跟条件
2. 运算符
		* > 、< 、<= 、>= 、= 、<>
		* BETWEEN...AND  
		* IN( 集合) 
		* LIKE：模糊查询
			* 占位符：
				* _:单个任意字符
				* %：多个任意字符
		* IS NULL  
		* and  或 &&
		* or  或 || 
		* not  或 !
		
-- 查询年龄大于20岁
	SELECT * FROM student WHERE age > 20;
	SELECT * FROM student WHERE age >= 20;
			
-- 查询年龄等于20岁
	SELECT * FROM student WHERE age = 20;
			
-- 查询年龄不等于20岁
	SELECT * FROM student WHERE age != 20;
	SELECT * FROM student WHERE age <> 20;
			
-- 查询年龄大于等于20 小于等于30
	SELECT * FROM student WHERE age >= 20 && age <=30;
	
	SELECT * FROM student WHERE age >= 20 AND  age <=30;
	
	SELECT * FROM student WHERE age BETWEEN 20 AND 30;
			
-- 查询年龄22岁，18岁，25岁的信息
	SELECT * FROM student WHERE age = 22 OR age = 18 OR age = 25
	SELECT * FROM student WHERE age IN (22,18,25);
			
-- 查询英语成绩为null
	SELECT * FROM student WHERE english = NULL; 
	-- 不对的。null值不能使用 = （!=） 判断
			
	SELECT * FROM student WHERE english IS NULL;
			
-- 查询英语成绩不为null
	SELECT * FROM student WHERE english  IS NOT NULL;
			
-- 查询姓马的有哪些？ like
	SELECT * FROM student WHERE NAME LIKE '马%';
-- 查询姓名第二个字是化的人
	SELECT * FROM student WHERE NAME LIKE "_化%";
			
-- 查询姓名是3个字的人
	SELECT * FROM student WHERE NAME LIKE '___';
			
-- 查询姓名中包含德的人
    SELECT * FROM student WHERE NAME LIKE '%德%';
```

### 3. 排序查询

```sql
* 语法：order by 子句
		* order by 排序字段1 排序方式1 ，  排序字段2 排序方式2...

	* 排序方式：
		* ASC：升序，默认的。
		* DESC：降序。

	* 注意：
		* 如果有多个排序条件，则当前边的条件值一样时，才会判断第二条件。
```

### 4. 聚合函数

```sql
* 聚合函数：将一列数据作为一个整体，进行纵向的计算。
	1. count：计算个数
		1. 一般选择非空的列：主键
		2. count(*)
	2. max：计算最大值
	3. min：计算最小值
	4. sum：计算和
	5. avg：计算平均值
	
    * 注意：聚合函数的计算，排除null值。
        解决方案：
            1. 选择不包含非空的列进行计算
            2. IFNULL函数
```

### 5. 分组查询

```sql
* 语法：group by 分组字段；
* 注意：
	1. 分组之后查询的字段：分组字段、聚合函数
	2. where 和 having 的区别？
		where 在分组之前进行限定，如果不满足条件，则不参与分组。having在分组之后进行限定，如果不满足结果，则不会被查询出来
		where 后不可以跟聚合函数，having可以进行聚合函数的判断。

-- 按照性别分组。分别查询男、女同学的平均分
	SELECT sex , AVG(math) FROM student GROUP BY sex;
		
-- 按照性别分组。分别查询男、女同学的平均分,人数
	SELECT sex , AVG(math),COUNT(id) FROM student GROUP BY sex;
		
--  按照性别分组。分别查询男、女同学的平均分,人数 要求：分数低于70分的人，不参与分组
	SELECT sex , AVG(math),COUNT(id) FROM student WHERE math > 70 GROUP BY sex;
		
--  按照性别分组。分别查询男、女同学的平均分,人数 要求：分数低于70分的人，不参与分组,分组之后。人数要大于2个人
	SELECT sex , AVG(math),COUNT(id) FROM student WHERE math > 70 GROUP BY sex HAVING COUNT(id) > 2;
		
	SELECT sex , AVG(math),COUNT(id) 人数 FROM student WHERE math > 70 GROUP BY sex HAVING 人数 > 2;
```

### 6. 分页查询

```sql
* 语法：limit 开始的索引,每页查询的条数;
* 公式：开始的索引 = （当前的页码 - 1） * 每页显示的条数
	-- 每页显示3条记录
		SELECT * FROM student LIMIT 0,3; -- 第1页
		
		SELECT * FROM student LIMIT 3,3; -- 第2页
		
		SELECT * FROM student LIMIT 6,3; -- 第3页

* limit 是一个MySQL"方言"
```



## DCL：管理用户，授权

```sql
1. 管理用户
	1. 添加用户：
			* 语法：CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码';
			
	2. 删除用户：
			* 语法：DROP USER '用户名'@'主机名';
			
	3. 修改用户密码：
			UPDATE USER SET PASSWORD = PASSWORD('新密码') WHERE USER = '用户名';
			UPDATE USER SET PASSWORD = PASSWORD('abc') WHERE USER = 'lisi';
			
			SET PASSWORD FOR '用户名'@'主机名' = PASSWORD('新密码');
			SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123');

	* mysql中忘记了root用户的密码？
		1. cmd >> net stop mysql 停止mysql服务  -- 需要管理员运行该cmd
		2. 使用无验证方式启动mysql服务： mysqld --skip-grant-tables
		3. 打开新的cmd窗口,直接输入mysql命令，敲回车。就可以登录成功
		4. use mysql;
		5. update user set password = password('你的新密码') where user = 'root';
		6. 关闭两个窗口
		7. 打开任务管理器，手动结束mysqld.exe 的进程
		8. 启动mysql服务
		9. 使用新密码登录。
		
	4. 查询用户：
		-- 1. 切换到mysql数据库
			USE myql;
		-- 2. 查询user表
			SELECT * FROM USER;
			
2. 权限管理：
	1. 查询权限：
		-- 查询权限
			SHOW GRANTS FOR '用户名'@'主机名';
			SHOW GRANTS FOR 'lisi'@'%';

	2. 授予权限：
		-- 授予权限
			grant 权限列表 on 数据库名.表名 to '用户名'@'主机名';
		-- 给张三用户授予所有权限，在任意数据库任意表上
			GRANT ALL ON *.* TO 'zhangsan'@'localhost';
			
	3. 撤销权限：
		-- 撤销权限：
			revoke 权限列表 on 数据库名.表名 from '用户名'@'主机名';
			REVOKE UPDATE ON db3.`account` FROM 'lisi'@'%';
	* 通配符： % 表示可以在任意主机使用用户登录数据库
```

# 数据库的备份和还原

```
1. 命令行：
	* 语法：
		* 备份： mysqldump -u用户名 -p密码 数据库名称 > 保存的路径
		* 还原：
			1. 登录数据库
			2. 创建数据库
			3. 使用数据库
			4. 执行文件 source 文件路径
```

# nvl与coalesce的区别

```sql
nvl(EXPR1,0)
-- 如果第一个参数为null，则返回第二个参数
-- 如果第一个参数为非null，则返回第一个参数

coalesce(EXPR1,EXPR2,EXPR3...EXPRn)
-- 从左往右数，遇到第一个非null值，则返回该非null值。多层判断

第一点区别：从上面可以知道，nvl只适合于两个参数的，COALESCE适合于多个参数。
第二点区别：COALESCE里的所有参数类型必须保持一致，nvl可以不一致。

```








​	