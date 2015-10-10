//
//  CinemaDetailsListController.m
//  DouBan
//
//  Created by lanou3g on 15/8/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaDetailsListController.h"
#import "HttpClientRequest.h"
#import "AppUrl.h"
#import "CinemaDetailsTableViewCell.h"
#import "BroadCast.h"
#import "Movie.h"
#import "UIImageView+WebCache.h"
#import "HeaderCell.h"

@interface CinemaDetailsListController ()
//数组
@property (nonatomic,retain) NSArray *array;

@end

@implementation CinemaDetailsListController


- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        //设置左按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack:)];
           }
    
    return self;
}

//返回事件
- (void)clickBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"CinemaDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cinemaDetailsCellReuse"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"headerCellReuse"];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"headerCellReuse"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //设置标题
    self.navigationItem.title = _cinema.cinemaName;
    //数据请求
    NSString *str = [NSString stringWithFormat:@"cinemaId=%@",_cinema.cinemaId];
    //请求地址
    NSString *path = [NSString stringWithFormat:@"%@?%@",[AppUrl getInstance].cinemaDetailsUrl,str];
    __weak __typeof(self) weakSelf = self;
    //请求
    [HttpClientRequest getHttpClientRequestBlock:path andCompleteHandle:^(NSData *data, NSError *error) {
        if (data == nil) {
            return;
        }
        //解析数据
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        weakSelf.array = dic1[@"result"][@"lists"];
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
    return _array.count;
}
//设置分组标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //设置header
    HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCellReuse"];
    //设置图片
    [cell.image sd_setImageWithURL:[NSURL URLWithString:_array[section][@"pic_url"]] placeholderImage:[UIImage imageNamed:@"picholder"]];
    //设置名称
    cell.name.text = _array[section][@"movieName"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //获取分组数组
    NSArray *arr = _array[section][@"broadcast"];
    return arr.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cinemaDetailsCellReuse" forIndexPath:indexPath];
    // Configure the cell...
    //获取分组的数组
    NSArray *arr = _array[indexPath.section][@"broadcast"];
    //获取某一行信息
    NSDictionary *dic1 = arr[indexPath.row];
    //转化
    BroadCast *broad = [BroadCast new];
    [broad setValuesForKeysWithDictionary:dic1];
    //赋值
    cell.broad = broad;
    return cell;
}
//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCinemaDetailsCellHeight;
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
