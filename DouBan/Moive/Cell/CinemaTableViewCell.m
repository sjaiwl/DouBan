//
//  CinemaTableViewCell.m
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaTableViewCell.h"

@implementation CinemaTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //设置圆角
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 5;
    
    self.cinemaAddress.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重写cinema的setter方法
- (void)setCinema:(Cinema *)cinema{
    self.cinemaName.text = cinema.cinemaName;
    self.cinemaAddress.text = cinema.address;
    self.cinemaPhone.text = cinema.telephone;
}
@end
