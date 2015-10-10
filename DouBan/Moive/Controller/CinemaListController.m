//
//  CinemaListController.m
//  DouBan
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaListController.h"
#import "SDImageCache.h"
#import "Cinema.h"
#import "CinemaTableViewCell.h"
#import "HttpClientRequest.h"
#import "AppUrl.h"
#import "JSONKit.h"
#import "CinemaDetailsListController.h"

@interface CinemaListController ()

@property (nonatomic,retain) NSMutableArray *array;

@end

@implementation CinemaListController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        //设置标题
        self.navigationItem.title = @"影院";
        //设置tabBar
        self.tabBarItem.image = [UIImage imageNamed:@"cinema"];
        self.tabBarItem.title = @"影院";
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
    [self.tableView registerNib:[UINib nibWithNibName:@"CinemaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cinemaCellReuse"];
    //设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //请求数据
    [self getDataRequest];
}

//数据请求
- (void)getDataRequest{
    __weak __typeof(self) weakSelf = self;
    //数据请求
    [HttpClientRequest getHttpClientRequestBlock:[AppUrl getInstance].cinemaUrl andCompleteHandle:^(NSData *data, NSError *error) {
        if (data == nil) {
            return;
        }
        //解析数据
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *dic2 = dic1[@"result"][@"data"];
        //初始化数组
        weakSelf.array = [NSMutableArray array];
        //数据处理
        for (NSDictionary *dic3 in dic2) {
            Cinema *cinema = [Cinema new];
            [cinema setValuesForKeysWithDictionary:dic3];
            [weakSelf.array addObject:cinema];
        }
        //刷新数据
        [weakSelf.tableView reloadData];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//设置分区数
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
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cinemaCellReuse" forIndexPath:indexPath];
    // Configure the cell...
    cell.cinema = _array[indexPath.row];
    return cell;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCinemaCellHeight;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Cinema *cinema = _array[indexPath.row];
    //跳转界面
    CinemaDetailsListController *detailsController = [[CinemaDetailsListController alloc] init];
    //传值
    detailsController.cinema = cinema;
    //push
    detailsController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsController animated:YES];
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
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
