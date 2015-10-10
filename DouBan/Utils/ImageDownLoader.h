//
//  ImageDownLoader.h
//  UI_Lesson_17图片加载
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DownLoaderDelegate <NSObject>

- (void)downLoaderDidFinishDownloadingImage:(UIImage *)image;

@end

typedef void(^BLOCK)(UIImage *image);

@interface ImageDownLoader : NSObject

//代理
@property (nonatomic,assign) id<DownLoaderDelegate> delegate;
//block
@property (nonatomic,copy) BLOCK block;

//静态方法
//封装同步
+ (UIImage *)sychronousDownLoader:(NSString *)imgUrl;

//封装异步,使用代理
+ (void)asynchronousDownLoader:(NSString *)imgUrl
                   andDelegate:(id<DownLoaderDelegate>)delegate;
//封装异步,使用block块
+ (void)asynchronousDownLoader:(NSString *)imgUrl
                   andBlock :(BLOCK)block;
//动态方法
-(void)delegateAsychronousdownLoader: (NSString *)imgUrl;
-(void)blockAsychronousdownLoader:(NSString *)imgUrl;

@end
