//
//  BTPRecommendUserCell.m
//  BaiSiBuDeJie
//
//  Created by leeguoyu on 16/4/20.
//  Copyright © 2016年 leeguoyu. All rights reserved.
//

#import "BTPRecommendUserCell.h"
#import "BTPRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface BTPRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation BTPRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUser:(BTPRecommendUser *)user{
    
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
