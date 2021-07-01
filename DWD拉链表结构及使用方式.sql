错误的拉链（时间段重叠）
s-------e
     s---------e

1.原始表中是逻辑删除(is_valid)                    s_stat
s------e                                          0
       s-----------e                              0
                   s-----------------------2099   1
                   
2.原始表中是物理删除
s------e
       s-----------e
                   s-e
                 3-7 3-8
                     s--------------e(不存在)


--A.时间点不选（即：查最新）
SELECT org.*
  FROM dwd.dim_201_org_5mmf org
 WHERE is_valid = '1'
   AND s_stat = '1';


--B.时间点选择历史时间点（例如：20210228）
SELECT org.*
  FROM dwd.dim_201_org_5mmf org
 WHERE is_valid = '1'
   AND s_start_time <= '20210228' AND '20210228' < s_end_time

--C.时间段选择20210201到20210228
--1.逻辑删除的维度表，查询某个时间段内生效的数据
SELECT org.* FROM (
SELECT ROW_NUMBER() OVER(PATITION BY s_key ORDER BY s_end_time DESC) rn,* 
  FROM dwd.dim_201_org_5mmf
 WHERE is_valid = '1'
   --该字段为原始数据库中的逻辑删除字段(1有效 0无效)
   AND(
        (s_start_time <= '20210201' AND '20210201' < s_end_time)
      OR(s_start_time <= '20210228' AND '20210228' < s_end_time)
      OR('20210201' <= s_start_time AND s_end_time <= '20210228')
   )
) org
WHERE org.rn = 1;

--2.物理删除的维度表，查询某个时间段内生效的数据
SELECT org.* FROM (
SELECT ROW_NUMBER() OVER(PATITION BY s_key ORDER BY s_end_time DESC) rn,* 
  FROM dwd.dim_201_org_5mmf
 WHERE (s_start_time <= '20210201' AND '20210201' < s_end_time)
      OR(s_start_time <= '20210228' AND '20210228' < s_end_time)
      OR('20210201' <= s_start_time AND s_end_time <= '20210228')
) org
WHERE org.rn = 1;

--字典表都是物理删除