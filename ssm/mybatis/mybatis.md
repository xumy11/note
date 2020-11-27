### foreach   

```xml
<!-- select * from person where id in (1,2,3,4,5)-->
<select id="findById" resultType="person">
    select * from person where id in
	<foreach collection="array"  item="id"  index="i"  open="(" close=")"  separator=",">
	#{id}
	</foreach>
</select>
```

### Mybatis四大核心对象

ParameterHandler	：处理SQL的参数对象

ResultSetHandler	：处理SQL的返回结果集

StatementHandler	：数据库的处理对象 ，用于执行SQL语句

Executor	：Mybatis的执行器，用于执行增删改查操作



Interceptor 接口

```java
/**
* 告诉mybatis插件要拦截哪个对象的哪个方法
*/
@Intercepts({
    @Signature(type = ResultSetHandler.class, // 要拦截的对象
              method = "handlerResultSets", // 拦截对象的方法
              args = Statement.class)  // 方法的参数
})
public class MyInterceptor implements Interceptor{
    // 拦截目标对象的目标方法的
    public Object intercept(Invocation invocation) throws Throwable{
        System.out.println("拦截的目标对象"+invocation.getTarget());
        Object object = invocation.proceed();
        return object;
    }
    // 包装目标对象 为目标对象创建代理对象的
    public Object plugin(Object o);{
        System.out.println("将要包装的目标对象"+o);
    	return Plugin.wrap(o.this);
    }
    
    public void setProperties(Properties properties){
        System.out.println("插件配置的初始化参数"+properties);
    }
}
```

