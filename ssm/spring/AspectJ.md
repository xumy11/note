

# AspectJ不同通知类型

## @Before 

前置通知，相当于BeforeAdvice

可以在方法中传入JoinPoint对象，用来获得切点信息

```java
@Before(value="execution()")
public void before(JoinPoint joinPoint){
	System.out.println("----前置通知----"+joinPoint);
}
```

## @AfterReturning 	

后置通知，相当于AfterReturningAdvice

通过returning属性可以定义方法返回值,作为参数

```java
@AfterReturning (value="execution()", returning="returing")
public void afterReturning (Object returing){
	System.out.println("----后置通知----"+returing);
}
```

## @Around 	

环绕通知，相当于MethodInterceptor

around方法的返回值就是目标代理方法执行返回值

参数为ProceedingJoinPoint可以调用拦截目标方法执行

```java
@Around  (value="execution()")
public Object around(ProceedingJoinPoint joinPoint) throws Throwable{
	System.out.println("----环绕前通知----");
	Object obj = joinPoint.proceed();
	System.out.println("----环绕后通知----");
	return obj;
}
```

重点:如果不调用ProceedingJoinPoint的proceed方法,那么目标方法就被拦截了

## @AfterThrowing 	

异常抛出通知，相当于ThrowAdvice

通过设置throwing属性,可以设置发生异常对象参数

```java
@AfterThrowing (value="execution()",throwing="e")
public void afterThrowing (Throwable e){
	System.out.println("----异常抛出通知----"+e.getMessage());
}
```

## @After 	

最终final通知，无论是否异常，该通知都会执行

## @DeclareParents	 

引介通知，相当于IntroductionInterceptor

## @Pointcut

在每个通知内定义切点,会造成工作量大,不易维护,对于重复的切点,可以使用@Pointcut进行定义

切点方法:	 private void 无参数方法,方法名为切点名

当通知多个切点时,可以使用||进行连接

# 在通知中通过value属性定义切点

```xml
@Before(value="execution()")
```

通过execution函数，可以定义切点的方法切入

语法：  execution(<访问修饰符>?<返回类型><方法名>(<参数>)<异常>)

例：

```java
execution(public * *(..))	//匹配所有类public方法
execution(* com.imooc.dao.*(..))  //匹配指定包下所有类方法 不包含子包
execution(* com.imooc.dao..*(..))   //..* 表示包、子孙包下所有类

execution(* com.imooc.service.UserService.*(..))  //匹配指定类所有方法

execution(* com.imooc.dao.GenericDAO+.*(..))  //匹配实现特定接口所有类方法

execution(* save*(..))  //匹配所有save开头的方法
```

# Aspectj使用XML的配置方式完成AOP的开发

```xml
 <!--XML的配置方式完成AOP的开发===============-->
    <!--配置目标类=================-->
    <bean id="customerDao" class="com.imooc.aspectJ.demo2.CustomerDaoImpl"/>

    <!--配置切面类-->
    <bean id="myAspectXml" class="com.imooc.aspectJ.demo2.MyAspectXml"/>

    <!--aop的相关配置=================-->
    <aop:config>
        <!--配置切入点-->
        <aop:pointcut id="pointcut1" expression="execution(* com.imooc.aspectJ.demo2.CustomerDao.save(..))"/>
        <aop:pointcut id="pointcut2" expression="execution(* com.imooc.aspectJ.demo2.CustomerDao.update(..))"/>
        <aop:pointcut id="pointcut3" expression="execution(* com.imooc.aspectJ.demo2.CustomerDao.delete(..))"/>
        <aop:pointcut id="pointcut4" expression="execution(* com.imooc.aspectJ.demo2.CustomerDao.findOne(..))"/>
        <aop:pointcut id="pointcut5" expression="execution(* com.imooc.aspectJ.demo2.CustomerDao.findAll(..))"/>
        <!--配置AOP的切面-->
        <aop:aspect ref="myAspectXml">
            <!--配置前置通知-->
            <aop:before method="before" pointcut-ref="pointcut1"/>
            <!--配置后置通知-->
            <aop:after-returning method="afterReturing" pointcut-ref="pointcut2" returning="result"/>
            <!--配置环绕通知-->
            <aop:around method="around" pointcut-ref="pointcut3"/>
            <!--配置异常抛出通知-->
            <aop:after-throwing method="afterThrowing" pointcut-ref="pointcut4" throwing="e"/>
            <!--配置最终通知-->
            <aop:after method="after" pointcut-ref="pointcut5"/>
        </aop:aspect>

    </aop:config>
```



