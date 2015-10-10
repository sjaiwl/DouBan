//
//  Cinema.m
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Cinema.h"

@implementation Cinema

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //给cinemaId赋值
    if ([key isEqualToString:@"id"]) {
        self.cinemaId = value;
    }
}

@end
