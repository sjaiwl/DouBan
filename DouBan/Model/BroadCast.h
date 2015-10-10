//
//  BroadCast.h
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BroadCast : NSObject
//播放厅
@property (nonatomic,retain) NSString *hall;
//语言
@property (nonatomic,retain) NSString *language;
//价格
@property (nonatomic,retain) NSString *price;
//票
@property (nonatomic,retain) NSString *ticket_url;
//时间
@property (nonatomic,retain) NSString *time;
//类型
@property (nonatomic,retain) NSString *type;
@end
