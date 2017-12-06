//
//  GoodsCarFrame.h
//  Dajiayun
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class GoodsCar;

@interface GoodsCarFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect priceF;

@property (nonatomic, assign) CGRect picF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, strong) GoodsCar *goodsCar;

@property (nonatomic, assign) CGFloat height;

@end
