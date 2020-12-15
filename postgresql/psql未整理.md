# 视图 View

视图(view)是从一个或多个表导出的对象。视图与表不同，视图是一个虚表，即视图所对应的数据不进行实际存储，数据库中只存储视图的定义，在对视图的数据进行操作时，系统根据视图的定义去操作与视图相关联的基本表。

* **视图就是一个select语句，把经常要用到的select语句简化成一个类似表的对象，方便读取和开发。**

```sql
-- 创建视图
create view view_name as select s.name, t.name from student as "s", teacher as "t" where s.id=t.id and s.id=1;
-- 使用视图
select * from view_name;
-- 删除视图
drop view view_name;

* 对于经常需要查询的语句，可以提前建立视图view，方便编码和管理。
```

# 事务

原子性、一致性、隔离性、持久性

**begin**

**commit**

**rollback**

```sql
-- 提交
select * from student;
begin;
update student set score = 60 where name = 'xiaoming';
update student set score = 70 where name = 'xiaohong';
commit;

-- 回滚
select * from student;
begin;
update student set score = 20 where name = 'xiaoming';
update student set score = 30 where name = 'xiaohong';
rollback;
```

