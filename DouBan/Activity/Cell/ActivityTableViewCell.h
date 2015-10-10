//
//  ActivityTableViewCell.h
//  DouBan
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

#define kActivityCellHeight 280

@interface ActivityTableViewCell : UITableViewCell
//传值model
@property (nonatomic,retain) Activity *activity;

//标题
@property (strong, nonatomic) IBOutlet UILabel *titile;
//时间
@property (strong, nonatomic) IBOutlet UILabel *date;
//地点
@property (strong, nonatomic) IBOutlet UILabel *locate;
//类型
@property (strong, nonatomic) IBOutlet UILabel *type;
//图片
@property (strong, nonatomic) IBOutlet UIImageView *image;
//感兴趣人数
@property (strong, nonatomic) IBOutlet UILabel *interestNum;
//参加
@property (strong, nonatomic) IBOutlet UILabel *takeinNum;
//view
@property (strong, nonatomic) IBOutlet UIView *conView;
//detailsView
@property (strong, nonatomic) IBOutlet UIView *detailsView;

@end
