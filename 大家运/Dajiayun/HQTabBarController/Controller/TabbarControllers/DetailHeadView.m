//
//  DetailHeadView.m
//  Dajiayun
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "DetailHeadView.h"
#import "UILabel+LabelHeightAndWidth.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation DetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.isOpen = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        
        //头像
        
        CGFloat iconX = Size.width * 0.03;
        
        CGFloat iconY = iconX;
        
        CGFloat iconW = Size.width * 0.14;
        
        CGFloat iconH = iconW;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        [self setLayer:icon];
        
        self.iconImageview = icon;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:icon];
        
        //出发地
        
        CGFloat fromX = Size.width * 0.2;
        
        CGFloat fromY = iconY;
        
        CGFloat fromW = Size.width * 0.35;
        
        CGFloat fromH = iconH * 0.33;
        
        UILabel *from = [[UILabel alloc] initWithFrame:CGRectMake(fromX, fromY, fromW, fromH)];
        
        from.textAlignment = NSTextAlignmentCenter;
        
        from.textColor = [UIColor colorWithRed:161/255. green:161/255. blue:161/255. alpha:1.];
        
        from.text = @"出发地";
        
        from.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:from];
        
        CGFloat fromPlaceX = fromX;
        
        CGFloat fromPlaceY = CGRectGetMaxY(from.frame);
        
        CGFloat fromPlaceW = fromW;
        
        CGFloat fromPlaceH = fromH;
        
        UILabel *fromPlace = [[UILabel alloc] initWithFrame:CGRectMake(fromPlaceX, fromPlaceY, fromPlaceW, fromPlaceH)];
        
        fromPlace.text = @"上海宝山区";
        
        fromPlace.font = [UIFont systemFontOfSize:15];
        
        fromPlace.textAlignment = NSTextAlignmentCenter;
        
        fromPlace.textColor = [UIColor colorWithRed:71/255. green:169/255. blue:102/255. alpha:1.];
        
        self.fromPlace = fromPlace;
        
        [self addSubview:fromPlace];
        
        //箭头
        
        UILabel *jiantou = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fromPlace.frame), fromPlaceY, Size.width * 0.1, fromH * 0.66)];
        
        jiantou.text = @"→";
        
        jiantou.textColor = [UIColor colorWithRed:244/255. green:120/255. blue:80/255. alpha:1.];
        
        jiantou.textAlignment = NSTextAlignmentCenter;
        
        jiantou.font = [UIFont systemFontOfSize:30];
        
        [self addSubview:jiantou];
        
        //目的地
        
        UILabel *to = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jiantou.frame), fromY, fromW, fromH)];
        
        to.text = @"目的地";
        
        to.textAlignment = NSTextAlignmentCenter;
        
        to.font = [UIFont systemFontOfSize:13];
        
        to.textColor = from.textColor;
        
        [self addSubview:to];
        
        UILabel *toPlace = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jiantou.frame), fromPlaceY, fromPlaceW, fromPlaceH)];
        
        toPlace.text = @"北京朝阳区";
        
        toPlace.textAlignment = NSTextAlignmentCenter;
        
        toPlace.font = [UIFont systemFontOfSize:15];
        
        toPlace.textColor = [UIColor colorWithRed:83/255. green:101/255. blue:208/255. alpha:1.];
        
        self.toPlace = toPlace;
        
        [self addSubview:toPlace];
        
        //车辆类型
        
        CGFloat typeX = fromX;
        
        CGFloat typeY = CGRectGetMaxY(fromPlace.frame);
        
        CGFloat typeW = Size.width * 0.4;
        
        CGFloat typeH = fromH;
        
        UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(typeX, typeY, typeW, typeH)];
        
        type.textColor = [UIColor blackColor];
        
        type.textAlignment = NSTextAlignmentCenter;
        
        type.font = [UIFont systemFontOfSize:13];
        
        type.text = @"救援车";
        
        self.cheType = type;
        
        [self addSubview:type];
        
        //发布时间
        
        UILabel *fabutime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(type.frame), typeY, typeW, typeH)];
        
        fabutime.text = @"发布时间：2016-06-14";
        
        fabutime.textAlignment = NSTextAlignmentCenter;
        
        fabutime.textColor = [UIColor lightGrayColor];
        
        fabutime.font = [UIFont systemFontOfSize:12];
        
        self.fabuTime = fabutime;
        
        [self addSubview:fabutime];
        
        //期望费用
        
        CGFloat expectX = iconX;
        
        CGFloat expectY = CGRectGetMaxY(icon.frame) + 20;
        
        CGFloat expectW = Size.width * 0.17;
        
        CGFloat expectH = 10;
        
        UILabel *expect = [[UILabel alloc] initWithFrame:CGRectMake(expectX, expectY, expectW, expectH)];
        
        expect.text = @"期望费用:";
        
        expect.font = [UIFont systemFontOfSize:12];
        
        expect.textAlignment = NSTextAlignmentLeft;
        
        expect.textColor = [UIColor lightGrayColor];
        
        [self addSubview:expect];
        
        CGFloat expectPriceX = CGRectGetMaxX(expect.frame);
        
        CGFloat expectPriceY = expectY;
        
        CGFloat expectPriceW = Size.width * 0.6;
        
        CGFloat expectPriceH = expectH;
        
        UILabel *expectPrice = [[UILabel alloc] initWithFrame:CGRectMake(expectPriceX, expectPriceY, expectPriceW, expectPriceH)];
        
        self.expectPrice = expectPrice;
        
        expectPrice.textColor = fromPlace.textColor;
        
        expectPrice.font = [UIFont systemFontOfSize:12];
        
        expectPrice.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:expectPrice];
        
        //途径城市
        
        UILabel *tujing = [[UILabel alloc] initWithFrame:CGRectMake(expectX, CGRectGetMaxY(expect.frame) + 10, expectW, expectH)];
        
        tujing.font = [UIFont systemFontOfSize:12];
        
        tujing.textAlignment = NSTextAlignmentLeft;
        
        tujing.textColor = [UIColor lightGrayColor];
        
        tujing.text = @"途径城市:";
        
        [self addSubview:tujing];
        
        UILabel *citys = [[UILabel alloc] initWithFrame:CGRectMake(expectPriceX, CGRectGetMaxY(expectPrice.frame) + 10, expectPriceW, expectPriceH)];
        
        citys.textColor = [UIColor darkGrayColor];
        
        citys.textAlignment = NSTextAlignmentLeft;
        
        citys.font = [UIFont systemFontOfSize:12];
        
        self.citys = citys;
        
        [self addSubview:citys];
        
        //发车时间
        
        UILabel *fache = [[UILabel alloc] initWithFrame:CGRectMake(expectX, CGRectGetMaxY(tujing.frame) + 10, expectW, expectH)];
        
        fache.font = [UIFont systemFontOfSize:12];
        
        fache.textAlignment = NSTextAlignmentLeft;
        
        fache.textColor = [UIColor lightGrayColor];
        
        fache.text = @"发车时间:";
        
        [self addSubview:fache];
        
        UILabel *fachetime = [[UILabel alloc] initWithFrame:CGRectMake(expectPriceX, CGRectGetMaxY(citys.frame) + 10, expectPriceW, expectPriceH)];
        
        fachetime.textColor = [UIColor darkGrayColor];
        
        fachetime.textAlignment = NSTextAlignmentLeft;
        
        fachetime.font = [UIFont systemFontOfSize:12];
        
        self.facheTime = fachetime;
        
        [self addSubview:fachetime];
        
        //联系电话
        
        UILabel *lianxi = [[UILabel alloc] initWithFrame:CGRectMake(expectX, CGRectGetMaxY(fache.frame) + 10, expectW, expectH)];
        
        lianxi.font = [UIFont systemFontOfSize:12];
        
        lianxi.textAlignment = NSTextAlignmentLeft;
        
        lianxi.textColor = [UIColor lightGrayColor];
        
        lianxi.text = @"联系电话:";
        
        [self addSubview:lianxi];
        
        UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(expectPriceX, CGRectGetMaxY(fachetime.frame) + 10, expectPriceW, expectPriceH)];
        
        phone.textColor = [UIColor darkGrayColor];
        
        phone.textAlignment = NSTextAlignmentLeft;
        
        phone.font = [UIFont systemFontOfSize:12];
        
        self.phone = phone;
        
        [self addSubview:phone];
        
        //横线
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lianxi.frame) + 10, Size.width, 1)];
        
        line1.backgroundColor = [UIColor colorWithRed:242/255. green:242/255. blue:242/255. alpha:1.];
        
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(expectPrice.frame) + 5, tujing.frame.origin.y, 1, tujing.frame.size.height + fache.frame.size.height + 10)];
        
        line2.backgroundColor = [UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.];
        
        [self addSubview:line2];
        
        //电话图标
        
        UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame), line2.frame.origin.y, Size.width * 0.1, line2.frame.size.height)];
        
        phoneImage.image = [UIImage imageNamed:@"dianhuatu.png"];
        
        [self addSubview:phoneImage];
        
        UIButton *phoneBtn = [[UIButton alloc] initWithFrame:phoneImage.frame];
        
        self.phoneBtn = phoneBtn;
        
        [self addSubview:phoneBtn];
        
        //其他说明
        
        UILabel *qita = [[UILabel alloc] initWithFrame:CGRectMake(expectX, CGRectGetMaxY(line1.frame) + 10, expectW, expectH)];
        
        qita.font = [UIFont systemFontOfSize:12];
        
        qita.textAlignment = NSTextAlignmentLeft;
        
        qita.textColor = [UIColor lightGrayColor];
        
        qita.text = @"其他说明";
        
        self.qita = qita;
        
        [self addSubview:qita];
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(qita.frame.origin.x, CGRectGetMaxY(qita.frame) + 10, Size.width * 0.94, 40)];
        
        desc.numberOfLines = 0;
        
        desc.font = [UIFont systemFontOfSize:12];
        
        desc.textColor = citys.textColor;
        
        self.instructions = desc;
        
        [self addSubview:desc];
        
        //分割线
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(qita.frame.origin.x, CGRectGetMaxY(desc.frame) + 10, Size.width * 0.94, 1)];
        
        line3.backgroundColor = line2.backgroundColor;
        
        self.line3 = line3;
        
        [self addSubview:line3];
        
        //展开图标
        
        UIButton *zhankai = [[UIButton alloc] initWithFrame:CGRectMake(Size.width * 0.4, CGRectGetMaxY(line3.frame), Size.width * 0.2, 25)];
        
        [zhankai setTitle:@"全部展开" forState:UIControlStateNormal];
        
        zhankai.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [zhankai setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [zhankai addTarget:self action:@selector(zhankaiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.zhankaiBtn = zhankai;
        
        [self addSubview:zhankai];
        
        self.height = CGRectGetMaxY(zhankai.frame);
        
    }
    
    return self;
    
}

- (void)zhankaiBtnClick {
    
    if (self.isOpen) {
        
        self.isOpen = !self.isOpen;
        
        if (self.instructions) {
            
            [self.instructions removeFromSuperview];
            
        }
        
        self.instructions.frame = CGRectMake(self.instructions.frame.origin.x, self.instructions.frame.origin.y, self.instructions.frame.size.width, 40);
        
        [self addSubview:self.instructions];
        
        //分割线
        
        if (self.line3) {
            
            [self.line3 removeFromSuperview];
            
        }
        
        self.line3.frame = CGRectMake(self.qita.frame.origin.x, CGRectGetMaxY(self.instructions.frame) + 10, Size.width * 0.94, 1);
        
        [self addSubview:self.line3];
        
        //展开图标
        
        if (self.zhankaiBtn) {
            
            [self.zhankaiBtn removeFromSuperview];
            
        }
        
        self.zhankaiBtn.frame = CGRectMake(Size.width * 0.4, CGRectGetMaxY(self.line3.frame), Size.width * 0.2, 25);
        
        [self addSubview:self.zhankaiBtn];
        
        self.height = CGRectGetMaxY(self.zhankaiBtn.frame);
        
    }else {
        
        self.isOpen = !self.isOpen;
    
        CGFloat height = [UILabel getHeightByWidth:self.instructions.frame.size.width title:self.instructions.text font:self.instructions.font];
        
        if (self.instructions) {
            
            [self.instructions removeFromSuperview];
            
        }
        
        self.instructions.frame = CGRectMake(self.instructions.frame.origin.x, self.instructions.frame.origin.y, self.instructions.frame.size.width, height);
        
        [self addSubview:self.instructions];
        
        //分割线
        
        if (self.line3) {
            
            [self.line3 removeFromSuperview];
            
        }
        
        self.line3.frame = CGRectMake(self.qita.frame.origin.x, CGRectGetMaxY(self.instructions.frame) + 10, Size.width * 0.94, 1);
        
        [self addSubview:self.line3];
        
        //展开图标
        
        if (self.zhankaiBtn) {
            
            [self.zhankaiBtn removeFromSuperview];
            
        }
        
        self.zhankaiBtn.frame = CGRectMake(Size.width * 0.4, CGRectGetMaxY(self.line3.frame), Size.width * 0.2, 25);
        
        [self addSubview:self.zhankaiBtn];
        
        self.height = CGRectGetMaxY(self.zhankaiBtn.frame);
        
    }
    
}

//设置头像圆形
-(void)setLayer:(UIView *)View {
    View.layer.masksToBounds = YES;
    View.layer.cornerRadius = View.frame.size.width/2; //圆角（圆形)
    //防止掉帧（列表不卡了）
    View.layer.shouldRasterize = YES;
    View.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
