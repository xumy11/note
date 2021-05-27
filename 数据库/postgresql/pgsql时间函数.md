extract
主要用于从一个日期或时间型的字段内抽取年、月、日、时、分、秒数据，因此，它支持其关健字 YEAR、MONTH、DAY、HOUR、MINUTE、SECOND、WEEKDAY、YEARDAY。
 EXTRACT（关健字 FROM 日期或时间型字段）

例如：我们想从一个入库表(RK)的"入库时间(INTIME)"（此入库时间为 TIMESTAMP 型）字段内提取相应的时间数据。有如下形式：

```sql
SELECT EXTRACT(YEAR FROM INTIME) FROM RK  //从INTIME字段中提取年份

SELECT EXTRACT(MONTH FROM INTIME) FROM RK //从INTIME字段中提取月份

SELECT EXTRACT(DAY FROM INTIME) FROM RK  //从INTIME字段中提取日

SELECT EXTRACT(HOUR FROM INTIME) FROM RK  //从INTIME字段中提取时

SELECT EXTRACT(MINUTE FROM INTIME) FROM RK  //从INTIME字段中提取分

SELECT EXTRACT(SECOND FROM INTIME) FROM RK  //从INTIME字段中提取秒
```

interval



date_part

计算两个日期之间的天数

```sql
SELECT date_part('day',  date_trunc('quarter', TO_DATE( '20200705', 'yyyymmddhhmiss')) + INTERVAL'3month'- date_trunc('quarter',  TO_DATE( '20200705', 'yyyymmddhhmiss')))
```

date_trunc

```sql
date_trunc('year','20210401'::TIMESTAMP)    --2021-01-01 00:00:00
```

