//
//  BTPTabBar.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/3/30.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPTabBar.h"

@interface BTPTabBar()
@property (nonatomic, weak) UIButton * publishButton;

@end

@implementation BTPTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];

        [self addSubview:publishButton];
        
        self.publishButton = publishButton;

    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置发布按钮的frame
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);

    
    //设置其它UITabBarButton的frame
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5.0;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    
    for (UIView * button in self.subviews) {
        
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : (index));
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;

    }
    
}

@end
