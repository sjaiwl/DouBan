//
//  LoginViewController.h
//  DouBan
//
//  Created by lanou3g on 15/9/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

//用户名
@property (strong, nonatomic) IBOutlet UITextField *name;
//密码
@property (strong, nonatomic) IBOutlet UITextField *password;
//登录
@property (strong, nonatomic) IBOutlet UIButton *login;
//注册
@property (strong, nonatomic) IBOutlet UIButton *regist;

@end
