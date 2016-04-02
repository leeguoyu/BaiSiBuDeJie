//
//  BTPFriendTrendsViewController.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/3/29.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPFriendTrendsViewController.h"

@interface BTPFriendTrendsViewController ()

@end

@implementation BTPFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题图片
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左侧按钮
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommendIcon" highlightedImage:@"friendsRecommendIcon-click" target:self action:@selector(recommandButtonDidClick)];
}

- (void)recommandButtonDidClick{
    
    BTPLogFunc;
}

@end
