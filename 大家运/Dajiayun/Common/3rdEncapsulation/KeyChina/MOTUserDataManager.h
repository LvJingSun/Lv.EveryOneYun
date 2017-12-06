//
//  MOTUserDataManager.h
//  MOT
//
//  Created by fenghq on 15/11/23.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOTUserDataManager : NSObject

+(void)savePassWord:(NSString *)password andusername:(NSString *)username anduserid:(NSString *)userid anduserrole:(NSString *)userRole;

+(id)readPassWord;
+(id)readUserName;
+(id)readUserid;
+(id)readUserRole;

@end
