//
//  DataBase.h
//  DouBan
//
//  Created by sjaiwl on 15/9/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Activity.h"
#import "MovieDetails.h"


@interface DataBase : NSObject

//获取单例
+ (instancetype)getInstance;
//打开收藏活动数据库
- (void)openCollectActivityDataBase;
//关闭收藏活动数据库
- (void)closeCollectActivityDataBase;
//添加活动收藏记录
- (void)addActivityCollectList:(Activity *)activity;
//删除活动收藏记录
- (void)deleteActivityCollectList:(Activity *)activity;
//返回收藏的所有活动
- (NSArray *)selectAllCollectActivity;
//根据id查询是否已经收藏
- (BOOL)selectActivityWithId:(NSString *)activity_id;

//打开收藏电影数据库
- (void)openCollectMovieDataBase;
//关闭收藏电影数据库
- (void)closeCollectMovieDataBase;
//添加电影收藏记录
- (void)addMovieCollectList:(MovieDetails *)movie;
//删除电影收藏记录
- (void)deleteMovieCollectList:(MovieDetails *)movie;
//返回收藏的所有电影
- (NSArray *)selectAllCollectMovie;
//根据id查询是否已经收藏
- (BOOL)selectMovieWithId:(NSString *)movieid;
@end
