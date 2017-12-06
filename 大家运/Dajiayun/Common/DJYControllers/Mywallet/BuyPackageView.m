//
//  BuyPackageView.m
//  Dajiayun
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "BuyPackageView.h"
#import "PackageView.h"
#import "ZhiFuView.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation BuyPackageView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat zhanghaoX = SCREEN_WIDTH * 0.05;
        
        CGFloat zhanghaoY = 10;
        
        CGFloat zhanghaoW = SCREEN_WIDTH * 0.2;
        
        CGFloat zhanghaoH = 30;
        
        UILabel *zhanghaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhanghaoX, zhanghaoY, zhanghaoW, zhanghaoH)];
        
        zhanghaoLabel.textColor = [UIColor colorWithRed:23/255. green:184/255. blue:71/255. alpha:1.];
        
        zhanghaoLabel.text = @"开通账号:";
        
        [self addSubview:zhanghaoLabel];
        
        CGFloat phoneX = CGRectGetMaxX(zhanghaoLabel.frame) + 10;
        
        CGFloat phoneY = zhanghaoY;
        
        CGFloat phoneW = SCREEN_WIDTH * 0.7 - 10;
        
        CGFloat phoneH = zhanghaoH;
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneW, phoneH)];
        
        phoneLabel.textColor = [UIColor colorWithRed:77/255. green:77/255. blue:77/255. alpha:1.];
        
        phoneLabel.font = [UIFont systemFontOfSize:15];
        
        phoneLabel.text = @"13951284556";
        
        [self addSubview:phoneLabel];
        
        CGFloat line1X = SCREEN_WIDTH * 0.05;
        
        CGFloat line1Y = CGRectGetMaxY(zhanghaoLabel.frame) + 10;
        
        CGFloat line1W = SCREEN_WIDTH * 0.9;
        
        CGFloat line1H = 1;
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(line1X, line1Y, line1W, line1H)];
        
        line1.backgroundColor = [UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.];
        
        [self addSubview:line1];
        
        CGFloat modelX = zhanghaoX;
        
        CGFloat modelY = CGRectGetMaxY(line1.frame) + 15;
        
        CGFloat modelW = zhanghaoW;
        
        CGFloat modelH = zhanghaoH;
        
        UILabel *model = [[UILabel alloc] initWithFrame:CGRectMake(modelX, modelY, modelW, modelH)];
        
        model.textColor = zhanghaoLabel.textColor;
        
        model.text = @"付款模式:";
        
        [self addSubview:model];
        
        CGFloat pView1X = phoneX;
        
        CGFloat pView1Y = CGRectGetMaxY(line1.frame) + 10;
        
        CGFloat pView1W = (phoneW - 10) * 0.3333;
        
        CGFloat pView1H = 40;
        
        PackageView *view1 = [[PackageView alloc] initWithFrame:CGRectMake(pView1X, pView1Y, pView1W, pView1H)];
        
        view1.nameLabel.text = @"按次收费";
        
        view1.priceLabel.text = @"1元/1次";
        
        [self addSubview:view1];
        
        UIButton *model1Btn = [[UIButton alloc] initWithFrame:CGRectMake(pView1X, pView1Y, pView1W, pView1H)];
        
        self.model1Btn = model1Btn;
        
        [self addSubview:model1Btn];
        
        PackageView *view2 = [[PackageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame) + 5, pView1Y, pView1W, pView1H)];
        
        view2.nameLabel.text = @"按月收费";
        
        view2.priceLabel.text = @"50元/1月";
        
        [self addSubview:view2];
        
        UIButton *model2Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame) + 5, pView1Y, pView1W, pView1H)];
        
        self.model2Btn = model2Btn;
        
        [self addSubview:model2Btn];
        
        PackageView *view3 = [[PackageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view2.frame) + 5, pView1Y, pView1W, pView1H)];
        
        view3.nameLabel.text = @"按年收费";
        
        view3.priceLabel.text = @"365元/1年";
        
        [self addSubview:view3];
        
        UIButton *model3Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view2.frame) + 5, pView1Y, pView1W, pView1H)];
                               
        self.model3Btn = model3Btn;
        
        [self addSubview:model3Btn];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(line1X, CGRectGetMaxY(model.frame) + 15, line1W, line1H)];
        
        line2.backgroundColor = line1.backgroundColor;
        
        [self addSubview:line2];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhanghaoX, CGRectGetMaxY(line2.frame) + 10, zhanghaoW, zhanghaoH)];
        
        timeLabel.textColor = zhanghaoLabel.textColor;
        
        timeLabel.text = @"开通数量:";
        
        [self addSubview:timeLabel];
        
        UITextField *countField = [[UITextField alloc] initWithFrame:CGRectMake(phoneX, CGRectGetMaxY(line2.frame) + 10, zhanghaoW, zhanghaoH)];
        
        countField.text = @"3";
        
        self.countField = countField;
        
        countField.layer.borderColor = [UIColor colorWithRed:208/255. green:208/255. blue:208/255. alpha:1.].CGColor;
        
        countField.layer.borderWidth = 1;
        
        UIView *paddingview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, zhanghaoH)];
        
        countField.leftView = paddingview;
        
        countField.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:countField];
        
        UILabel *ciLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(countField.frame), CGRectGetMaxY(line2.frame) + 10, 20, zhanghaoH)];
        
        ciLabel.text = @"次";
        
        ciLabel.textColor = zhanghaoLabel.textColor;
        
        [self addSubview:ciLabel];
        
        UILabel *daoqiTime = [[UILabel alloc] initWithFrame:CGRectMake(phoneX, CGRectGetMaxY(countField.frame), SCREEN_WIDTH * 0.6, 20)];
        
        daoqiTime.textColor = [UIColor colorWithRed:159/255. green:159/255. blue:159/255. alpha:1.];
        
        daoqiTime.text = @"生效时间:5月25日";
        
        daoqiTime.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:daoqiTime];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(line1X, CGRectGetMaxY(daoqiTime.frame), line1W, line1H)];
        
        line3.backgroundColor = line1.backgroundColor;
        
        [self addSubview:line3];
        
        UILabel *fukuan = [[UILabel alloc] initWithFrame:CGRectMake(zhanghaoX, CGRectGetMaxY(line3.frame) + 10, zhanghaoW, zhanghaoH)];
        
        fukuan.text = @"付款方式:";
        
        fukuan.textColor = zhanghaoLabel.textColor;
        
        [self addSubview:fukuan];
        
        ZhiFuView *weixin = [[ZhiFuView alloc] initWithFrame:CGRectMake(phoneX, CGRectGetMaxY(line3.frame) + 10, SCREEN_WIDTH * 0.3, 30)];
        
        weixin.nameLabel.text = @"微信支付";
        
        weixin.iconImageview.image = [UIImage imageNamed:@"微信.png"];
        
        weixin.layer.borderWidth = 1;
        
