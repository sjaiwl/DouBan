//
//  CinemaListCell.m
//  DouBan
//
//  Created by sjaiwl on 15/8/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieListCell.h"
#import "ImageDownLoader.h"
#import "UIImageView+WebCache.h"

@implementation MovieListCell

- (void)awakeFromNib {
    // Initialization code
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重写movie的setter方法
- (void)setMovie:(Movie *)movie{
    //设置图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:movie.pic_url] placeholderImage:[UIImage imageNamed:@"picholder"]];
    //设置标题
    self.name.text = movie.movieName;
}

@end
