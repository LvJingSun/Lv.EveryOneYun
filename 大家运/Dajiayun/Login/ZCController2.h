//
//  ZCController.h
//  DJRegisterViewDemo
//
//  Created by asios on 15/8/15.
//  Copyright (c) 2015年 梁大红. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQBaseViewController.h"
@interface ZCController2 :HQBaseViewController

@property (nonatomic,copy) NSString *account;
/**
 *  需要绑定QQWX
 *
 */
- (instancetype)initBindQQWXsdkuser:(SSDKUser *)user;
@end
