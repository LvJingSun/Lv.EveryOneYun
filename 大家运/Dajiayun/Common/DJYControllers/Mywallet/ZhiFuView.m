//
//  ZhiFuView.m
//  Dajiayun
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ZhiFuView.h"

@implementation ZhiFuView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        
        self.iconImageview = image1;
        
        [self addSubview:image1];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame) + 5, 0, self.bounds.size.width * 0.5, self.bounds.size.height)];
        
        self.nameLabel = nameLabel;
        
        nameLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:nameLabel];
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.8, 0, 26, 28)];
        
        self.selectImageview = image2;
        
        [self addSubview:image2];
        
    }
    
    return self;
    
}

@end
