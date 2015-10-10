# 仿豆瓣电影推荐功能ios客户端
仿豆瓣电影推荐功能ios客户端，完成豆瓣项目中基本的电影，影院推荐和收藏功能。 此项目中，主要知识点包括：页面布局实现，数据解析，异步网络请求，数据库操作，图片异步加载，tableview相关操作。
# 基本流程图
![image](https://github.com/sjaiwl/image_folder/blob/master/DouBan/豆瓣流程图.png)
#主界面视图
<div class='row'>
        <img src='https://github.com/sjaiwl/image_folder/blob/master/DouBan/活动列表.png' width="250px" style='border: #f1f1f1 solid 1px'/>
        <img src='https://github.com/sjaiwl/image_folder/blob/master/DouBan/电影列表(collection).png' width="250px" style='border: #f1f1f1 solid 1px'/>
        <img src='https://github.com/sjaiwl/image_folder/blob/master/DouBan/影院列表.png' width="250px" style='border: #f1f1f1 solid 1px'/>
        <img src='https://github.com/sjaiwl/image_folder/blob/master/DouBan/用户页面.png' width="250px" style='border: #f1f1f1 solid 1px'/>
        <img src='https://github.com/sjaiwl/image_folder/blob/master/DouBan/电影列表(list).png' width="250px" style='border: #f1f1f1 solid 1px'/>
        <img src='https://github.com/sjaiwl/image_folder/blob/master/DouBan/活动详情.png' width="250px" style='border: #f1f1f1 solid 1px'/>
        <img src='https://github.com/sjaiwl/image_folder/blob/master/DouBan/电影详情.png' width="250px" style='border: #f1f1f1 solid 1px'/>
    </div>
    
#主要模块实现及相关技术
* 页面布局实现
  * 主要就是使用AutoLayout和xib文件结合的形式，显示使用xib绘制出界面视图，然后添加约束，可以适配不同的手机。
 
  * tableview的cell布局使用单独的xib文件，同时对cell中空间的layer的相关属性进行设置。

* 数据请求和数据解析
  * 数据请求主要就是使用ios 8自带的网络请求函数进行请求，这里自己封装了网络请求的库，HttpClientRequest.h和HttpClientRequest.m文件，实现了代理和block返回数据的两种方式。在ios 9之后网络请求方式发生了变化，有些函数可能已经被替代了。

  * 数据解析主要就是解析json数据，也是利用NSJSONSerialization中的相关函数进行解析，这里需要特别注意，使用model来解析数据时，一定要在model类中要重写- (void)setValue:(id)value forUndefinedKey:(NSString *)key方法，这个方法需要特别注意。

* 数据库操作
  * 数据库主要实现收藏功能，将收藏的活动和电影保存到本地数据库，这里也自己封装了数据库的相关操作，DataBase.h和DataBase.m文件，这里主要就是增对数据库的增加，删除，查询操作。

  * 虽然现在用户操作记录的数据基本都是存储在网络上，但是还是有些基本的数据存储在本地或者需要缓存在本地，那么就需要自己去了解ios数据库的相关操作。

* 图片异步加载
  * 主要借助开源框架实现，SDWebImage框架可以实现很多功能，主要就是图片异步加载，缓存清除等，非常实用。下载地址大家可以到网上查询一下，有很多地方可以下载。


#总结
其实，该项目中还有许多细节问题，这里并没有提到，比如：界面跳转，navigationBar相关设置，collectionView使用，界面传值等，只是介绍了几个主要的技术，对于刚开始做ios开发的人还是很有帮助的，这也算是一个比较完整的小项目，希望感兴趣的人可以下载看看。
