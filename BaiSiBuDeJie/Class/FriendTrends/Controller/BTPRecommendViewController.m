//
//  BTPRecommendViewController.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/3.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "BTPRecommendCategoryCell.h"
#import <MJExtension.h>
#import "BTPRecommendCategory.h"
#import "BTPRecommendUserCell.h"
#import "BTPRecommendUser.h"
#import <MJRefresh.h>

//类别被选中后，右边的用户数据
#define BTPSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface BTPRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 左边的类别数据 */
@property (nonatomic, strong) NSArray * categories;
//** 左边的类别列表表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

//** 右边的用户列表表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation BTPRecommendViewController

static NSString * const BTPCategoryCellId = @"category";
static NSString * const BTPUserCellId = @"user";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableview
    [self setupTableView];
    
    //右侧表格添加刷新控件
    [self setupRefresh];

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        [SVProgressHUD show];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        //成功之后加载数据
        self.categories = [BTPRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        //选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"@%@", error);
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
}

#pragma mark - 添加刷新控件
- (void)setupRefresh{
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
    
}

#pragma mark - 右边表格加在更多用户
- (void)loadMoreUsers{
    
    BTPRecommendCategory *category = BTPSelectedCategory;
    
    //加在右侧数据
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @"2";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组 -> 模型数组
        NSArray * users = [BTPRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        //添加到当前类别对应的数组中
        [category.users addObjectsFromArray:users];
        
        [self.userTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BTPLog(@"%@", error);
    }];
    

}

#pragma mark - setupTableView

- (void)setupTableView{
    
    self.title = @"推荐关注";
    self.view.backgroundColor = BTPGlobalBackgoundColor;
    
    //注册cell xib
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BTPRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:BTPCategoryCellId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BTPRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:BTPUserCellId];
    
    //设置位移
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
}

#pragma mark - 创建表格 <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else{
        //每次刷新右边表格时，判断是否需要隐藏刷新提示
        self.userTableView.mj_footer.hidden = ([BTPSelectedCategory users].count == 0);
        
        return [BTPSelectedCategory users].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        BTPRecommendCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:BTPCategoryCellId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;

    }else{
        BTPRecommendUserCell * cell = [tableView dequeueReusableCellWithIdentifier:BTPUserCellId];
        
        cell.user = [BTPSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - 表格的点击事件 <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([BTPSelectedCategory users].count) {
        //显示曾经的数据
        [self.userTableView reloadData];
        
    }else{
        //加在右侧数据
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @([BTPSelectedCategory id]);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
            [SVProgressHUD show];
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [SVProgressHUD dismiss];
            
            //字典数组 -> 模型数组
            NSArray * users = [BTPRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            //添加到当前类别对应的数组中
            [[BTPSelectedCategory users] addObjectsFromArray:users];
            
            [self.userTableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            BTPLog(@"%@", error);
        }];

    }
}


@end
