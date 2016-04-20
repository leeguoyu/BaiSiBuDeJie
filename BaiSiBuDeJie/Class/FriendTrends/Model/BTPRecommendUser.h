//
//  BTPRecommendUser.h
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/21.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString * header;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString * screen_name;

@end
