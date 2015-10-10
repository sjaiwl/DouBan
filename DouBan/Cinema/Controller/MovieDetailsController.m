//
//  MovieDetailsController.m
//  DouBan
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieDetailsController.h"
#import "HttpClientRequest.h"
#import "AppUrl.h"
#import "ImageDownLoader.h"
#import "UIImageView+WebCache.h"
#import "DataBase.h"
#import "LoginViewController.h"

@interface MovieDetailsController ()<UIAlertViewDelegate>

@property (nonatomic,assign) BOOL isCollectState;

@end

@implementation MovieDetailsController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //设置左按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack:)];
        //设置右按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"star_unfav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickShare:)];
    }
    return self;
}

//返回事件
- (void)clickBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//登录事件
- (void)clickShare:(UIBarButtonItem *)sender{
    //判断是否登录
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loginState"]) {
        //已经登录
        NSString *str = _isCollectState ? @"取消收藏" : @"确认收藏";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    }else{
        //未登录
        //登录
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        //模态显示
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //点击确认按钮
    if (buttonIndex == 0) {
        if (_isCollectState) {
            _isCollectState = NO;
            //取消收藏
            [[DataBase getInstance] deleteMovieCollectList:_details];
        }else{
            _isCollectState = YES;
            //确认收藏
            [[DataBase getInstance] addMovieCollectList:_details];
        }
        //设置状态
        [self setCollectState];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    //设置标题
    self.navigationItem.title = _movie.movieName;
    //如果不需要请求
    if(_details == nil){
        NSString *string = [NSString stringWithFormat:@"%@?movieId=%@",[AppUrl getInstance].movieDetailsUrl,_movie.movieId];
        __weak __typeof(self) weakSelf = self;
        //请求数据
        [HttpClientRequest getHttpClientRequestBlock:string andCompleteHandle:^(NSData *data, NSError *error) {
            if (data == nil) {
                return ;
            }
            //数据解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dict = dic[@"result"];
            weakSelf.details = [MovieDetails new];
            [_details setValuesForKeysWithDictionary:dict];
            //赋值
            [weakSelf setDetailsValue:_details];
        }]; 
    }else{
        //赋值
        [self setDetailsValue:_details];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取登录状态
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //如果已经登录
    if ([user boolForKey:@"loginState"]) {
        //获取收藏状态
        self.isCollectState = [[DataBase getInstance] selectMovieWithId:_movie.movieId];
        //设置收藏状态
        [self setCollectState];
    }

}

//设置收藏状态
- (void)setCollectState{
    if (_isCollectState) {
        //已经收藏过
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"star_faved"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        //未收藏
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"star_unfav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}


//设置界面上的值
-(void) setDetailsValue:(MovieDetails *)details{
    //设置图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:_movie.pic_url] placeholderImage:[UIImage imageNamed:@"picholder"]];
    //设置评分
    self.rating.text = [NSString stringWithFormat:@"评分: %@",details.rating];
    //设置评论
    self.commentNum.text = [NSString stringWithFormat:@"(%@评论)",details.rating_count];
    //设置时间
    self.date.text = details.release_date;
    //设置时长
    self.longTime.text = details.runtime;
    //设置类型
    self.genres.text = details.genres;
    //设置国家
    self.country.text = details.country;
    //设置主演
    self.actor.numberOfLines = 0;
    self.actor.text = details.actors;
    //设置情节简介
    self.plot.numberOfLines = 0;
    self.plot.text = details.plot_simple;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    //计算文本高度
    CGRect rect = [_details.plot_simple boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    //设置宽
    self.viewWidth.constant = self.view.frame.size.width - 40;
    //设置高
    self.viewHeight.constant = self.plot.frame.origin.y + rect.size.height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
