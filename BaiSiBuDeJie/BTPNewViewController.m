//
//  BTPNewViewController.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/3/29.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPNewViewController.h"

@interface BTPNewViewController ()

@end

@implementation BTPNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题图片
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonDidClick)];

}

- (void)tagButtonDidClick{
    BTPLogFunc;
}


@end
