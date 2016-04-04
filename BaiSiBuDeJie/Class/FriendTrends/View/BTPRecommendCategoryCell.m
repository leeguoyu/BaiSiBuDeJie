//
//  BTPRecommendCategoryCell.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/3.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPRecommendCategoryCell.h"
#import "BTPRecommendCategory.h"

@interface BTPRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation BTPRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBColor(244, 244, 244);
}

- (void)setCategory:(BTPRecommendCategory *)category{
    
    _category = category;
    
    self.textLabel.text = category.name;
}

//设置选中时的样式

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? [UIColor redColor] : RGBColor(77, 77, 77);
}
@end
