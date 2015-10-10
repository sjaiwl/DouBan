//
//  ActivityViewController.m
//  DouBan
//
//  Created by lanou3g on 15/9/4.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityViewController.h"
#import "ImageDownLoader.h"
#import "UIImageView+WebCache.h"
#import "DataBase.h"
#import "LoginViewController.h"

@interface ActivityViewController ()<UIAlertViewDelegate>

@property (nonatomic,assign) BOOL isCollectState;

@end

@implementation ActivityViewController

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
//收藏事件
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
    //如果点击确认
    if (buttonIndex == 0) {
        if (_isCollectState) {
            _isCollectState = NO;
            //取消收藏
            [[DataBase getInstance] deleteActivityCollectList:_activity];
        }else{
            _isCollectState = YES;
            //确认收藏
            [[DataBase getInstance] addActivityCollectList:_activity];
        }
        //改变状态
        [self setCollectState];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置标题
    self.navigationItem.title = _activity.title;
    self.navigationController.navigationBar.translucent = NO;
    //赋值
    //设置标题
    self.activity_name.numberOfLines = 0;
    self.activity_name.text = _activity.title;
    //设置头像
    [self.image sd_setImageWithURL:[NSURL URLWithString:_activity.image] placeholderImage:[UIImage imageNamed:@"picholder"]];
    //设置日期
    self.date.numberOfLines = 2;
    self.date.text = [NSString stringWithFormat:@"%@ -- %@",_activity.begin_time,_activity.end_time];
    //设置主办方
    self.owner_name.text = _activity.owner_name;
    //设置类型
    self.type.text = _activity.category_name;
    //设置地址
    self.address.numberOfLines = 0;
    self.address.text = _activity.address;
    //设置内容
    self.content.numberOfLines = 0;
    self.content.text = _activity.content;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取登录状态
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //如果已经登录
    if ([user boolForKey:@"loginState"]) {
        //获取收藏状态
        self.isCollectState = [[DataBase getInstance] selectActivityWithId:_activity.activity_id];
        //设置收藏状态
        [self setCollectState];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//设置约束值
- (void)updateViewConstraints{
    [super updateViewConstraints];
    //计算文本高度
    CGRect rect = [_activity.content boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    self.viewWidth.constant = self.view.frame.size.width - 40;
    self.viewHeight.constant = self.content.frame.origin.y + rect.size.height;
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
