//
//  ImageNameFormID.h
//  MOT
//
//  Created by fenghq on 15/12/10.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageNameFormID : NSObject
//事件类型
+(NSString *)ImageNameFromWitheventId:(NSInteger)ID;
//股票状态
+(NSString *)ImageNameFromWithstockStatus:(NSInteger)ID;
//事件类型
+(NSString *)ImageNameFromWitheventType:(NSInteger)ID;
//产品风险等级
+(NSString *)ImageNameFromWithproductRiskRate:(NSString *)productRiskRate;
//理财产品风险等级
+(NSString *)ImageNameFromWithproductRiskRate119SBo:(NSInteger )productRiskRate;

@end
