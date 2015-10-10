//
//  DataBase.m
//  DouBan
//
//  Created by sjaiwl on 15/9/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DataBase.h"
//单例
static DataBase *dataBase = nil;
//数据库
static sqlite3 *activityDB = nil;
static sqlite3 *movieDB = nil;

@implementation DataBase

//获取单例
+ (instancetype)getInstance{
    if (dataBase == nil) {
        dataBase = [[DataBase alloc] init];
    }
    return dataBase;
}

//打开收藏活动数据库
- (void)openCollectActivityDataBase{
    //如果存在直接跳过
    if (activityDB != nil) {
        return;
    }
    //不存在数据库
    //创建存放路径,存储在document文件夹下面
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingString:@"/Activity.sqlite"];
    //打开数据库
    int result = sqlite3_open([path UTF8String], &activityDB);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"收藏活动数据库打开成功");
        //创建数据库表
        //创建sql语句
        NSString *sql = @"CREATE TABLE Activity (activity_id TEXT PRIMARY KEY NOT NULL, image TEXT, title TEXT, begin_time TEXT, end_time TEXT, owner_name TEXT, address TEXT, category_name TEXT, content TEXT, wisher_count INTEGER, participant_count INTEGER)";
        //执行sql语句,创建数据库表
        sqlite3_exec(activityDB, [sql UTF8String], nil, nil, nil);
    }else{
        NSLog(@"收藏数据库打开失败");
    }
}
//关闭收藏活动数据库
- (void)closeCollectActivityDataBase{
    //关闭数据库
    if (activityDB != nil) {
        int result = sqlite3_close(activityDB);
        //判断关闭结果
        if (result == SQLITE_OK) {
            NSLog(@"收藏活动数据库关闭成功");
            activityDB = nil;
        }else{
            NSLog(@"收藏活动数据库关闭失败");
        }
    }
}

