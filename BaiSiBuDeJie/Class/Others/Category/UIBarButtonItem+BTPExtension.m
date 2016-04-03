//
//  UIBarButtonItem+BTPExtension.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/2.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "UIBarButtonItem+BTPExtension.h"

@implementation UIBarButtonItem (BTPExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action{
    
    //设置导航栏左侧按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    
    button.bounds = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    //设置左侧按钮点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];

}

@end
