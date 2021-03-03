# 常用sql语句

## 创建表空间

```sql
create tablespace oratest  -- 创建名为oratest的表空间 
datafile 'c:\oratest.dbf'  -- 数据文件位置
size 100m   -- 表空间100m
autoextend on  -- 开启自动拓展
next 10m;   -- 每次拓展10m
```

## 删除表空间

```sql
drop tablespace oratest;
```

## 创建用户

```sql
create user xumy  -- 创建xumy用户
identified by xumy  -- 密码设置为xumy
default tablespace oratest;  -- 用户出生的表空间
```

## 给用户授权

oracle数据库常用角色；

connect：连接角色，基本角色；

resource：开发者角色；

dba：超级管理员角色；

```sql
grant dba to xumy  -- 给xumy用户授权dba角色权限
```

**切换用户：重新登入 选择用户**

## Oracle数据类型

| 数据类型          | 描述                                                         |
| ----------------- | ------------------------------------------------------------ |
| varchar，varchar2 | 表示一个字符串 varchar2为可变长度字符串                      |
| NUMBER            | NUMBER(n) 一个整数长度为n; <br />NUMBER(m,n) 一个小数总长m，小数部分长n。 |
| DATA              | 日期类型                                                     |
| CLOB              | 大对象，表示大文本数据类型，可存4G                           |
| BLOB              | 大对象，表示二进制数据，可存4G                               |

## 创建表

```sql
create table person(
	pid number(20),
    pname varchar2(10)
);
```

## 修改表结构

### 添加一列

```sql
alter table person add (gender number(1));
```

### 修改列类型

```sql
alter table person modify gender char(1);  -- 将person表中gender列改为char类型
```

### 修改列名称

```sql
alter table person rename column gender to sex;
```

### 删除一行

```sql
alter table person drop column sex;
```

## 增删改查

### 添加一条记录

```sql
insert into person(pid,pname) values(1,'小明');
commit;  -- 提交事务
```

### 删除表中全部记录

```sql
delete from person;
```

### 删除表结构

```sql
drop table person;
```

### 先删除表，再次创建表。效果等同于删除表中全部记录。

```sql
truncate table person;
```

在数据量大的情况下，尤其是表中有**索引**的情况下，此方法**效率高**。

------

索引可以提供查询效率，但是会影响增删改效率。

### 修改一条记录

```sql
update person set pname = '小王' where pid = 1;
```

### 查询表中结构

```sql
select * from person;
```

## 序列：sequence

序列不属于任何一张表，但可以逻辑和表做绑定，默认从1开始，依次递增，主要用来给主键赋值使用。

```sql
create sequence s_person;
```

```sql
select s_person.nextval from dual;
```

.nextval  ：用来获取序列号的下一个squence的值。

dual 虚表：只是为了补全语法，没有任何意义。

### 添加一条记录

```sql
insert into person(pid,pname) values(s_person.nextval,'小小');
commit;
```

## scott 用户

演示用户，密码tiger

```sql
alter user scott account unlock;  -- 解锁scott用户
alter user scott identified by tiger;  -- 解锁/重置密码
```

## 单行函数

作用于一行，返回一个值。

### 字符函数

```sql
select upper('yes') from dual;  -- YES
select lower('YES') from dual;  -- yes
```

### 数值函数

```sql
select round(54.16,-1) from dual;  -- 四舍五入，保留n位，负数为保留到“.”前n位 如 50
select trunc(56.16,-1) from dual;  -- 直接截取，不考虑后面四舍五入
select mod(10,3) from dual;  -- 取余数
```

### 日期函数

```sql
select sysdate+1 from dual;  -- 算出明天此刻
```

```sql
---- 查询出emp表中所有员工入职到现在多少天
select sysdate-e.hiredate from emp e;
---- 查询出emp表中所有员工入职距离现在几月。
select months_between(sysdate,e.hiredate) from emp e;
----查询出emp表中所有员工入职距离现在几年。
select months_between(sysdate,e.hiredate)/12 from emp e;
----查询出emp表中所有员工入职距离现在几周。round(m,n) 四舍五入
select round((sysdate-e.hiredate)/7) from emp e;
```

### 转换函数



```sql
---- 日期转字符串 fm：2019-06-07不要0  hh24：24小时制
select to_char(sysdate,'fm yyyy-mm-dd hh24:mi:ss') from dual;
---字符串转日期
select to_date('2019-6-7 16:39:50','fm yyyy-mm-dd hh24:mi:ss') from dual;
```

### 通用函数

```sql
---- 算出emp表中所有员工的年薪(sal月薪字段，comm年奖金字段 存在null)
---- 奖金里面有null值，如果null值和任意数字做算术运算，结果都是null。
select e.sal*12+nvl(e.comm,0) from emp e;
```

### 条件表达式

条件表达式的通用写法，mysql和Oracle通用

```sql
----给emp表中员工起中文名字
select e.name,
	case e.name
		when 'xiaowang' then '小王'
		  when 'xiaoming' then '小明'
		    else '无名'
		      end
from emp e;
```

判断emp表中员工工资，如果高于3000显示高收入，如果高于1500低于3000显示中等收入，其余显示低收入

```sql
select e.sal, 
       case 
         when e.sal>3000 then '高收入'
           when e.sal>1500 then '中等收入'
               else '低收入'
                 end
from emp e;
```

oracle专用条件表达式（一般不使用）

oracle中除了起别名，都用单引号。

```sql
select e.ename, 
        decode(e.ename,
          'SMITH',  '曹贼',
            'ALLEN',  '大耳贼',
              'WARD',  '诸葛小儿',
                '无名') "中文名"             
from emp e;
```

## 多行函数/聚合函数

作用于多行，返回一个值。

```sql
select count(1) from emp;  -- 查询总数量
select sum(sal) from emp;  -- 工资总和
select max(sal) from emp;  -- 最大工资
select min(sal) from emp;  -- 最低工资
select avg(sal) from emp;  -- 平均工资
```

## 分组查询

分组查询中，出现在group by后面的原始列，才能出现在select后面，没有出现在group by后面的列，想在select后面，必须加上聚合函数。聚合函数有一个特性，可以把多行记录变成一个值。

```sql
---- 查询出每个部门的平均工资
select 
from emp e

```

