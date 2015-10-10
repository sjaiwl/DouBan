//
//  MovieDetails.h
//  DouBan
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

//plot_simple:简介!
//! title:电影名字!
//! genres:分类!
//! country:国家!
//! runtime:时间!
//! poster:图⽚片 !
//! rating_count: 评论⼈人数!
//! rating:评分!
//! release_date:上映时间!
//! actors:制作⼈人信息!

@interface MovieDetails : NSObject

@property (nonatomic,retain) NSString *movieid;
@property (nonatomic,retain) NSString *rating;
@property (nonatomic,retain) NSString *genres;
@property (nonatomic,retain) NSString *runtime;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *poster;
@property (nonatomic,retain) NSString *rating_count;
@property (nonatomic,retain) NSString *plot_simple;
@property (nonatomic,retain) NSString *country;
@property (nonatomic,retain) NSString *release_date;
@property (nonatomic,retain) NSString *actors;
@end
