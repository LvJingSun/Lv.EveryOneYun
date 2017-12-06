//
//  AppDelegate.m
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CoreNewFeatureVC.h"
#import "CALayer+Transition.h"
#import "AppDelegate+EaseMob.h"
#import "AppDelegate+Parse.h"
#import "KSGuideManager.h"
#import "launch.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self allocShareSDKlogin];             
 //****初始化网络***************************************************
    _connectionState = eEMConnectionConnected;
    [AFCustomClient requestNetworkingStatus];
//********************************************************
//     demo中有用到Parse，您的项目中不需要添加，可忽略此处。
    [self parseApplication:application didFinishLaunchingWithOptions:launchOptions];
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"Dajiayun_dev";
#else
    apnsCertName = @"Dajiayun";
#endif
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:@"city#everyoneyun"
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
//********************************************************
    
    [self onCheckVersion];
    
    [self.window makeKeyAndVisible];
    
    NSMutableArray *paths = [NSMutableArray new];

    [paths addObject:[[NSBundle mainBundle] pathForResource:@"引导页-大家运---2" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"引导页-大家运---3" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"引导页-大家运---4" ofType:@"png"]];
//    [paths addObject:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"jpg"]];
    
    KSGuideManager *ksg = [KSGuideManager shared];
    
    [ksg showGuideViewWithImages:paths];
    
    [self saveVersion];
    
//    launch *launcha = [launch new];
//    
//    [launcha loadLaunchImage:@"2.jpg" bgimage:@"1.jpg"];
    
    return YES;
}

- (void)saveVersion {

    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:version forKey:@"ljversion"];
    
}

- (void)allocShareSDKlogin{
    [ShareSDK registerApp:@"1101f1a1d6b00"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxdf6f642466625381"
                                       appSecret:@"8f48a274044e3a7401ae18bd502d55d5"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105217621"
                                      appKey:@"LrDo2MYIiTMqrKPW"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    

}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (_mainController) {
        [_mainController jumpToChatList];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController) {
        [_mainController didReceiveLocalNotification:notification];
    }
}

 #pragma mark -3Dtouch功能
// - (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
//     if (self.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//        NSLog(@"你的手机支持3D Touch!");
//        if ([shortcutItem.type isEqualToString:@"com.cityandcity.dajiayun.SYSaddfriend"]) {
//            SubLBXScanViewController *VC = [SubLBXScanViewController new];
//            VC.title = @"扫一扫";
//            [self.window.rootViewController presentViewController:[[UINavigationController alloc]initWithRootViewController:VC] animated:YES completion:nil];
//        }
//    }
//    else {
//        NSLog(@"你的手机暂不支持3D Touch!");
//    }
//}

/**
 *  版本检测
 */
- (void)onCheckVersion{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Apple",@"versionType",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DataBaseWebService.asmx/GetAppsVersion" params:params networkBlock:^{
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSDictionary *appsVersion = [responseObject valueForKey:@"appsVersion"];
            self.IsUpdate = [appsVersion objectForKey:@"IsUpdate"];
            NSString *CFBundleShortVersionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            if ([[appsVersion objectForKey:@"versionNumber"] floatValue]>[CFBundleShortVersionString floatValue]) {
                self.IsNewUpdate = @"1";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有新版本啦"
                                                                    message:[appsVersion objectForKey:@"coreIntro"]
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"立即更新", nil];
                alertView.tag = 99999;
                
                [alertView show];
            }
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
    }];

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99999) {
        if (buttonIndex == 0) {
            if ([self.IsUpdate isEqualToString:@"0"]) {
            }else if ([self.IsUpdate isEqualToString:@"1"])
            {
                exit(0);
            }
        }
        if ( buttonIndex == 1 ) {
            // 点击进入版本升级的url-appStore下载的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/da-jia-yun/id1077964360?l=zh&ls=1&mt=8"]];
        }
    }
}


@end
