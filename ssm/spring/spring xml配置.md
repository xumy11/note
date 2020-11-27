# spring约束

```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    //上面两个是基础IOC的约束，必备
    xmlns:context="http://www.springframework.org/schema/context"
    //上面一个是开启注解管理Bean对象的约束
    xmlns:aop="http://www.springframework.org/schema/aop"
    //aop的注解约束
    xmlns:tx="http://www.springframework.org/schema/tx"
    //事务的约束
    xsi:schemaLocation="http://www.springframework.org/schema/beans 
    http://www.springframework.org/schema/beans/spring-beans.xsd
    //上面两个是基础IOC的约束，必备
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context.xsd
    //上面一个是开启注解管理Bean对象的约束
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop.xsd
    //aop的注解约束
    http://www.springframework.org/schema/tx
    http://www.springframework.org/schema/tx/spring-tx.xsd">
    //事务的约束
</beans>
```

# spring配置

```xml
<!--开启注解扫描 （包含开启属性注入注解）-->
<context:component-scan base-package="xx.xx.要扫描的包"/>

<!--开启属性注入注解  @Autowried()  @Resource(name="")-->
<context:annotation-config/>


<!--将类交给spring容器管理-->
<bean id="name" classs="class路径">
	<property name="xxx" ref="xxx"/>
</bean>

<bean id="xxx" classs="xxx的路径"/>
```

