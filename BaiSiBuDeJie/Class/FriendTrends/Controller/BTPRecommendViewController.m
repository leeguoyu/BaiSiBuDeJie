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

@interface BTPRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 左边的类别数据 */
@property (nonatomic, strong) NSArray * categories;

//** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation BTPRecommendViewController

static NSString * const BTPCategoryCellId = @"category";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    self.view.backgroundColor = BTPGlobalBackgoundColor;
    
    //注册cell xib
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BTPRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:BTPCategoryCellId];
    
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


#pragma mark - 创建左侧表格

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    BTPRecommendCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:BTPCategoryCellId];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
    
}


@end
