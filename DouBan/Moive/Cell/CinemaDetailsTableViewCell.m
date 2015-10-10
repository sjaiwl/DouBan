//
//  CinemaDetailsTableViewCell.m
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaDetailsTableViewCell.h"

@implementation CinemaDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.price.textColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBroad:(BroadCast *)broad{
    self.time.text = broad.time;
    self.languageAndType.text = [NSString stringWithFormat:@"%@%@",broad.language,broad.type];
    self.hall.text = broad.hall;
    self.price.text = [NSString stringWithFormat:@"%@元",broad.price];
}

@end
