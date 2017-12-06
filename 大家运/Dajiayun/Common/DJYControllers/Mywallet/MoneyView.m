//
//  MoneyView.m
//  Dajiayun
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "MoneyView.h"


@interface MoneyView ()



@end

@implementation MoneyView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGSize size = self.bounds.size;
        
        UILabel *first = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.1, size.height * 0.1, size.width * 0.2, size.height * 0.2)];
        
        first.text = @"1";
        
        first.textColor = [UIColor blackColor];
        
        first.textAlignment = NSTextAlignmentCenter;
        
        self.first = first;
        
        [self addSubview:first];
        
        UILabel *balanceLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.1, size.height * 0.4, size.width * 0.2, size.height * 0.2)];
        
        balanceLab.text = @"余额";
        
        balanceLab.font = [UIFont systemFontOfSize:12];
        
        balanceLab.textColor = [UIColor grayColor];
        
        balanceLab.textAlignment = NSTextAlignmentCenter;
        
        self.balanceLab = balanceLab;
        
        [self addSubview:balanceLab];
        
        UILabel *balanceMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.1, size.height * 0.7, size.width * 0.2, size.height * 0.2)];
        
        balanceMoneyLab.text = [NSString stringWithFormat:@"¥0.00"];
        
        balanceMoneyLab.textColor = [UIColor blackColor];
        
        balanceMoneyLab.textAlignment = NSTextAlignmentCenter;
        
        balanceMoneyLab.font = [UIFont systemFontOfSize:12];
        
        self.balanceMoneyLab = balanceMoneyLab;
        
        [self addSubview:balanceMoneyLab];
        
        UILabel *second = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.4, size.height * 0.1, size.width * 0.2, size.height * 0.2)];
        
        second.text = @"2";
        
        second.textColor = [UIColor colorWithRed:15./255 green:116./255 blue:29./255 alpha:1.];
        
        second.textAlignment = NSTextAlignmentCenter;
        
        self.second = second;
        
        [self addSubview:second];
        
        UILabel *incomeLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.4, size.height * 0.4, size.width * 0.2, size.height * 0.2)];
        
        incomeLab.text = @"总收入";
        
        incomeLab.font = [UIFont systemFontOfSize:12];
        
        incomeLab.textColor = [UIColor grayColor];
        
        incomeLab.textAlignment = NSTextAlignmentCenter;
        
        self.incomeLab = incomeLab;
        
        [self addSubview:incomeLab];
        
        UILabel *incomeMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.4, size.height * 0.7, size.width * 0.2, size.height * 0.2)];
        
        incomeMoneyLab.text = [NSString stringWithFormat:@"¥0.00"];
        
        incomeMoneyLab.textColor = [UIColor colorWithRed:15./255 green:116./255 blue:29./255 alpha:1.];
        
        incomeMoneyLab.textAlignment = NSTextAlignmentCenter;
        
        incomeMoneyLab.font = [UIFont systemFontOfSize:12];
        
        self.incomeMoneyLab = incomeMoneyLab;
        
        [self addSubview:incomeMoneyLab];
        
        UILabel *third = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.7, size.height * 0.1, size.width * 0.2, size.height * 0.2)];
        
        third.text = @"3";
        
        third.textColor = [UIColor redColor];
        
        third.textAlignment = NSTextAlignmentCenter;
        
        self.third = third;
        
        [self addSubview:third];
        
        UILabel *expenditureLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.7, size.height * 0.4, size.width * 0.2, size.height * 0.2)];
        
        expenditureLab.text = @"总支出";
        
        expenditureLab.font = [UIFont systemFontOfSize:12];
        
        expenditureLab.textColor = [UIColor grayColor];
        
        expenditureLab.textAlignment = NSTextAlignmentCenter;
        
        self.expenditureLab = expenditureLab;
        
        [self addSubview:expenditureLab];
        
        UILabel *expenditureMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.7, size.height * 0.7, size.width * 0.2, size.height * 0.2)];
        
        expenditureMoneyLab.text = [NSString stringWithFormat:@"¥0.00"];
        
        expenditureMoneyLab.textColor = [UIColor redColor];
        
        expenditureMoneyLab.textAlignment = NSTextAlignmentCenter;
        
        expenditureMoneyLab.font = [UIFont systemFontOfSize:12];
        
        self.expenditureMoneyLab = expenditureMoneyLab;
        
        [self addSubview:expenditureMoneyLab];

        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
}

@end
