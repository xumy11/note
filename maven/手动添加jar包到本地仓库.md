# 手动添加jar包到本地仓库

mvn install:install-file -Dfile=F:\work\my_java\maven\maven_repository\ojdbc14.jar -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=11.2.0.1.0 -Dpackaging=jar -DgeneratePom=true



install:可以将项目本身编译并打包到本地仓库 

install-file:安装文件 

-Dfile=D:\ojdbc6.jar : 指定要打的包的文件位置 

-DgroupId=com.oracle : 指定当前包的groupId为com.oracle 

-DartifactId=ojdbc6 : 指定当前的artifactfactId为ojdbc6 

-Dversion=11.2.0.3 : 指定当前包的版本为11.2.0.3 

-DgeneratePom=true:是否生成pom文件