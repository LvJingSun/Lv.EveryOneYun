//
//  LoginViewController.m
//  MOT
//
//  Created by fenghq on 15/10/26.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "LoginViewController.h"
#import "DJRegisterView.h"
#import "SecretUtil.h"
#import "ZCController1.h"
#import "WechatAuthSDK.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DJRegisterView *registerView = [[DJRegisterView alloc]
                                    initwithFrame:
                                    self.view.bounds
                                    djRegisterViewType:DJRegisterViewTypeNav action:^(NSString *acc, NSString *key,IANActivityIndicatorButton *loginBtn) {
                                        self.view.userInteractionEnabled = NO;
                                        self.LogBtn = loginBtn;
                                        [self DJYlogin:acc password:key];
                                    } zcAction:^{
                                        ZCController1 *VC = [[ZCController1 alloc]initWithTitle:@"注册" andSSDKUser:nil];
                                        [self.navigationController pushViewController:VC animated:YES];
                                        
                                    } wjAction:^{
                                        ZCController1 *VC = [[ZCController1 alloc]initWithTitle:@"忘记密码" andSSDKUser:nil];
                                        [self.navigationController pushViewController:VC animated:YES];
                                    }];
    [self.view addSubview:registerView];
    
    //第三方登录
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
    DJYXIBTableViewCell12 *logincell = (DJYXIBTableViewCell12 *)[nib objectAtIndex:12];
    logincell.frame = CGRectMake(0, self.view.frame.size.height-80, Windows_WIDTH, 80);
    logincell.QQlogin.frame = CGRectMake(self.view.bounds.size.width * 0.35, 35, self.view.bounds.size.width * 0.1, 35);
    logincell.WXlogin.frame = CGRectMake(self.view.bounds.size.width * 0.55, 35, self.view.bounds.size.width * 0.1, 35);
    if (![TencentOAuth iphoneQQInstalled]) {
        logincell.QQlogin.hidden = YES;
    }else{
        [logincell.QQlogin addTarget:self action:@selector(QQloginAction) forControlEvents:UIControlEventTouchUpInside];
        [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    }
    if (![WXApi isWXAppInstalled]) {
        logincell.WXlogin.hidden = YES;
    }else{
        [logincell.WXlogin addTarget:self action:@selector(WXloginAction) forControlEvents:UIControlEventTouchUpInside];
        [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];

    }

    if ([TencentOAuth iphoneQQInstalled]&&[WXApi isWXAppInstalled]) {
        [self.view addSubview:logincell];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)DJYlogin:(NSString *)username
        password:(NSString *)password{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                           username, @"account",
                           password, @"password",
                           @"IOS", @"versionType",
                           nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/MemberLogin" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [self.LogBtn endButtonActivityIndicatorView];
        self.view.userInteractionEnabled = YES;

    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            NSDictionary * MemberInfo = [responseObject valueForKey:@"MemberInfo"];
            [self saveLoginMemberInfo:MemberInfo username:username password:password];

        }else{
            [self.LogBtn endButtonActivityIndicatorView];
            self.view.userInteractionEnabled = YES;
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [self.LogBtn endButtonActivityIndicatorView];
        self.view.userInteractionEnabled = YES;
    }];

}




- (void)QQloginAction{
    [SVProgressHUD showWithStatus:@"加载中..."];
    //QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
         if (state == SSDKResponseStateSuccess){
             [self requestWxQqCheck:user.uid type:@"1" andSSKDUser:user];
         }
         else{
             [SVProgressHUD showErrorWithStatus:@"QQ登录授权失败"];
         }
     }];
}

- (void)WXloginAction{
    //微信的登录
    [SVProgressHUD showWithStatus:@"加载中..."];
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
         if (state == SSDKResponseStateSuccess){
             [self requestWxQqCheck:user.uid type:@"2" andSSKDUser:user];
         }
         else{
             [SVProgressHUD showErrorWithStatus:@"微信登录授权失败"];
         }
         
     }];
}

/**
 *  验证【会员】QQ、微信 是否绑定
 */
- (void)requestWxQqCheck:(NSString *)openid type:(NSString *)type andSSKDUser:(SSDKUser *)user{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            type,@"type",
                            openid,@"openId",
                            @"IOS", @"source",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/WxQqCheck" params:params networkBlock:^{
        [SVProgressHUD dismiss];
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            NSDictionary *MemberInfo = [responseObject valueForKey:@"MemberInfo"];
            [self saveLoginMemberInfo:MemberInfo username:[MemberInfo objectForKey:@"Phone"] password:@""];
        }else
        {
            [SVProgressHUD dismiss];
            ZCController1 *VC = [[ZCController1 alloc]initWithTitle:@"绑定手机号" andSSDKUser:user];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
}





















@end
