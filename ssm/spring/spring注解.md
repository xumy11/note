@Component		描述Spring框架中Bean

@Repository		用于对DAO实现类进行标注

@Service		用于对Service实现类进行标注

@Controller		用于对Controller实现类进行标注





@Autowried		默认按照类型进行注入（若存在两个相同Bean类型，则按照名称注入）**@Autowried注入时可以针对成员变量或者set方法**

通过@Autowried的required属性，一定要找到匹配的Bean

使用@Qualifier指定注入Bean的名称

使用@Qualifier指定Bean名称后，注解Bean必须指定相同的名称

Spring中初始化bean和销毁bean（bean的两个生命周期）

```xml 
<bean id= "xxx" class= "....Class"
      init-method= "init"
      destroy-method= "destroy" />	
		--destroy要在scope=singleton下才有效（单例模式）
```

@PostConstruct		初始化

@PreDestroy		销毁