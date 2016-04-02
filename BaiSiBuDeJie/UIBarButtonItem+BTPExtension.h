//
//  UIBarButtonItem+BTPExtension.h
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/2.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BTPExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlighterImage target:(id)target action:(SEL)action;

@end
