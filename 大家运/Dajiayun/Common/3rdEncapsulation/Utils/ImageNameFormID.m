//
//  ImageNameFormID.m
//  MOT
//
//  Created by fenghq on 15/12/10.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "ImageNameFormID.h"

@implementation ImageNameFormID

+(NSString *)ImageNameFromWitheventId:(NSInteger)ID{
    NSString *Name = @"";
    switch (ID) {
        case 0:
            Name = @"test事件";
            break;
        case 1:
            Name = @"全仓购买ST股退市风险提醒";
            break;
        case 2:
            Name = @"沪港通开通提醒";
            break;
        case 3:
            Name = @"购买国债逆回转客户提醒";
            break;
        case 4:
            Name = @"融资融券潜在客户提醒";
            break;
        case 5:
            Name = @"分级基金下折提醒";
            break;
        case 6:
            Name = @"test事件";
            break;
        case 7:
            Name = @"test事件";
            break;
        case 8:
            Name = @"基金开户一周内未交易提醒";
            break;
        case 9:
            Name = @"两融担保比例警示";
            break;
        case 10:
            Name = @"重大事项停牌提醒";
            break;
        case 11:
            Name = @"新股申购提醒";
            break;
        case 12:
            Name = @"icon_mot_gupiao_32x32";
            break;
        case 13:
            Name = @"icon_jinrong_32x32";
            break;
        case 14:
            Name = @"icon_mot_xianjin_32x32";
            break;
        case 15:
            Name = @"icon_mot_zhuanruzhuanchu_32x32";
            break;
        case 16:
            Name = @"客户生日提醒";
            break;
        case 17:
            Name = @"身份证证件到期提醒";
            break;
        case 18:
            Name = @"新股申购提醒";
            break;
        case 19:
            Name = @"test事件";
            break;
        case 20:
            Name = @"test事件";
            break;
        default:
            break;
    }
    
    return Name;
}

+(NSString *)ImageNameFromWithstockStatus:(NSInteger)ID;
{
    NSString *Name = @"";
    switch (ID) {
        case 0:
            Name = @"";
            break;
        case 1:
            Name = @"";
            break;
        case 2:
            Name = @"icon_ting_16x16";
            break;
        default:
            break;
    }
    return Name;
}

+(NSString *)ImageNameFromWitheventType:(NSInteger)ID;
{
    NSString *Name = @"";
    switch (ID) {
        case 0:
            Name = @"";
            break;
        case 1:
            Name = @"icon_tixing_2x20";
            break;
        case 2:
            Name = @"icon_richeng_20x20";
            break;
        case 3:
            Name = @"icon_renwu_20x20";
            break;
        case 4:
            Name = @"icon_richeng_20x20";
            break;
            
        default:
            break;
    }
    return Name;
}

+(NSString *)ImageNameFromWithproductRiskRate:(NSString *)productRiskRate;
{
    NSString *Name = @"";
    if ([productRiskRate isEqualToString:@"高风险"]) {
        Name = @"icon_high_40x40";
    }else if ([productRiskRate isEqualToString:@"中高风险"]){
        Name = @"icon_mediumhigh_40x40";
    }else if ([productRiskRate isEqualToString:@"中等风险"]){
        Name = @"icon_medium_40x40";
    }else if ([productRiskRate isEqualToString:@"中低风险"]){
        Name = @"icon_mediumlow_40x40";
    }else if ([productRiskRate isEqualToString:@"低风险"]){
        Name = @"icon_low_40x40";
    }
    return Name;
}

+(NSString *)ImageNameFromWithproductRiskRate119SBo:(NSInteger )productRiskRate;
{
    NSString *Name = @"";
    if (productRiskRate ==1) {
        Name = @"icon_di_16x16";
    }else if (productRiskRate ==2){
        Name = @"icon_zhongdi_16x16";
    }else if (productRiskRate ==3){
        Name = @"icon_zhong_16x16";
    }else if (productRiskRate ==4){
        Name = @"icon_zhonggao_16x16";
    }else if (productRiskRate ==5){
        Name = @"icon_gao_16x16";
    }
    return Name;
}

@end
