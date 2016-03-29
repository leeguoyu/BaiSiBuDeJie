//
//  BTPTabBarController.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/3/29.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPTabBarController.h"
#import "BTPEssenceViewController.h"
#import "BTPNewViewController.h"
#import "BTPFriendTrendsViewController.h"
#import "BTPMeViewController.h"

@interface BTPTabBarController ()

@end

@implementation BTPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabbar 的 appearance
    //后面带有 UI_APPEARANCE_SELECTOR 的方法，都可以统一设置属性
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12.0];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem * tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //添加子控制器 children controller
    
    [self setupChildVC:[BTPEssenceViewController alloc] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVC:[BTPNewViewController alloc] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVC:[BTPFriendTrendsViewController alloc] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVC:[BTPMeViewController alloc] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}

//子控制器的实现方法
//甚至可以传一个UIViewController进来，这样上面调用时，便可以随意传任意类型的控制器
-(void)setupChildVC: (UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {

    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    [self addChildViewController:vc];

}

@end
