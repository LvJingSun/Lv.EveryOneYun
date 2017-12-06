//
//  ViaCityCollectionCell.m
//  Dajiayun
//
//  Created by CityAndCity on 16/1/31.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ViaCityCollectionCell.h"

@implementation ViaCityCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 64/2-12, 25, 25)];
        self.imgView.image = [UIImage imageNamed:@"chengshi"];
        [self addSubview:self.imgView];
        
        self.tuJingChengShiUITextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 64/2-15, self.frame.size.width-40, 30)];
        self.tuJingChengShiUITextField.enabled = NO;
        self.tuJingChengShiUITextField.font = [UIFont systemFontOfSize:12];
        self.tuJingChengShiUITextField.textAlignment =NSTextAlignmentCenter;
        self.tuJingChengShiUITextField.placeholder = @"途经城市";
        [self addSubview:self.tuJingChengShiUITextField];
        
        _close  = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * image = [UIImage imageNamed:@"delete"];
        [_close setImage:image forState:UIControlStateNormal];
        [_close setFrame:CGRectMake(self.frame.size.width-image.size.width, 0, image.size.width, image.size.height)];
        [_close sizeToFit];
        [_close addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_close];
    }
    return self;
}

-(void)closeBtn:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(moveImageBtnClick:)]) {
        [_delegate moveImageBtnClick:self];
    }
}


@end