//添加活动收藏记录
- (void)addActivityCollectList:(Activity *)activity{
    //1.打开数据库
    [self openCollectActivityDataBase];
    //2.创建伴随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"INSERT INTO Activity VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    //4.验证sql语句正确性
    int result = sqlite3_prepare_v2(activityDB, [sql UTF8String], -1, &stmt, nil);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"添加活动收藏成功");
        //5.开始绑定数据
        sqlite3_bind_text(stmt, 1, [activity.activity_id UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [activity.image UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [activity.title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [activity.begin_time UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [activity.end_time UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 6, [activity.owner_name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 7, [activity.address UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 8, [activity.category_name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 9, [activity.content UTF8String], -1, nil);
        sqlite3_bind_int(stmt, 10, activity.wisher_count);
        sqlite3_bind_int(stmt, 11, activity.participant_count);
        //6.单步执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"添加活动收藏失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
}
//删除活动收藏记录
- (void)deleteActivityCollectList:(Activity *)activity{
    //1.打开数据库
    [self openCollectActivityDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"DELETE FROM Activity WHERE activity_id = ?";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(activityDB, [sql UTF8String], -1, &stmt, nil);
    //结果
    if (result == SQLITE_OK) {
        NSLog(@"取消收藏活动成功");
        //5.绑定数据
        sqlite3_bind_text(stmt, 1, [activity.activity_id UTF8String], -1, nil);
        //6.单步执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"取消收藏活动失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
}
//返回收藏的所有活动
- (NSArray *)selectAllCollectActivity{
    //1.打开数据库
    [self openCollectActivityDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"SELECT *FROM Activity";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(activityDB, [sql UTF8String], -1, &stmt, nil);
    //创建可变数组
    NSMutableArray *array = [NSMutableArray array];
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"查询所有收藏活动成功");
        //5.获取数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //6.添加到数组
            NSString *activity_id = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSString *image = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *begin_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *end_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            NSString *owner_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            NSString *address = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString *category_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            int wisher_count = sqlite3_column_int(stmt, 9);
            int participant_count = sqlite3_column_int(stmt, 10);
            //创建activity
            Activity *activity = [Activity new];
            activity.activity_id = activity_id;
            activity.image = image;
            activity.title = title;
            activity.begin_time = begin_time;
            activity.end_time = end_time;
            activity.owner_name = owner_name;
            activity.address = address;
            activity.category_name = category_name;
            activity.content = content;
            activity.wisher_count = wisher_count;
            activity.participant_count = participant_count;
            //添加到数组
            [array addObject:activity];
        }
    }else{
        NSLog(@"查询所有收藏活动失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
    //8.返回数组
    return array;
}
//根据id查询是否已经收藏
- (BOOL)selectActivityWithId:(NSString *)activity_id{
    BOOL state = NO;
    //1.打开数据库
    [self openCollectActivityDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"SELECT *FROM Activity WHERE activity_id = ?";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(activityDB, [sql UTF8String], -1, &stmt, nil);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"查询活动是否收藏成功");
        //5.绑定数据
        sqlite3_bind_text(stmt, 1, [activity_id UTF8String], -1, nil);
        //6.获取查询结果
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            //已经查询到
            state = YES;
        }
        
    }else{
        NSLog(@"查询活动是否收藏成功失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
    //8.返回结果
    return state;
}

//打开收藏电影数据库
- (void)openCollectMovieDataBase{
    //如果存在直接跳过
    if (movieDB != nil) {
        return;
    }
    //不存在数据库
    //创建存放路径,存储在document文件夹下面
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingString:@"/Movie.sqlite"];
    //打开数据库
    int result = sqlite3_open([path UTF8String], &movieDB);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"收藏电影数据库打开成功");
        //创建数据库表
        //创建sql语句
        NSString *sql = @"CREATE TABLE Movie (movieid TEXT PRIMARY KEY NOT NULL, rating TEXT, genres TEXT, runtime TEXT, title TEXT, poster TEXT, rating_count TEXT, plot_simple TEXT, country TEXT, release_date TEXT, actors TEXT)";
        //执行sql语句,创建数据库表
        sqlite3_exec(movieDB, [sql UTF8String], nil, nil, nil);
    }else{
        NSLog(@"收藏电影数据库打开失败");
    }

}
//关闭收藏电影数据库
- (void)closeCollectMovieDataBase{
    //关闭数据库
    if (movieDB != nil) {
        int result = sqlite3_close(movieDB);
        //判断关闭结果
        if (result == SQLITE_OK) {
            NSLog(@"收藏电影数据库关闭成功");
            movieDB = nil;
        }else{
            NSLog(@"收藏电影数据库关闭失败");
        }
    }
}
//添加电影收藏记录
- (void)addMovieCollectList:(MovieDetails *)movie{
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建伴随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"INSERT INTO Movie VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    //4.验证sql语句正确性
    int result = sqlite3_prepare_v2(movieDB, [sql UTF8String], -1, &stmt, nil);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"添加电影收藏成功");
        //5.开始绑定数据
        sqlite3_bind_text(stmt, 1, [movie.movieid UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [movie.rating UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [movie.genres UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [movie.runtime UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [movie.title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 6, [movie.poster UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 7, [movie.rating_count UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 8, [movie.plot_simple UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 9, [movie.country UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 10, [movie.release_date UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 11, [movie.actors UTF8String], -1, nil);
        //6.单步执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"添加电影收藏失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
}
//删除电影收藏记录
- (void)deleteMovieCollectList:(MovieDetails *)movie{
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"DELETE FROM Movie WHERE movieid = ?";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(movieDB, [sql UTF8String], -1, &stmt, nil);
    //结果
    if (result == SQLITE_OK) {
        NSLog(@"取消收藏电影成功");
        //5.绑定数据
        sqlite3_bind_text(stmt, 1, [movie.movieid UTF8String], -1, nil);
        //6.单步执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"取消收藏电影失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
}
//返回收藏的所有电影
- (NSArray *)selectAllCollectMovie{
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"SELECT *FROM Movie";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(movieDB, [sql UTF8String], -1, &stmt, nil);
    //创建可变数组
    NSMutableArray *array = [NSMutableArray array];
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"查询所有收藏电影成功");
        //5.获取数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //6.添加到数组
            NSString *movieid = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSString *rating = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *genres = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *runtime = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            NSString *poster = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            NSString *rating_count = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString *plot_simple = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            NSString *country = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            NSString *release_date = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
            NSString *actors = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 10)];

            //创建MovieDetails
            MovieDetails *movie = [MovieDetails new];
            movie.movieid = movieid;
            movie.rating = rating;
            movie.genres = genres;
            movie.runtime = runtime;
            movie.title = title;
            movie.poster = poster;
            movie.rating_count = rating_count;
            movie.plot_simple = plot_simple;
            movie.country = country;
            movie.release_date = release_date;
            movie.actors = actors;
            //添加到数组
            [array addObject:movie];
        }
    }else{
        NSLog(@"查询所有收藏电影失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
    //8.返回数组
    return array;
}
//根据id查询是否已经收藏
- (BOOL)selectMovieWithId:(NSString *)movieid{
    BOOL state = NO;
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"SELECT *FROM Movie WHERE movieid = ?";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(movieDB, [sql UTF8String], -1, &stmt, nil);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"查询电影是否收藏成功");
        //5.绑定数据
        sqlite3_bind_text(stmt, 1, [movieid UTF8String], -1, nil);
        //判断
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            state = YES;
        }
    }else{
        NSLog(@"查询电影是否收藏成功");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
    //8.返回数组
    return state;
}
@end
