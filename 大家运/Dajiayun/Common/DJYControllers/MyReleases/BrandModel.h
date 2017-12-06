//
//  BrandModel.h
//  BrandDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandModel : NSObject

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, strong) NSMutableArray *cars;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)brandModelWithDict:(NSDictionary *)dic;

@end
