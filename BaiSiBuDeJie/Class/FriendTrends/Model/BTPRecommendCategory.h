//
//  BTPRecommendCategory.h
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/3.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString * name;

/** 当前类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray * users;
/** 总页数 */
@property (nonatomic, assign) NSInteger total_page;
/** 该类别的总用户数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;




@end
