//
//  RegisterViewController.h
//  DouBan
//
//  Created by lanou3g on 15/9/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
//用户名
@property (strong, nonatomic) IBOutlet UITextField *name;
//密码
@property (strong, nonatomic) IBOutlet UITextField *password;
//确认密码
@property (strong, nonatomic) IBOutlet UITextField *confirmPass;
//邮箱
@property (strong, nonatomic) IBOutlet UITextField *email;
//电话
@property (strong, nonatomic) IBOutlet UITextField *phone;

@end
