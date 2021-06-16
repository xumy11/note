# Docker

## Linux下Docker的安装与卸载

### 安装

```java
//卸载已安装Docker组件
yum remove -y docker-ce \
			  docker-client \
			  docker-client-latest \
			  docker-common \
			  docker-latest \
			  docker-latest-logrotate \
			  docker-logrotate \
			  docker-engine 
			  
// 安装yum软件包
yum install -y yum-utils

//设置阿里云镜像仓库
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

//更新软件包索引
yum makecache fast
    
//安装Docker CE  CE:社区版 EE：企业版
yum install docker-ce docker-ce-cli containerd.io
    
    
//启动Docker
systemctl start docker
//查看Docker版本
docker version
```

### 卸载

```java
// 卸载依赖
yum remove docker-re docker-ce-cli containerdio
// 删除资源
rm -rf /var/lib/docker   // docker默认工作路径
```

## Docker设置

![image-20210602141057099](F:\note\图片\image-20210602141057099.png)

### DockerEngine配置

```xml
{
  "registry-mirrors": [],
  "insecure-registries": [
    "10.10.30.166",
    "10.127.16.11",
    "cr.registry.res.jxwatercloud.com",
    "registry.acs.ops.jxwatercloud.com"
  ],
  "debug": true,
  "experimental": false,
  "builder": {
    "gc": {
      "enabled": true,
      "defaultKeepStorage": "20GB"
    }
  }
}
```

