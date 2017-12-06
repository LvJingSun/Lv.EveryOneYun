//
//  ContentView.m
//  Dajiayun
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        CGSize size = self.bounds.size;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, size.width * 0.3, (size.height - 35) * 0.16)];
        
        self.Label1 = label1;
        
        label1.textColor = [UIColor darkGrayColor];
        
        label1.font = [UIFont systemFontOfSize:14];
        
        label1.text = @"到账支付宝";
        
        [self addSubview:label1];
        
        UITextField *type = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 5, size.width * 0.7 - 10, (size.height - 35) * 0.16 - 1)];
        
        self.type = type;
        
        [self addSubview:type];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(type.frame), size.width * 0.7 - 10, 1)];
        
        line1.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label1.frame) + 5, size.width * 0.3, (size.height - 35) * 0.16)];
        
        self.Label2 = label2;
        
        label2.textColor = [UIColor darkGrayColor];
        
        label2.font = [UIFont systemFontOfSize:14];
        
        label2.text = @"账户名";
        
        [self addSubview:label2];
        
        UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), CGRectGetMaxY(label1.frame) + 5, size.width * 0.7 - 10, (size.height - 35) * 0.16 - 1)];
        
        self.name = name;
        
        [self addSubview:name];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), CGRectGetMaxY(name.frame), size.width * 0.7 - 10, 1)];
        
        line2.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label2.frame) + 5, size.width * 0.3, (size.height - 35) * 0.16)];
        
        self.Label3 = label3;
        
        label3.textColor = [UIColor darkGrayColor];
        
        label3.font = [UIFont systemFontOfSize:14];
        
        label3.text = @"开户行";
        
        [self addSubview:label3];
        
        UITextField *kaihu = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), CGRectGetMaxY(label2.frame) + 5, size.width * 0.7 - 10, (size.height - 35) * 0.16 - 1)];
        
        self.kaihu = kaihu;
        
        [self addSubview:kaihu];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), CGRectGetMaxY(kaihu.frame), size.width * 0.7 - 10, 1)];
        
        line3.backgroundColor = [UIColor grayColor];
        
        self.Line3 = line3;
        
        [self addSubview:line3];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label3.frame) + 5, size.width * 0.3, (size.height - 35) * 0.16)];
        
        self.Label4 = label4;
        
        label4.textColor = [UIColor blackColor];
        
        label4.font = [UIFont systemFontOfSize:14];
        
        label4.text = @"提现金额";
        
        [self addSubview:label4];
        
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label4.frame) + 5, size.width * 0.1, (size.height - 35) * 0.16)];
        
        self.Label5 = label5;
        
        label5.textColor = [UIColor blackColor];
        
        label5.font = [UIFont systemFontOfSize:14];
        
        label5.text = @"¥";
        
        label5.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label5];
        
        UITextField *count = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame), CGRectGetMaxY(label4.frame) + 5, size.width * 0.9 - 10, (size.height - 35) * 0.16 - 1)];
        
        self.count = count;
        
        [self addSubview:count];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame), CGRectGetMaxY(count.frame), size.width * 0.9 - 10, 1)];
        
        line4.backgroundColor = [UIColor grayColor];
        
        self.Line4 = line4;
        
        [self addSubview:line4];
        
        UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label5.frame) + 5, size.width * 0.6, (size.height - 35) * 0.16)];
        
        self.Label6 = label6;
        
        label6.textColor = [UIColor lightGrayColor];
        
        label6.font = [UIFont systemFontOfSize:15];
        
        label6.text = @"账户余额¥1000";
        
        [self addSubview:label6];
        
    }
    
    return self;
    
}

- (void)resignFirst {

    [self.type resignFirstResponder];
    
    [self.name resignFirstResponder];
    
    [self.kaihu resignFirstResponder];
    
    [self.count resignFirstResponder];
    
}

@end
