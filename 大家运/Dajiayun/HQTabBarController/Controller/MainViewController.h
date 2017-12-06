//
//  AppDelegate.m
//  CRM
//
//  Created by 冯海强 on 15/8/12.
//  Copyright (c) 2015年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MainViewController : UITabBarController

{
    EMConnectionState _connectionState;
}

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;


@end
