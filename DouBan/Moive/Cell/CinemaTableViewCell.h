//
//  CinemaTableViewCell.h
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"
#define kCinemaCellHeight 150

@interface CinemaTableViewCell : UITableViewCell
//属性
@property (nonatomic,retain) Cinema *cinema;
//视图
@property (strong, nonatomic) IBOutlet UIView *mainView;
//影院名称
@property (strong, nonatomic) IBOutlet UILabel *cinemaName;
//影院地址
@property (strong, nonatomic) IBOutlet UILabel *cinemaAddress;
//影院电话
@property (strong, nonatomic) IBOutlet UILabel *cinemaPhone;

@end