//        weixin.selectImageview.image = [UIImage imageNamed:@"选中.png"];
        
        weixin.layer.borderColor = line3.backgroundColor.CGColor;
        
        [self addSubview:weixin];
        
        UIButton *weixinBtn = [[UIButton alloc] initWithFrame:CGRectMake(phoneX, CGRectGetMaxY(line3.frame) + 10, SCREEN_WIDTH * 0.3, 30)];
        
        self.weixinBtn = weixinBtn;
        
        [self addSubview:weixinBtn];
        
        ZhiFuView *zhifubao = [[ZhiFuView alloc] initWithFrame:CGRectMake(phoneX, CGRectGetMaxY(weixin.frame) + 10, SCREEN_WIDTH * 0.3, 30)];
        
        zhifubao.nameLabel.text = @"支付宝";
        
        zhifubao.iconImageview.image = [UIImage imageNamed:@"支付宝-1.png"];
        
        zhifubao.layer.borderWidth = 1;
        
        zhifubao.layer.borderColor = line3.backgroundColor.CGColor;
        
        [self addSubview:zhifubao];
        
        UIButton *zhifubaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(phoneX, CGRectGetMaxY(weixin.frame) + 10, SCREEN_WIDTH * 0.3, 30)];
        
        self.zhifubaoBtn = zhifubaoBtn;
        
        [self addSubview:zhifubaoBtn];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(line1X, CGRectGetMaxY(zhifubao.frame) + 10, line1W, line1H)];
        
        line4.backgroundColor = line1.backgroundColor;
        
        [self addSubview:line4];
        
        UILabel *jine = [[UILabel alloc] initWithFrame:CGRectMake(zhanghaoX, CGRectGetMaxY(line4.frame) + 10, zhanghaoW, zhanghaoH)];
        
        jine.text = @"应付金额:";
        
        jine.textColor = zhanghaoLabel.textColor;
        
        [self addSubview:jine];
        
        UILabel *allPrice = [[UILabel alloc] initWithFrame:CGRectMake(phoneX, CGRectGetMaxY(line4.frame) + 10, phoneW, phoneH)];
        
        allPrice.textColor = phoneLabel.textColor;
        
        allPrice.text = @"3.0元";
        
        self.allPriceLabel = allPrice;
        
        [self addSubview:allPrice];
        
        UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(line1X, CGRectGetMaxY(allPrice.frame) + 10, line1W, line1H)];
        
        line5.backgroundColor = line1.backgroundColor;
        
        [self addSubview:line5];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(zhanghaoX, CGRectGetMaxY(line5.frame) + 40, SCREEN_WIDTH * 0.9, 50)];
        
        sureBtn.backgroundColor = zhanghaoLabel.textColor;
        
        [sureBtn setTitle:@"立即开通" forState:UIControlStateNormal];
        
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        sureBtn.layer.cornerRadius = 5;
        
        self.sureBtn = sureBtn;
        
        [self addSubview:sureBtn];
        
    }
    
    return self;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([self.countField isFirstResponder]) {
        
        [self.countField resignFirstResponder];
        
    }
}

@end
