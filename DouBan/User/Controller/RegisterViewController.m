//
//  RegisterViewController.m
//  DouBan
//
//  Created by lanou3g on 15/9/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //设置标题
        self.navigationItem.title = @"用户注册";
        //设置右按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regist:)];
    }
    return self;
}
//注册事件
- (void)regist:(UIBarButtonItem *)sender{
    //判断用户名和密码是否为空
    if (_name.text == nil || [_name.text isEqualToString:@""] || _password.text == nil || [_password.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    //判断两次输入的密码是否一致
    if (![_password.text isEqualToString:_confirmPass.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"message:@"两次输入密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    //结束编辑
    [self.view endEditing:YES];
    //存储数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:_name.text forKey:@"name"];
    [user setObject:_password.text forKey:@"password"];
    [user setObject:_email.text forKey:@"email"];
    [user setObject:_phone.text forKey:@"phone"];
    //返回登录
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
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
