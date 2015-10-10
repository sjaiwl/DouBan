# DouBan
仿豆瓣电影推荐功能ios客户端，完成豆瓣项目中基本的电影，影院推荐和收藏功能。 此项目中，主要知识点包括：页面布局实现，数据解析，异步网络请求，数据库操作，图片异步加载，tableview相关操作。
# 基本流程图

#主界面视图

#主要模块实现及相关技术
* 页面布局实现
  * 主要就是使用AutoLayout和xib文件结合的形式，显示使用xib绘制出界面视图，然后添加约束，可以适配不同的手机。
  * tableview的cell布局使用单独的xib文件，同时对cell中空间的layer的相关属性进行设置。


* 数据请求和数据解析
   *数据请求主要就是使用ios 8自带的网络请求函数进行请求，这里自己封装了网络请求的库，HttpClientRequest.h和HttpClientRequest.m文件，实现了代理和block返回数据的两种方式。在ios 9之后网络请求方式发生了变化，有些函数可能已经被替代了。
   *数据解析主要就是解析json数据，也是利用NSJSONSerialization中的相关函数进行解析，这里需要特别注意，使用model来解析数据时，一定要在model类中要重写- (void)setValue:(id)value forUndefinedKey:(NSString *)key方法，这个方法需要特别注意。
#总结
