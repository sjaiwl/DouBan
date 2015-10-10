//
//  UrlConnection.h
//  MoviePlayer
//
//  Created by sherry on 15/6/11.
//  Copyright (c) 2015年 Sherry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^connectionBlock)(id responseObject);

@interface UrlConnection : NSObject

@property (nonatomic, strong) connectionBlock block;

+(void)startConnection:(NSString *)url parmaters:(NSDictionary *)par connetionBlock:(connectionBlock)block;

-(void)connectionWith:(NSString *)url parmaters:(NSDictionary *)par connectionBlock:(connectionBlock)block;

@end
