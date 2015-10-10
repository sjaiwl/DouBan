//
//  AppUrl.m
//  DouBan
//
//  Created by lanou3g on 15/8/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AppUrl.h"

static AppUrl *appUrl = nil;
@implementation AppUrl

//数据初始化
- (instancetype)init{
    if (self = [super init]) {
        //活动
       self.activityUrl = @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php";
        //电影
        self.movieUrl = @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php";
        //电影详情
        self.movieDetailsUrl = @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchmovie.php";
        //影院列表
        self.cinemaUrl = @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/cinemalist.php";
        //影院详情
        self.cinemaDetailsUrl = @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchcinema.php";
        
    }
    
    return self;
}

//单例
+ (instancetype)getInstance{
    
    if(appUrl == nil){
        appUrl = [[AppUrl alloc] init];
    }
    
    return appUrl;
}

@end
