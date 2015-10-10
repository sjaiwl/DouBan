//
//  Activity.h
//  DouBan
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

//title : 活动标题!
//begin_time : 开始时间!
//end_time :结束时间!
//address :地址!
//category_name:活动类型!
//participant_count:参加⼈人数!
//wisher_count:感兴趣⼈人数!
//image:活动图像(先显⽰示占位图像)!
//! name:活动举办⽅方!
//! category_name:活动类型!

@interface Activity : NSObject
//id
@property (nonatomic,retain) NSString *activity_id;
//图片,image
@property (nonatomic,retain) NSString *image;
//标题,title
@property (nonatomic,retain) NSString *title;
//开始时间,begin_time
@property (nonatomic,retain) NSString *begin_time;
//结束时间,end_time
@property (nonatomic,retain) NSString *end_time;
//oewr name
@property (nonatomic,retain) NSString *owner_name;
//地点,address
@property (nonatomic,retain) NSString *address;
//类型,category_name
@property (nonatomic,retain) NSString *category_name;
//活动介绍,content
@property (nonatomic,retain) NSString *content;
//感兴趣,wisher_count
@property (nonatomic,assign) int wisher_count;
//参与人数
@property (nonatomic,assign) int participant_count;
@end
