# ssm框架常用注解

**一.mybatis**



 1 配置一对多查询和多对多查询的注解方式映射关系：

 @Results：声明映射关系的配置  Value属性接收 @Result的数组

 @Result：配置映射关系 

  Property属性对象中的属性名

  Column属性查询的字段名



**二.spring**



2 创建当前对象交给spring容器管理的注解

@Component(value="id标识")

@Controller(value="id标识")  web层

@Service(value="id标识")   service层

@Repository(value="id标识")  dao层



说明：需要配置到类上 Value属性指定唯一标识

3 属性依赖注入的注解

@Resource   默认按照名称注入

@Autowired  只按照类型注入

@Qualifier(value="id标识") Value属性可以按照id唯一标识注入

@Value

说明：注入基本数据类型数据 也可以注入被spring容器管理的properties文件中的内容



4 生命周期相关的注解

@Scope 

说明：对象的作用 Value属性（singleton|prototype）

@PostConstruct 

说明：配置到方法上 用来配置初始化方法

@PreDestory

说明：配置到方法上 用来配置销毁方法





5 使用配置类替换xml配置文件的注解

@Configuration：声明配置类

@ComponentScan: 开启包扫描

@PropertySource：将properties配置文件交给spring容器管理

@Import：引入其它的配置类

@Bean : 配置到方法上，表明此方法的返回值交给spring容器管理



6 springTest的相关注解

@Runwith(SpringJunit4ClassRunner.class) 声明spring提供的类加载配置文件

@ContextConfiguration 声明spring的配置信息 

Locations属性xml配置文件  Classes属性配置类的字节码



7 AOP相关的注解

@Aspect 声明切面类

@PonitCut 定义公共的切入点  配置到空方法上

value属性切入点表达式  引用：方法名()

配置通知类型：

@Before 前置通知

@AfterReturnint 后置通知

@AfterThrowing  异常通知

@After   最终通知

@Around   环绕通知

@EnableAspectJAutoProxy 开启对AOP注解的支持 用于纯注解使用



8 事务相关的注解

@Transactional 需要事务的类或者方法上使用配置事务

@EnableTransactionManagement 纯注解使用 代表开启对注解事务的支持



**三.springmvc**



@RequestMapping("/user") 做浏览的访问路径和当前方法的映射

9  @RequestHeader 获取到请求头的信息

@CookieValue  获取到cookie的jsessionID

@RequestBody  配置到方法参数上，表明将json字符串转化为java对象

@ResponseBody  配置到方法返回值，表明将对象转化为json字符串

@RequestBody  配置到方法参数，表明将json字符串转化为对象

@SessionAttributes(value = {"username"})  //代表当前类中的所有方法 只要是model对象操作了指定的参数 都会向session域中存一份

@ModelAttribute("aaa") 向Model中添加元素



10 restFul代码编程的要求：



确定地址参数（id）如何设置路径 格式：{id}

确定如何获取到地址参数（id）在方法参数上使用注解：   @PathVariable(value = "id")

指定就对某一种提交方式有效  @RequestMapping(value = "/{idddd}.html",method = RequestMethod.GET)  只对get提交有效