//
//  CinemaListCell.h
//  DouBan
//
//  Created by sjaiwl on 15/8/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

#define kMovieCell 190

@interface MovieListCell : UITableViewCell

@property (nonatomic,retain) Movie *movie;
//图片
@property (strong, nonatomic) IBOutlet UIImageView *image;
//名称
@property (strong, nonatomic) IBOutlet UILabel *name;
//视图
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end
