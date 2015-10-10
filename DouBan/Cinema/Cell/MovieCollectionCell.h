//
//  MovieCollectionCell.h
//  DouBan
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCollectionCell : UICollectionViewCell

@property (nonatomic,retain) Movie *movie;
//图片
@property (strong, nonatomic) IBOutlet UIImageView *image;
//名称
@property (strong, nonatomic) IBOutlet UILabel *name;

@end
