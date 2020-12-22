下载node.js

node -v / npm -v		// 测试是否安装成功

npm install vue-cli -g		// 安装全局 vue-cli   测试 vue --version

vue init webpack name		// 初始化vue项目

```
1.  ？Project name vue-playlist               //项目名称，如果想修改可以直接修改，不想修改是直接回车
		2.  ？Project description        Vue基础知识    //项目描述
		3.  ？Author                                 //作者，如果不修改可直接回车
		4.  ？Vue build                              //直接回车
		5.  ？Install vue-router?                    //是否安装路由，暂时不安输入No
		6.  ？Use ESLint to lint your code?          //是否安装ESLint 测试 ，输入No 不需要装严格的测试
		7.  ？Set up unit tests(Y/n)                 //unit测试也不需要装输入 No
		8.  ？Setup e2e tests with Nightwatch?       //输入No e2e测试也不需要装
		9.  ？Should we run npm install for you after the project has been created?	    //在项目创建之后，我们是否应该为您运行NPM安装？
				下面三个选项，使用键盘选择YES NPM  安装
		10. 安装完毕后通过CMD方式进入项目中的vue-playlist文件夹中，执行npm run dev 屏幕会出现：
			Your application is running here :  http://localhost:8080    //npm 会给我们启动一个WEB服务，在浏览器中进行浏览，能看到VUE界面  Welcome to Your Vue.js App
			
```

npm install vue-router --save-dev		// 添加路由模块

npm install vue-resource --save-dev		// 提交ajax





npm config set registry		// 更换npm 仓库

npm install		// 为vue项目安装依赖

npm run dev		// 启动项目

npm run build		// 打包vue项目

## 目录/文件

```
build	               项目构建(webpack)相关代码
config	               配置目录，包括端口号等。我们初学可以使用默认的。
node_modules	       npm 加载的项目依赖模块
src	              这里是我们要开发的目录，基本上要做的事情都在这个目录里。里面包含了几个目录及文件：
assets: 放置一些图片，如logo等。
components: 目录里面放了一个组件文件，可以不用。
App.vue: 项目入口文件，我们也可以直接将组件写这里，而不使用 components 目录。
main.js: 项目的核心文件。



static	静态资源目录，如图片、字体等。
test	初始测试目录，可删除
.xxxx文件	这些是一些配置文件，包括语法配置，git配置等。
index.html	首页入口文件，你可以添加一些 meta 信息或统计代码啥的。
package.json	项目配置文件。
README.md	项目的说明文档，markdown 格式


1) vue-playlist/src/assets     //存放图片文件
2) vue-playlist/src/components  //存放相应组件
3) vue-playlist/src/App.vue   //根组件
4) vue-playlist/index.html    //入口文件
5) vue-playlist/src/main.js   //入口文件中引用的就是这个JS文件，index.html执行完毕后就会执行这个main.js文件
                              //main.js 中的 import Vue from 'vue' 表示通过NPM下载的模块直接可以
                                拿过来使用，
                              //在下面就可以直接通过 new的方式  new Vue{} 使用，
                              //el:获取的元素，对应index.html中的<div id="app"></div>
                              //template: 模板。给以赋予一个组件调用的标签
                              //components: 组件。通过此属性来注册一个组件。样例中的{ App }组件来源
                                于上面第4行的  import App from './App'
                             
6) 最终执行顺序 index.html -> main.js -> App.vue  //App.vue 组件中包涵三个内容，具体请看 App.vue里面的注释

```



## 解决删除node_modules慢

npm install rimraf -g

然后使用删除命令

rimraf node_modules

