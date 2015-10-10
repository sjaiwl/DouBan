//
//  MoiveListController.m
//  DouBan
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MoiveListController.h"
#import "Movie.h"
#import "MovieListCell.h"
#import "HttpClientRequest.h"
#import "AppUrl.h"
#import "MovieDetailsController.h"
#import "MovieCollectionCell.h"

#import "AFNetworking.h"

@interface MoiveListController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) BOOL isList;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) UICollectionView *colectionView;
@property (nonatomic,retain) NSMutableArray *array;

@end

@implementation MoiveListController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        //设置标题
        self.navigationItem.title = @"电影";
        //设置tabBar
        self.tabBarItem.image = [UIImage imageNamed:@"movie"];
        self.tabBarItem.title = @"电影";
        //设置右按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(changeList:)];
        self.isList = YES;
    }
    
    return self;
}

//切换显示方式
- (void)changeList:(UIBarButtonItem *)sender{
    if (_isList) {
        _isList = NO;
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"btn_nav_list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //添加表格视图
//        [self.view addSubview:_colectionView];
        //添加过渡动画
        [UIView transitionFromView:_tableView toView:_colectionView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        }];
    }else{
        _isList = YES;
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"btn_nav_collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //移除表格显示
//        [_colectionView removeFromSuperview];
        //添加过渡动画
        [UIView transitionFromView:_colectionView toView:_tableView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置背景
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    //设置tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - (49 + 44 + 20))];
    //设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置数据源和代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"movieCellReuse"];
    //添加视图
    [self.view addSubview:_tableView];
    
    //设置collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.colectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - (49 + 44 + 20)) collectionViewLayout:flowLayout];
    //设置数据源和代理
    self.colectionView.dataSource = self;
    self.colectionView.delegate = self;
    //设置背景颜色
    self.colectionView.backgroundColor = [UIColor whiteColor];
    //注册
    [self.colectionView registerNib:[UINib nibWithNibName:@"MovieCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"movieCollectionCellReuse"];
    //数据请求
    [self getDataRequest];
}

//数据请求
- (void)getDataRequest{
    __weak __typeof(self) weakSelf = self;
    //数据请求
    [HttpClientRequest getHttpClientRequestBlock:[AppUrl getInstance].movieUrl andCompleteHandle:^(NSData *data, NSError *error) {
        if (data == nil) {
            return;
        }
        //数据解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //获取数组
        NSArray *arr = dic[@"result"];
        weakSelf.array = [NSMutableArray array];
        //处理数据
        for (NSDictionary *dict in arr) {
            Movie *movie = [Movie new];
            [movie setValuesForKeysWithDictionary:dict];
            [weakSelf.array addObject:movie];
        }
        //刷新tableview和collectionView
        [weakSelf.tableView reloadData];
        [weakSelf.colectionView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview 数据源和代理
//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell
    MovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCellReuse" forIndexPath:indexPath];
    //传递数据
    cell.movie = _array[indexPath.row];
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMovieCell;
}
//row点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailsController *details = [[MovieDetailsController alloc] init];
    //属性传值
    Movie *movie = _array[indexPath.row];
    details.movie = movie;
    //设置push是隐藏tabbar
    details.hidesBottomBarWhenPushed = YES;
    //push界面
    [self.navigationController pushViewController:details animated:YES];
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}


#pragma mark - collectionView的数据源和代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}
//设置cell
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCollectionCellReuse" forIndexPath:indexPath];
    Movie *movie = _array[indexPath.row];
    cell.movie = movie;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 180);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15 ,15);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailsController *details = [[MovieDetailsController alloc] init];
    //属性传值
    Movie *movie = _array[indexPath.row];
    details.movie = movie;
    //设置push是隐藏tabbar
    details.hidesBottomBarWhenPushed = YES;
    //push界面
    [self.navigationController pushViewController:details animated:YES];
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
