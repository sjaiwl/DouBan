//
//  UserController.m
//  DouBan
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserController.h"
#import "SDImageCache.h"
#import "MyMovieListController.h"
#import "MyActivityListController.h"
#import "LoginViewController.h"

@interface UserController ()<UIAlertViewDelegate>

@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,assign) BOOL loginState;

@end

@implementation UserController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        //设置标题
        self.navigationItem.title = @"我的";
        //设置tabBar
        self.tabBarItem.image = [UIImage imageNamed:@"user"];
        self.tabBarItem.title = @"我的";
        //初始化数组
        self.array = [NSMutableArray arrayWithObjects:@"我的活动",@"我的电影",@"清除缓存", nil];
        //设置右按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginOrExit:)];
        //设置标题属性
        NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
        //设置属性
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
        //设置登录状态
        [self viewWillAppear:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置背景
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userListCellReuse"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//设置分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _array.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userListCellReuse" forIndexPath:indexPath];
    // Configure the cell...
    //设置辅助样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置标题
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}
//设置cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self gotoMyActivityView];
    }else if (indexPath.row == 1){
        [self gotoMyMovieView];
    }else{
        [self clearImageCache];
    }
    //清除tableview选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//登录事件
- (void)loginOrExit:(UIBarButtonItem *)sender{
    if (_loginState) {
        //注销
        //初始化弹窗
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认注销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.tag = 101;
        //显示弹框
        [alertView show];
    }else{
        //登录
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        //模态显示
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}
//进入我的活动页面
- (void)gotoMyActivityView{
    if (_loginState) {
        MyActivityListController *activity = [[MyActivityListController alloc] init];
        //设置push隐藏tabbar
        activity.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activity animated:YES];
    }else{
        //登录
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        //模态显示
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}
//进入我的电影页面
- (void)gotoMyMovieView{
    if (_loginState) {
        MyMovieListController *movie = [[MyMovieListController alloc] init];
        //设置push隐藏tabbar
        movie.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:movie animated:YES];
    }else{
        //登录
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        //模态显示
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}
//清除缓存
- (void)clearImageCache{
    //计算缓存大小
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat cache = size / 1024.0 / 1024.0;
    //字符串
    NSString *str = [NSString stringWithFormat:@"%.2fM",cache];
    //初始化弹窗
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = 102;
    //显示弹框
    [alertView show];

}
//alertview点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //确认注销
    if (alertView.tag == 101 && buttonIndex == 1) {
        //注销
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setBool:NO forKey:@"loginState"];
        //设置登录状态
        [self viewWillAppear:YES];
    }
    //确认清除
    if (alertView.tag == 102 && buttonIndex == 1) {
        //清除缓存
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    //获取登录状态
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *str = nil;
    self.loginState = [user boolForKey:@"loginState"];
    if (_loginState == YES) {
        str = @"注销";
    }else{
        str = @"登录";
    }
    self.navigationItem.rightBarButtonItem.title = str;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
