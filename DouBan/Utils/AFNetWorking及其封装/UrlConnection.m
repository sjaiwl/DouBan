//
//  UrlConnection.m
//  MoviePlayer
//
//  Created by sherry on 15/6/11.
//  Copyright (c) 2015年 Sherry. All rights reserved.
//

#import "UrlConnection.h"
#import "AFHTTPRequestOperationManager.h"

@implementation UrlConnection

+(void)startConnection:(NSString *)url parmaters:(NSDictionary *)par connetionBlock:(connectionBlock)block{
    UrlConnection *roots = [[UrlConnection alloc] init];
    [roots connectionWith:url parmaters:par connectionBlock:block];
}

-(void)connectionWith:(NSString *)url parmaters:(NSDictionary *)par connectionBlock:(connectionBlock)block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager GET:url parameters:par success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
