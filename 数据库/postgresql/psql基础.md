## 系统命令

```java
psql -version		// 版本号
psql -U user_name -d db_name [-h host] [-p port]		// 连接数据库
```

## 数据库中命令

### 基本数据库操作

```java
\l		// 查看已有数据库
\q		// 退出客户端程序psql 
\d		// 查看表结构
\dt		// 查看表
\di		// 查看索引
\d t_name		// 查看某个表的状况
    
\x		// 将数据从横向显示变为纵向显示
\pset border 0		// 输出内容无边框    
\pset border 1		// 输出内容边框只在内部
\pset border 2		// 输出内容边框
    
\c db_name		// 切换数据库
    
create database db_name;		// 创建名为name的数据库
drop database db_name;		// 删除 数据库

```

### 表内基本操作

```java
create table t_name (字段名1 类型1 <references 关联表名(关联的字段名)>;,字段名2 类型2,......<,primary key (字段名m,字段名n,...)>;); 		// 创建表
drop table t_name;		// 删除表

alter table t_name1 rename to tname2;		// 表重命名 1到2
alter table t_name add column 字段名 类型;		// 表中添加字段
alter table t_name drop column 字段名；		// 删除表中字段
alter table t_name rename column 字段名1 to 字段名2；		//字段1重命名为2
alter table t_name alter column 字段名 set default 默认值;		// 给字段设置默认值
alter table t_name alter column 字段名 drop default;		// 删除默认值
```

### 增删改查

```java
insert into t_name (字段1,字段2,...) values(值1,值2,...);		// 表中插入数据
update t_name set 字段名=值 where 条件;		// 修改表中数据
delete from t_name where 条件；		// 删除表中某行数据
delete from t_name;		// 清空表中数据
select * from t_name；		// 查询
```

### 用户

```java
\du		// 显示所有用户
\c		// 显示当前用户
\c db_name user_name;		// 更改用户连接

create user user_name with password 'xxx';		// 创建用户
drop user user_name;		// 删除用户
alter user user_name with password 'yyy';		// 更改密码

```

## 常用数据类型

### 字符类型

```java
varchar(n)	// 变长，有长度限制
char(n)		// 定长,不足补空白
text		// 变长，无长度限制
```

### 数值类型

```java
integer/int/int4	// 存储整数 4字节 -2147483648至+2147483647
smallint/int2		// 小范围整数  -32768到+32767
bigint/int8			// 存储整数,大范围 8字节 -9223372036854775808至9223372036854775807
  
real/float4	    // 单精度浮点数 4byte 7位小数,第七位是四舍五入上来的
double precision/float8		// 双精度浮点数 8byte

serial/serial4		// 自动递增整数 4字节 1至2147483647
smallserial/serial2 // 自动递增整数 2字节
bigserial/serial8	// 大的自动递增整数 8byte 1 到 9223372036854775807

numeric[(p,s)]   // 可指定精确精度 共p位 .后s位 小数点前最多为131072个数字; 小数点后最多为16383个数字。
    
```

### 日期类型

```java
date			  // 只用于日期
time			  // 只用于一天内时间
interval		  // 时间间隔
timestamp[无时区]	// 包含日期和时间
timestamp[含时区]	// 包含日期和时间，带时区
```

### 布尔类型

```java
boolean 	// 它指定true或false的状态。1字节
```

### 货币类型

```java
money  // 货币金额 8字节 -92233720368547758.08至+92233720368547758.07
```

### 特色类型

```
Array型
网络地址型(inet)
json型
xml型
```

## 约束条件

```java
not null	// 不为空
unique		// 唯一
default		// 设置默认值
check		// 字段设置条件
primary key // 主键，不为空且不重复 not null,unique
    
content text check(length(content>8)) //content字段内容长度要大于8
```

## 常用函数