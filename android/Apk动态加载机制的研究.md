## Apk动态加载机制的研究
未安装的Apk是不能直接访问的,但是可以通过一个Apk(宿主程序)来动态的加载另一个Apk文
件并将其放在自己的进程中执行.其中有几个难点:

	1. 资源访问,因为在宿主程序中Context是宿主的,不能访问加载Apk的资源.可以把加载
	Apk的资源文件放到一个目录里,通过文件的方式来访问
	2. Activity生命周期的问题,Android中Activity的生命周期是系统管理的,而加载的
	Apk的Activity就是普通的Java类.可以自己实现管理生命周期.

### 工作原理
宿主程序会到文件系统如sdcard中去加载Apk,然后使用一个叫Proxy的activity去执行加载
Apk中的Activity.

动态加载Apk有三种方法:

	1. DexClassLoader: 可以加载文件系统上的jar、dex、apk
	2. PathClassLoader: 可以加载/data/app目录下的apk，这也意味着，它只能加载已经
	安装的apk
	3. URLClassLoader: 可以加载java中的jar，但是由于dalvik不能直接识别jar，所以
	此方法在android中无法使用，尽管还有这个类

dex和apk可以直接加载,但是原始jar不行,必须转成dalvik可以识别的字节码文件,使用dx工
具

	dx --dex --output=dest.jar src.jar

### 实现

#### 宿主程序
采用DexClassLoader去加载apk,然后判断是否指定class,有指定就运行指定的Activity;
如果没有指定,那么就取apk主activity去执行.

执行加载activity的方法:通过反射出Activity并创建一个对象,实现一个setProxy方法
,把代理Activity传过去,让加载activity的所有实现交给proxyactivity去执行.

#### 加载activity
由于访问不了xml文件,所以布局都是使用代码实现的.

### 资源管理
因为不是一个上下文,所以宿主程序访问不了子程序的资源文件,不能使用R来引用资源文件.
有几个方法来解决这个问题:

	1. 把子程序的资源文件COPY一份到宿主程序中.每次加载子程序都要更新宿主程序,而
	且资源文件有两份.所以这种方法不好.
	2. 把子程序的资源文件导入一个目录,使用文件的方式访问.资源文件有不同的文件流,
	而且根据设备的不同需要读取不同的配置文件.所以这种方法也不好
	3. 下面使用的方法

Activity的工作主要是由ComtextImpl来完成的,其中有两和函数来获取资源.

	/** Return an AssetManager instance for your application's package. */
	public abstract AssetManager getAssets();
	/** Return a Resources instance for your application's package. */
	public abstract Resources getResources();

通过反射调用addAssetPath()函数,来加载Apk中的资源到Resources.其次实现上面2个抽象
方法.这样就可以通过R来访问资源了

### Activity生命周期的管理
因为子程序加载的Activity就是一个普通的类(没有在Manifast文件中注册),所以需要自己
管理Activity的生命周期.

有几种方法:
	
	1. 使用Fragment,这样Fragmnet的生命周期是代理Activity管理
	2. 使用代理Actvity,代理Activity通过反射出子Activity,然后在生命周期中调用他.

### 插件Apk的开发规范
1. 不能用this,因为子Activity是普通的类,没有Context的意义
2. 使用that,that是BaseActivity中定义的一个属性
3. 不能直接调用Activity成员函数,需要通过that调用
4. 启动外部Activity没有约束,调用内部的有.因为Activity没有注册,所以不能隐式调用.
	而且不支持launchMode.通过startActivityByProxy和startActivityForResultByProxy,
	来调用Activity
5. 不支持Service,Broadcast

### 动态加载框架(DL)
当项目越来越大并且功能使用的环境越复杂时候,需要通过插件化来减轻应用的内存和cpu占
用.还可以支持热插拔,即在不更新程序的情况下更新某个模块.

#### DL功能介绍
1. plugin无需安装即可由宿主调起。
2. 支持用R访问plugin资源
3. plugin支持Activity和FragmentActivity（未来还将支持其他组件）
4. 基本无反射调用 
5. 插件安装后仍可独立运行从而便于调试
6. 支持3种plugin对host的调用模式：
	* （1）无调用（但仍然可以用反射调用）。
	* （2）部分调用，host可公开部分接口供plugin调用。 这前两种模式适用于plugin
			开发者无法获得host代码的情况。
	* （3）完全调用，plugin可以完全调用host内容。这种模式适用于plugin开发者能获
			得host代码的情况。
7. 只需引入DL的一个jar包即可高效开发插件，DL的工作过程对开发者完全透明
8. 支持android2.x版本

#### 1. DL对activity生命周期管理的改进
DL最开始是使用反射Activity生命周期函数来实现的,反射实现起来复杂,并且使用多了有一
些性能开销.所以现在使用接口的方法,把生命周期方法提取出来成DLPlugin接口,子程序实现
这些接口函数就行了.

#### 2. DL对类加载器的支持
使用DLClassoader来管理各个插件的DexClassoader,同一个插件可以使用一个ClassLoader,
避免多个ClassLoader加载同一个类导致类型转换错误.

#### 3. DL对宿主（host）和插件（plugin）通信的支持
1. depend_on_host: 插件完全依赖宿主的模式，适合于能够能到宿主的源代码的情况
其中host指宿主工程，plugin指插件工程
2. depend_on_interface: 插件部分依赖宿主的模式，或者说插件依赖宿主提供的接口，适
合能够拿到宿主的接口的情况,其中host指宿主工程，plugin指插件工程，common指接口工程
3. main: 插件不依赖宿主的模式，这是DL推荐的模式,其中host指宿主工程
，plugin指插件工程

#### 4. DL对插件独立运行的支持
为了便于调试，采用DL所开发的插件都可以独立运行，当然，这要分情况来说：
对于模式1，如果插件想独立运行，只需要把external-jars下的jar包拷贝一份到插件的libs目录下即可
对于模式2，只需要提供一个宿主接口的默认实现即可
对于模式3，只需要apk打包时把所引用的宿主代码打包进去即可，具体方式可以参看sample/depend_on_host目录。
在开发过程中，应该先开启插件的独立运行功能以便于调试，等功能开发完毕后再将其插件化。

#### 5. DLIntent和DLPluginManager
这两项都属于加强功能，目前正在dev分支进行code review，大家感兴趣可以去dev分支上查看，等验证通过即merge到稳定版master分支。
DLIntent：通过DLIntent来完成activity的无约束调起
DLPluginManager：对宿主的所有插件提供综合管理功能。

#### 6. 开发规范
DL 1.0开发规范：
1. 目前不支持service
2. 目前只支持动态注册广播
3. 目前支持Activity和FragmentActivity，这也是常用的activity
4. 目前不支持插件中的assets
5. 调用Context的时候，请适当使用that，大部分常用api是不需要用that的，但是一些不
常用api还是需要用that来访问。that是apk中activity的基类BaseActivity系列中的一个成
员，它在apk安装运行的时候指向this，而在未安装的时候指向宿主程序中的代理activity
，由于that的动态分配特性，通过that去调用activity的成员方法，在apk安装以后仍然
可以正常运行。
6. 慎重使用this，因为this指向的是当前对象，即apk中的activity，但是由于activity
已经不是常规意义上的activity，所以this是没有意义的，但是，当this表示的不是
Context对象的时候除外，比如this表示一个由activity实现的接口。

