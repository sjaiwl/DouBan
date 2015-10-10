//
//  MovieDetailsController.h
//  DouBan
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieDetails.h"

@interface MovieDetailsController : UIViewController

@property (nonatomic,retain) Movie *movie;
@property (nonatomic,retain) MovieDetails *details;

//view宽和高的约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

//图片
@property (strong, nonatomic) IBOutlet UIImageView *image;
//评分
@property (strong, nonatomic) IBOutlet UILabel *rating;
//评论
@property (strong, nonatomic) IBOutlet UILabel *commentNum;
//上映时间
@property (strong, nonatomic) IBOutlet UILabel *date;
//时长
@property (strong, nonatomic) IBOutlet UILabel *longTime;
//类型
@property (strong, nonatomic) IBOutlet UILabel *genres;
//国家
@property (strong, nonatomic) IBOutlet UILabel *country;
//主演
@property (strong, nonatomic) IBOutlet UILabel *actor;
//简介
@property (strong, nonatomic) IBOutlet UILabel *plot;

@end
