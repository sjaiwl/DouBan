//
//  HttpClientRequest.h
//  DouBan
//
//  Created by lanou3g on 15/8/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义block
typedef void(^ReturnDataBlock)(NSData *,NSError *);

//代理协议
@protocol HttpClientRequestDelegete <NSObject>
//获取返回数据
- (void)getHttpResponseData:(NSData *)data;
//获取错误
@optional
- (void)getHttpResponseError:(NSError *)error;
@end

@interface HttpClientRequest : NSObject

//代理
@property (nonatomic,assign) id<HttpClientRequestDelegete> delegate;
//block,语义设置一定要使用copy,不然会造成野指针异常
@property (nonatomic,copy) ReturnDataBlock dataBlock;

//get请求,使用代理
+ (void)getHttpClientRequest:(NSString *)string
                 andDelegate:(id<HttpClientRequestDelegete>)delegate;
//post请求,使用代理
+ (void)postHttpClientRequest:(NSString *)string
             andParameter:(NSString *)para
andDelegate:(id<HttpClientRequestDelegete>)delegate;

//get请求,使用block
+ (void)getHttpClientRequestBlock:(NSString *)string
                andCompleteHandle:(void(^)(NSData *data,NSError *error)) handle;
//get请求,使用block
+ (void)postHttpClientRequestBlock:(NSString *)string
                      andParameter:(NSString *)para
                andCompleteHandle:(void(^)(NSData *data,NSError *error)) handle;

@end
