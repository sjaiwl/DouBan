//
//  ActivityViewController.h
//  DouBan
//
//  Created by lanou3g on 15/9/4.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface ActivityViewController : UIViewController

@property (nonatomic,retain) Activity *activity;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;


//头像
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *activity_name;

//时间
@property (strong, nonatomic) IBOutlet UILabel *date;
//主办方
@property (strong, nonatomic) IBOutlet UILabel *owner_name;
//类型
@property (strong, nonatomic) IBOutlet UILabel *type;
//地点
@property (strong, nonatomic) IBOutlet UILabel *address;
//内容
@property (strong, nonatomic) IBOutlet UILabel *content;

@end
