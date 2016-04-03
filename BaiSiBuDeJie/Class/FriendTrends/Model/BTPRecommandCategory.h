//
//  BTPRecommandCategory.h
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/3.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPRecommandCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger * id;
/** 总数 */
@property (nonatomic, assign) NSInteger * count;
/** 名字 */
@property (nonatomic, copy) NSString * name;

@end
