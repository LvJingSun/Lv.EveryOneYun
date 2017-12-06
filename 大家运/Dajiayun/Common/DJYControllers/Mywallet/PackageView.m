//
//  PackageView.m
//  Dajiayun
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "PackageView.h"

@implementation PackageView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:232/255. green:250/255. blue:234/255. alpha:1.];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.5)];
        
        self.nameLabel = nameLab;
        
        nameLab.textAlignment = NSTextAlignmentCenter;
        
        nameLab.textColor = [UIColor colorWithRed:44/255. green:51/255. blue:43/255. alpha:1.];
        
        nameLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:nameLab];
        
        UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * 0.5, self.bounds.size.width, self.bounds.size.height * 0.5)];
        
        self.priceLabel = priceLab;
        
        priceLab.textAlignment = NSTextAlignmentCenter;
        
        priceLab.textColor = [UIColor colorWithRed:223/255. green:155/255. blue:99/255. alpha:1.];
        
        priceLab.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:priceLab];
        
    }
    
    return self;
    
}

@end
