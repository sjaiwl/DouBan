//
//  LoginViewController.m
//  DouBan
//
//  Created by lanou3g on 15/9/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //设置标题
        self.navigationItem.title = @"用户登录";
        //设置返回按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBack:)];
    }
    return self;
}
//返回事件
- (void)clickBack:(UIBarButtonItem *)sender{
    //结束编辑
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//登录事件
- (IBAction)login:(UIButton *)sender {
    //判断用户名和密码是否为空
    if (_name.text == nil || [_name.text isEqualToString:@""] || _password.text == nil || [_password.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    //结束编辑
    [self.view endEditing:YES];
    //获取存储数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userName = [user objectForKey:@"name"];
    NSString *userPassword = [user objectForKey:@"password"];
    if ([userName isEqualToString:_name.text] && [userPassword isEqualToString:_password.text]) {
        //登陆成功
        [user setBool:YES forKey:@"loginState"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //登录失败
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//注册事件
- (IBAction)regist:(UIButton *)sender {
    //注册
    RegisterViewController *regist = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置圆角
    self.login.layer.masksToBounds = YES;
    self.login.layer.cornerRadius = 5;
    self.regist.layer.masksToBounds = YES;
    self.regist.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
