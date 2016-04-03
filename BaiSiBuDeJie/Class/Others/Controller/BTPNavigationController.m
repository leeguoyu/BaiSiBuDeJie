//
//  BTPNavigationController.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/3.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPNavigationController.h"

@implementation BTPNavigationController

//初始化，只执行一次，好处是节省资源
+ (void)initialize{
    
    //设置导航栏背景图片
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    

}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        //导航栏返回按钮
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        //按钮文字
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        //按钮图片
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.bounds = CGRectMake(0, 0, 60, 30);
        
        //按钮左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        //按钮点击事件
        [button addTarget:self action:@selector(backButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        //添加按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //push时隐藏底栏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backButtonDidClick{
    
    [self popViewControllerAnimated:YES];
}

@end
