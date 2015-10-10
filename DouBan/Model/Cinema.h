//
//  Cinema.h
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

//id 影院id!
//cinemaName 影院名称!
//address 影院地址!
//telephone 影院电话!
//trafficRoutes 影院乘⻋车路线!

@interface Cinema : NSObject

@property (nonatomic,retain) NSString *cinemaId;
@property (nonatomic,retain) NSString *cinemaName;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *telephone;
@property (nonatomic,retain) NSString *trafficRoutes;
@end
