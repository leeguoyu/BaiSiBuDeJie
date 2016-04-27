//
//  BTPRecommendCategory.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/3.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPRecommendCategory.h"

@implementation BTPRecommendCategory

-(NSMutableArray *)users{
    
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}


@end
