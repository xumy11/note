## SpringMVC核心组件

DispatcherServlet	前端控制器

Handler	处理器 完成具体业务逻辑

HandlerMapping	将请求映射到Handler

HandlerInterceptor	处理器拦截器

HandlerExecutionChain	处理器执行链

HandlerAdapter	处理器适配器

ModleAndView	装载模型数据和视图信息

ViewResolver	视图解析器

## SpringMVC实现流程

客户端请求被DispatcherServlet接收

DispatcherServlet将请求映射到Handler

生成Handler以及HandlerInterceptor

返回HandlerExecutorChain（Handler+HandlerInterceptor）

DispatcherServlet通过HandlerAdapter执行Handler

返回一个ModelAndView

DispatcherServlet通过ViewResolver进行解析

返回填充了模型数据的View，响应给客户端



### web.xml：

```xml
<servlet>
    <servlet-name>SpringMVC</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <!--配置springmvc.xml的路径-->
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath*:springmvc.xml</param-value>
    </init-param>
</servlet>

<servlet-mapping>
    <servlet-name>SpringMVC</servlet-name>
    <!--拦截所有请求-->
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

### springmvc.xml

```xml
<!--配置HandlerMapping，将url请求映射到Handler-->
<bean id="handlerMapping" class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <!--配置mapping-->
    <property name="mapping">
        <props>
            <!--配置xxx请求对应的handler-->
            <prop key="/xxx">xxxHandler</prop>
        </props>
    </property>
</bean>

<!--配置Handler-->
<bean id="xxxHandler" class=" xxx.xxxHandler"></bean>

<!--配置视图解析器-->
<bean class="org.springframework.web.servlet.view.InternalResourceViewResplver">
    <!--配置前缀-->
    <property name="prefix" value="/"></property>
    <!--配置后缀-->
    <property name="suffix" value=".jsp"></property>
</bean>
```

### 注解

springmv.xml

```xml
<!--开启注解扫描-->
<context:component-scan base-package="要扫描的包路径"></context:component-scan>
```

@Controller

@RequestMapping("/xxx")