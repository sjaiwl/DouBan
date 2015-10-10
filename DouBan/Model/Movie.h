//
//  Movie.h
//  DouBan
//
//  Created by sjaiwl on 15/8/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

//movieName:电影名!
//! pic_url:图⽚片 !
//! movieid:电影编号!

@interface Movie : NSObject

@property (nonatomic,retain) NSString *movieName;
@property (nonatomic,retain) NSString *pic_url;
@property (nonatomic,retain) NSString *movieId;

@end
