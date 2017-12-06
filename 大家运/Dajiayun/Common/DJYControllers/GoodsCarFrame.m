//
//  GoodsCarFrame.m
//  Dajiayun
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "GoodsCarFrame.h"
#import "GoodsCar.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation GoodsCarFrame

-(void)setGoodsCar:(GoodsCar *)goodsCar {

    _goodsCar = goodsCar;
    
    CGFloat picX = 15;
    
    CGFloat picY = 10;
    
    CGFloat picW = SCREEN_WIDTH *0.4;
    
    CGFloat picH = 90;
    
    _picF = CGRectMake(picX, picY, picW, picH);
    
    CGFloat nameX = CGRectGetMaxX(_picF) + 20;
    
    CGFloat nameY = picY + 5;
    
    CGFloat nameW = SCREEN_WIDTH - nameX;
    
    CGFloat nameH = 20;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat priceX = nameX;
    
    CGFloat priceY = CGRectGetMaxY(_nameF) + 20;
    
    CGFloat priceW = SCREEN_WIDTH * 0.3;
    
    CGFloat priceH = 20;
    
    _priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat timeX = nameX;
    
    CGFloat timeY = CGRectGetMaxY(_priceF);
    
    CGFloat timeW = SCREEN_WIDTH * 0.3;
    
    CGFloat timeH = 20;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    _height = picY * 2 + picH;
}

@end
