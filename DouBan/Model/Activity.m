//
//  Activity.m
//  DouBan
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Activity.h"

@implementation Activity

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //获取主办单位
    if ([key isEqualToString:@"owner"]) {
        NSDictionary *dic = value;
        self.owner_name = dic[@"name"];
    }
    //获取id
    if ([key isEqualToString:@"id"]) {
        self.activity_id = value;
    }
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%d,%d",_activity_id,_image,_title,_begin_time,_end_time,_owner_name,_category_name,_address,_content,_wisher_count,_participant_count];
}
@end
