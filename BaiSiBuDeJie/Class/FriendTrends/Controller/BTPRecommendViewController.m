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

@interface BTPRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 左边的类别数据 */
@property (nonatomic, strong) NSArray * categories;
//** 左边的类别列表表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 右边的用户数据 */
@property (nonatomic, strong) NSArray * users;
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
        return self.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        BTPRecommendCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:BTPCategoryCellId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;

    }else{
        BTPRecommendUserCell * cell = [tableView dequeueReusableCellWithIdentifier:BTPUserCellId];
        cell.user = self.users[indexPath.row];
        return cell;
    }
}

#pragma mark - 表格的点击事件 <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BTPRecommendCategory * c = self.categories[indexPath.row];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        [SVProgressHUD show];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        self.users = [BTPRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
    
        [self.userTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BTPLog(@"%@", error);
    }];
    
}


@end
