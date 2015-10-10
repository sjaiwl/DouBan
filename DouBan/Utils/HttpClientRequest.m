//
//  HttpClientRequest.m
//  DouBan
//
//  Created by lanou3g on 15/8/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HttpClientRequest.h"

@implementation HttpClientRequest

//get请求
+ (void)getHttpClientRequest:(NSString *)string
                 andDelegate:(id<HttpClientRequestDelegete>)delegate{
    //1.初始化url
    NSURL *url = [NSURL URLWithString:string];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    [request setHTTPMethod:@"get"];
    //3.请求数据,创建链接请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //代理
        if (delegate != nil && [delegate respondsToSelector:@selector(getHttpResponseData:)]) {
            //传递数据
            [delegate getHttpResponseData:data];
        }
        //处理错误
        if (delegate != nil && [delegate respondsToSelector:@selector(getHttpResponseError:)]) {
            //处理错误
            [delegate getHttpResponseError:connectionError];
        }
        
    }];

    
}

//post请求
+ (void)postHttpClientRequest:(NSString *)string
                 andParameter:(NSString *)para
                  andDelegate:(id<HttpClientRequestDelegete>)delegate{
    //获取参数
    NSData *data = [para dataUsingEncoding:NSUTF8StringEncoding];
    //1.初始化url
    NSURL *url = [NSURL URLWithString:string];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式和post参数
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:data];
    //3.请求数据,创建链接请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //代理
        if (delegate != nil && [delegate respondsToSelector:@selector(getHttpResponseData:)]) {
            //传递数据
            [delegate getHttpResponseData:data];
        }
        //处理错误
        if (delegate != nil && [delegate respondsToSelector:@selector(getHttpResponseError:)]) {
            //处理错误
            [delegate getHttpResponseError:connectionError];
        }
    }];

}
//get请求,使用block
+ (void)getHttpClientRequestBlock:(NSString *)string
                andCompleteHandle:(void (^)(NSData* data, NSError* connectionError)) handle{
    //1.设置url
    NSURL *url = [NSURL URLWithString:string];
    //2.创建request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    [request setHTTPMethod:@"get"];
    //3.请求数据,创建链接请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //block
        if (handle != nil) {
            //block传值
            handle(data,connectionError);
        }
        
    }];

}
//post请求,使用block
+ (void)postHttpClientRequestBlock:(NSString *)string
                      andParameter:(NSString *)para
                 andCompleteHandle:(void(^)(NSData *data,NSError *error)) handle{
    //获取参数
    NSData *data = [para dataUsingEncoding:NSUTF8StringEncoding];
    //1.初始化url
    NSURL *url = [NSURL URLWithString:string];
    //2.创建请求对象
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式和post参数
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:data];
    //3.请求数据,创建链接请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //block
        if (handle != nil) {
            //block传值
            handle(data,connectionError);
        }
        
    }];

}
@end