### pom.xml配置

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <artifactId>main-parent</artifactId>
        <groupId>com.emrubik.wbmp</groupId>
        <version>1.0.0</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <artifactId>wbmp-portal</artifactId>
    <packaging>war</packaging>


    <!-- 配置项 -->
    <properties>
        <!-- 依赖版本定义 -->
        <oak.dependecies.version>0.4.0-SNAPSHOT</oak.dependecies.version>
        <!-- 依赖版本定义 -->
    </properties>
    <!-- 配置项 -->
    <profiles>
        <profile>
            <id>dev_cq</id>
            <!-- 默认激活开发配制，使用dev.properties来替换设置过虑的资源文件中的${key} -->
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <build>
                <filters>
                    <filter>build/config/dev_cq.properties</filter>
                </filters>
                <resources>
                    <resource>
                        <directory>src/main/java</directory>
                        <includes>
                            <include>**/*.xml</include>
                        </includes>
                    </resource>
                    <resource>
                        <directory>src/main/resources</directory>
                        <includes>
                            <include>**/*.txt</include>
                            <include>**/*.xml</include>
                            <include>**/*.vm</include>
                            <include>**/*.properties</include>
                            <include>i18n/**/*.*</include>
                        </includes>
                        <filtering>true</filtering>
                    </resource>
                </resources>
                <plugins>
                    <plugin>
                        <artifactId>maven-compiler-plugin</artifactId>
                        <configuration>
                            <source>1.8</source>
                            <target>1.8</target>
                            <encoding>utf-8</encoding>
                        </configuration>
                    </plugin>
                    <plugin>
                        <artifactId>maven-war-plugin</artifactId>
                        <version>2.2</version>
                        <configuration>
                            <warName>wbmp-portal</warName>
                            <failOnMissingWebXml>false</failOnMissingWebXml>
                        </configuration>
                    </plugin>
                    <!-- Docker配置 -->
                    <plugin>
                        <artifactId>maven-resources-plugin</artifactId>
                        <executions>
                            <execution>
                                <id>copy-resources</id>
                                <phase>validate</phase>
                                <goals>
                                    <goal>copy-resources</goal>
                                </goals>
                                <configuration>
                                    <outputDirectory>${basedir}/target/</outputDirectory>
                                    <resources>
                                        <resource>
                                            <directory>./dockerweb</directory>
                                            <filtering>true</filtering>
                                        </resource>
                                    </resources>
                                </configuration>
                            </execution>
                            <execution>
                                <id>copy-k8src</id>
                                <phase>validate</phase>
                                <goals>
                                    <goal>copy-resources</goal>
                                </goals>
                                <configuration>
                                    <outputDirectory>${basedir}/../deploy/k8s/${project.artifactId}</outputDirectory>
                                    <resources>
                                        <resource>
                                            <directory>../k8s/web</directory>
                                            <filtering>true</filtering>
                                        </resource>
                                    </resources>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                    <plugin>
                        <groupId>com.spotify</groupId>
                        <artifactId>docker-maven-plugin</artifactId>
                        <version>0.4.11</version>
                        <executions>
                            <execution>
                                <id>build-image</id>
                                <phase>install</phase>
                                <goals>
                                    <goal>build</goal>
                                </goals>
                                <configuration>
                                    <dockerDirectory>${project.build.directory}</dockerDirectory>
                                    <imageName>${docker.registry.test}/${project.artifactId}:${tag}</imageName>
                                    <buildArgs>
                                        <C_DIR>${project.build.finalName}</C_DIR>
                                        <C_WEBDIR>wbmp-portal</C_WEBDIR>
                                    </buildArgs>
                                </configuration>
                            </execution>
                            <!--<execution>
                                <id>push-image</id>
                                <phase>deploy</phase>
                                <goals>
                                    <goal>push</goal>
                                </goals>
                                <configuration>
                                    <serverId>docker-harbor</serverId>
                                    <imageName>${docker.registry.test}/${project.artifactId}:${tag}</imageName>
                                </configuration>
                            </execution>-->
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
    </profiles>


    <dependencies>
        <!-- 依赖项定义 -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
        </dependency>
        <!-- SPRING end -->


        <!-- WEB begin -->
        <dependency>
            <groupId>taglibs</groupId>
            <artifactId>standard</artifactId>
            <version>1.1.2</version>
            <type>jar</type>
        </dependency>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jstl</artifactId>
            <version>1.2</version>
            <type>jar</type>
        </dependency>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>servlet-api</artifactId>
            <version>2.5</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>jsp-api</artifactId>
            <version>2.1</version>
            <scope>provided</scope>
        </dependency>
        <!-- WEB end -->

        <!-- SECURITY begin -->
        <dependency>
            <groupId>org.apache.shiro</groupId>
            <artifactId>shiro-spring</artifactId>
        </dependency>
        <dependency>
            <groupId>org.apache.shiro</groupId>
            <artifactId>shiro-ehcache</artifactId>
        </dependency>
        <!-- SECURITY end -->


        <!-- LOGGING begin -->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
        </dependency>
        <dependency>
            <groupId>org.apache.velocity</groupId>
            <artifactId>velocity</artifactId>
            <version>1.7</version>
        </dependency>
        <!-- 打镜像后启动报错，与log4j冲突，因此去掉 -->
        <!--<dependency>-->
        <!--<groupId>org.slf4j</groupId>-->
        <!--<artifactId>slf4j-log4j12</artifactId>-->
        <!--</dependency>-->
        <!-- common-logging 实际调用slf4j -->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>jcl-over-slf4j</artifactId>
        </dependency>
        <!-- java.util.logging 实际调用slf4j -->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>jul-to-slf4j</artifactId>
        </dependency>
        <!-- LOGGING end -->

        <!--一系列工具类 -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-io</groupId>
            <artifactId>commons-io</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-fileupload</groupId>
            <artifactId>commons-fileupload</artifactId>
        </dependency>

        <!-- google java lib -->
        <dependency>
            <groupId>com.google.guava</groupId>
            <artifactId>guava</artifactId>
        </dependency>
        <!-- https://mvnrepository.com/artifact/com.google.code.gson/gson -->
        <dependency>
            <groupId>com.google.code.gson</groupId>
            <artifactId>gson</artifactId>
            <version>2.8.2</version>
        </dependency>
        <!-- jackson json -->
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
        </dependency>

        <!-- email -->
        <dependency>
            <groupId>javax.mail</groupId>
            <artifactId>mail</artifactId>
            <version>1.4.7</version>
        </dependency>
        <dependency>
            <groupId>javax.activation</groupId>
            <artifactId>activation</artifactId>
            <version>1.1.1</version>
        </dependency>

        <!-- 登录验证码 -->
        <dependency>
            <groupId>com.github.penggle</groupId>
            <artifactId>kaptcha</artifactId>
            <version>2.3.2</version>
        </dependency>

        <!-- idm -->
        <dependency>
            <groupId>com.emrubik.oak</groupId>
            <artifactId>oak-domain</artifactId>
        </dependency>
        <dependency>
            <groupId>com.emrubik.oak</groupId>
            <artifactId>oak-common</artifactId>
        </dependency>
        <dependency>
            <groupId>com.emrubik.oak</groupId>
            <artifactId>oak-rest-client</artifactId>
        </dependency>
        <dependency>
            <groupId>com.emrubik.oak</groupId>
            <artifactId>oak-security</artifactId>
        </dependency>
        <dependency>
            <groupId>com.emrubik.idm</groupId>
            <artifactId>uc-domain</artifactId>
        </dependency>


        <!-- HTTP CLIENT 用来支持透传 -->
        <dependency>
            <groupId>commons-httpclient</groupId>
            <artifactId>commons-httpclient</artifactId>
            <version>3.0.1</version>
        </dependency>

        <!-- easypoi -->
        <dependency>
            <groupId>org.jeecg</groupId>
            <artifactId>easypoi-web</artifactId>
            <version>2.3.1</version>
        </dependency>
        <dependency>
            <groupId>org.jeecg</groupId>
            <artifactId>easypoi-annotation</artifactId>
            <version>2.3.1</version>
        </dependency>
        <!-- easypoi -->

        <dependency>
            <groupId>net.bull.javamelody</groupId>
            <artifactId>javamelody-core</artifactId>
            <version>1.71.0</version>
        </dependency>
        <!--        <dependency>
                    <groupId>org.springframework.cloud</groupId>
                    <artifactId>spring-cloud-netflix-core</artifactId>
                    <version>1.1.7.RELEASE</version>
                </dependency>
                <dependency>
                    <groupId>com.netflix.feign</groupId>
                    <artifactId>feign-core</artifactId>
                    <version>8.16.2</version>
                </dependency>-->
        <dependency>
            <groupId>com.emrubik.wbmp</groupId>
            <artifactId>wbmp-api-sdk</artifactId>
            <version>${project.version}</version>
            <exclusions>
                <exclusion>
                    <groupId>com.emrubik.oak.microsvr</groupId>
                    <artifactId>oak-msvr-apidoc-starter</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency>
            <groupId>javax.validation</groupId>
            <artifactId>validation-api</artifactId>
            <version>2.0.0.Final</version>
        </dependency>

        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>fastjson</artifactId>
            <version>1.2.69</version>
        </dependency>

        <dependency>
            <groupId>com.emrubik.oak</groupId>
            <artifactId>oak-sso-client</artifactId>
            <version>0.2.0-SNAPSHOT</version>
        </dependency>

    </dependencies>


