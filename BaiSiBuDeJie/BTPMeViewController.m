//
//  BTPMeViewController.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/3/29.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPMeViewController.h"

@interface BTPMeViewController ()

@end

@implementation BTPMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边的按钮
    UIBarButtonItem * settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonDidClick)];
    
    UIBarButtonItem * nighModeButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(nightModeButtonDidClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingButton, nighModeButton];

}

- (void)settingButtonDidClick{
    BTPLogFunc;
}

- (void)nightModeButtonDidClick{
    
    BTPLogFunc;
}


@end
