//
//  DBHelper.h
//  baozhifu
//
//  Created by mac on 13-8-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHelper : NSObject

- (NSDictionary *)queryVersion;

- (NSMutableArray *)queryData:(NSString *)type andCategory:(NSString *)category;

- (void)updateData:(NSArray *)list andType:(NSString *)type andVersion:(NSString *)ver;

- (NSMutableArray *)queryCity;

- (NSMutableArray *)queryArea:(NSString *) cityId;

- (NSMutableArray *)queryMerchant:(NSString *) areaId;

- (NSMutableArray *)queryCategory;

- (NSMutableArray *)queryProject:(NSString *) categoryId;

/*
 *通过父id找子城市
 */
- (NSMutableArray *)queryCityDJYParentId:(NSString *) ParentId;

@end
