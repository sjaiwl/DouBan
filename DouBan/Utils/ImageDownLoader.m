//
//  ImageDownLoader.m
//  UI_Lesson_17图片加载
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ImageDownLoader.h"

@implementation ImageDownLoader

//封装同步
+ (UIImage *)sychronousDownLoader:(NSString *)imgUrl{
    //创建url
    NSURL *url = [NSURL URLWithString:imgUrl];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //同步连接
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return [UIImage imageWithData:data];
    
}

//封装异步,使用代理
+ (void)asynchronousDownLoader:(NSString *)imgUrl
                   andDelegate:(id)delegate{
    //创建url
    NSURL *url = [NSURL URLWithString:imgUrl];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //异步连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //block块内部的值,我们无法直接返回,需要借助代理将其传出去
        //在值传递之前,我们必须保证代理存在,以及它响应代理事件
        //代理传值
        if (delegate != nil && [delegate respondsToSelector:@selector(downLoaderDidFinishDownloadingImage:)]) {
            [delegate downLoaderDidFinishDownloadingImage:[UIImage imageWithData:data]];
        }

    }];
}

//封装异步,使用block块
+ (void)asynchronousDownLoader:(NSString *)imgUrl
              andBlock :(BLOCK)block{
    //创建url
    NSURL *url = [NSURL URLWithString:imgUrl];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //异步连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //调用block,block传值(方式和代理一样,都是把数据作为参数传出去)
        if (block != nil) {
            block([UIImage imageWithData:data]);
        }

    }];
}

//动态方法
//代理方法
-(void)delegateAsychronousdownLoader: (NSString *)imgUrl{
    //创建url
    NSURL *url = [NSURL URLWithString:imgUrl];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //异步连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //block块内部的值,我们无法直接返回,需要借助代理将其传出去
        //在值传递之前,我们必须保证代理存在,以及它响应代理事件
        //代理传值
        if (_delegate != nil && [_delegate respondsToSelector:@selector(downLoaderDidFinishDownloadingImage:)]) {
            [_delegate downLoaderDidFinishDownloadingImage:[UIImage imageWithData:data]];
        }
        
    }];
}
//block实现
-(void)blockAsychronousdownLoader:(NSString *)imgUrl{
    //创建url
    NSURL *url = [NSURL URLWithString:imgUrl];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //异步连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //调用block,block传值(方式和代理一样,都是把数据作为参数传出去)
        if (_block != nil) {
            _block([UIImage imageWithData:data]);
        }
        
    }];
}

@end
