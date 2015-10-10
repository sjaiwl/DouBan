//
//  AppUrl.h
//  DouBan
//
//  Created by lanou3g on 15/8/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUrl : NSObject

//活动列表接口
@property (nonatomic,retain) NSString *activityUrl;
//电影列表接口
@property (nonatomic,retain) NSString *movieUrl;
//电影详情接口,请求参数:movieId.
@property (nonatomic,retain) NSString *movieDetailsUrl;
//影院列表接口
@property (nonatomic,retain) NSString *cinemaUrl;
//影院详情接口,请求参数:cinemaId.
@property (nonatomic,retain) NSString *cinemaDetailsUrl;

//单例
+ (instancetype)getInstance;

@end
