//
//  CinemaDetailsTableViewCell.h
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BroadCast.h"
#define kCinemaDetailsCellHeight 60

@interface CinemaDetailsTableViewCell : UITableViewCell

@property (nonatomic,retain) BroadCast *broad;

//时间
@property (strong, nonatomic) IBOutlet UILabel *time;
//语言
@property (strong, nonatomic) IBOutlet UILabel *languageAndType;
//播放厅
@property (strong, nonatomic) IBOutlet UILabel *hall;
//价格
@property (strong, nonatomic) IBOutlet UILabel *price;

@end
