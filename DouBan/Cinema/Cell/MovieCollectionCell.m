//
//  MovieCollectionCell.m
//  DouBan
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieCollectionCell.h"
#import "ImageDownLoader.h"
#import "UIImageView+WebCache.h"

@implementation MovieCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMovie:(Movie *)movie{
    //设置图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:movie.pic_url] placeholderImage:[UIImage imageNamed:@"picholder"]];
    //设置标题
    self.name.text = movie.movieName;
}

@end
