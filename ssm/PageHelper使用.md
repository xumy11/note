# 第一步 导入依赖

```xml
<dependency>
    <groupId>com.github.pagehelper</groupId>
    <artifactId>pagehelper</artifactId>
    <version>5.1.2</version>
</dependency>
```

# 第二步 在spring配置文件中配置

```xml
<!-- 把交给IOC管理 SqlSessionFactory -->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="dataSource" ref="dataSource"/>
        
        
        <!-- 传入PageHelper的插件 -->
        <property name="plugins">
            <array>
                <!-- 传入插件的对象 -->
                <bean class="com.github.pagehelper.PageInterceptor">
                    <property name="properties">
                        <props>
                            <prop key="helperDialect">oracle</prop>
                            <prop key="reasonable">true</prop>
                        </props>
                    </property>
                </bean>
            </array>
       </property>
        
        
        
    </bean>
```

# 第三步 在sq l查询代码执行前，使用page helper来完成分页

```java
// 参数pageNum : n是页码值，参数pageSize : s是每页显示条数
PageHelper.startPage(n, s);
// service 中执行sql查询 的语句（中间不能有其他代码）
return orderDao.findAll();
```