</project>

```

### DockerFile配置

```java
FROM 10.10.30.166/public/tomcat:8-gzip-1.0.4
ARG C_DIR
ARG C_WEBDIR
ADD $C_DIR /usr/local/tomcat/webapps/$C_WEBDIR
ENV TZ Asia/Shanghai
ENV LANG C.UTF-8
ENV XMS 512m
ENV XMX 512m
ENV JAVA_OPTS='-Xms$XMS -Xmx$XMX -XX:PermSize=128m  -XX:MaxPermSize=256m -Djava.awt.headless=true'
ENTRYPOINT /usr/local/tomcat/bin/catalina.sh run && tail -F /usr/local/tomcat/logs/catalina.out
WORKDIR /usr/local/tomcat/webapps

```

## Docker命令

```java
// 基本命令
docker version	// 查看docker版本
docker info		// 查看docker详细信息
docker --help	// 查看docker命令

// 镜像命令
docker images	// 查看docker镜像
docker images -a	// 列出本地所有的镜像
docker images -p	// 只显示镜像ID
docker images --digests		// 显示镜像的摘要信息
docker images --no-trunc	// 显示完整的镜像信息
    
docker search tomcat	// 从dockerHub上查找tomcat镜像
    
// 容器命令
docker run [OPTIONS] [IMAGE]	// 根据镜像新建并启动容器
  // OPTIONS说明：  
  //   --name=“容器新名字”：为容器指定一个名称
  //   -d：后台运行容器，并返回容器ID，也即启动守护式容器
  //   -i：以交互模式运行容器，通常与-t同时使用
  //   -t：为容器重新分配一个伪输入终端，通常与-i同时使用
  //   -P：随机端口映射
  //   -p：指定端口映射，有以下四种格式：
  //     ip:hostPort:containerPort
  //     ip::containerPort
  //     hostPort:containerPort
  //     containerPort
docker ps		// 列出当前所有正在运行的容器
docker ps -a 	// 列出所有的容器
docker ps -l	// 列出最近创建的容器
docker ps -n 3	// 列出最近创建的3个容器
docker ps -q	// 只显示容器ID
docker ps --no-trunc	// 显示当前所有正在运行的容器完整信息
exit		// 退出并停止容器
Ctrl+p+q	// 只退出容器，不停止容器
docker start [容器]	// 启动容器
docker restart [容器]	// 重启容器
docker stop	[容器]	// 停止容器
docker kill [容器]	// 强制停止容器
docker rm [容器]		// 删除容器
docker rm -f [容器]	// 强制删除容器
docker rm -f $(docker ps -a -q)		// 删除多个容器
docker logs -f -t --since='2018-09-10' --tail=10 f9e29e8455a5
  // -f : 查看实时日志
  // -t : 查看日志产生的日期
  // --since : 此参数指定了输出日志开始日期，即只输出指定日期之后的日志
  // --tail=10 : 查看最后的10条日志
docker top [容器]		// 查看容器内运行的进程
docker inspect [容器]	// 查看容器内部细节
docker attach [容器]	// 进到容器内
docker exec [容器]	// 进到容器内
docker cp 容器ID:容器内的文件路径 宿主机路径	// 从容器内拷贝文件到宿主机 例：docker cp f9e29e8455a5:/tmp/yum.log /root
```

### 上传docker镜像 

```java
// 上传docker镜像 

docker login --username=admin 10.127.16.91
 
docker push 10.127.16.91/new_water/dms-portal:1.0.0
```

### 删除镜像

```java
docker images	// 查看docker镜像
docker rmi [镜像Id]	// 删除指定镜像
```

