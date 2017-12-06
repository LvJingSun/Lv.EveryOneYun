//
//  AppDelegate.h
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ApplyViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate>
{
    EMConnectionState _connectionState;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainController;
@property(nonatomic, readonly) UIForceTouchCapability forceTouchCapability;

@property (strong, nonatomic) NSString *IsUpdate;//是否强制更新：IsUpdate 0：否；1：是
@property (strong, nonatomic) NSString *IsNewUpdate;//是否有新版本：IsNewUpdate ：否；1：是

@end
