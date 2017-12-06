//
//  MOTUserDataManager.m
//  MOT
//
//  Created by fenghq on 15/11/23.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "MOTUserDataManager.h"
#import "MOTKeyChain.h"

@implementation MOTUserDataManager

static NSString * const KEY_IN_KEYCHAIN = @"com.dongfang.motapp.allinfo";
static NSString * const KEY_USERNAME = @"com.dongfang.motapp.username";
static NSString * const KEY_PASSWORD = @"com.dongfang.motapp.password";
static NSString * const KEY_USERID = @"com.dongfang.motapp.userId";
static NSString * const KEY_USERROLE = @"com.dongfang.motapp.userRole";


+(void)savePassWord:(NSString *)password andusername:(NSString *)username anduserid:(NSString *)userid anduserrole:(NSString *)userRole
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [usernamepasswordKVPairs setObject:username forKey:KEY_USERNAME];
    [usernamepasswordKVPairs setObject:userid forKey:KEY_USERID];
    [usernamepasswordKVPairs setObject:userRole forKey:KEY_USERROLE];
    [MOTKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[MOTKeyChain load:KEY_IN_KEYCHAIN];
    return [ParserUtil getString:usernamepasswordKVPair forKey:KEY_PASSWORD];
}

+(id)readUserName
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[MOTKeyChain load:KEY_IN_KEYCHAIN];
    return [ParserUtil getString:usernamepasswordKVPair forKey:KEY_USERNAME];
}

+(id)readUserid
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[MOTKeyChain load:KEY_IN_KEYCHAIN];
    return [ParserUtil getString:usernamepasswordKVPair forKey:KEY_USERID];
}

+(id)readUserRole
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[MOTKeyChain load:KEY_IN_KEYCHAIN];
    return [ParserUtil getString:usernamepasswordKVPair forKey:KEY_USERROLE];

}

+(void)deletePassWord
{
    [MOTKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
