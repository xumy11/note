1.起别名的时候 要用 "" , 使用单引号会报错；

2.插入数据时 字符串要用  ' ' , 双引号会报错；

3.自增长字段 要设置 serial ，后更改为serial类型会报错 因为serial不是真实的类型

4.PostgreSQL表名、字段名、别名等大小敏感，默认都会转化成小写形式。如果名字中有大写字母，必须分别添加双引号。在写后台时，注意添加 \

```sql
如表名：TestTable中有个字段名userName
写sql查询时： select "TestTable"."userName" from "TestTable";
后台拼装sql语句时: String sql = "select \"TestTable\".\"userName\" from \"TestTable\"";
```