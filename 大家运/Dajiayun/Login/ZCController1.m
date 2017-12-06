
//
//  ZCController.m
//  DJRegisterViewDemo
//
//  Created by asios on 15/8/15.
//  Copyright (c) 2015年 梁大红. All rights reserved.
//

#import "ZCController1.h"
#import "DJRegisterView.h"
#import "ZCController2.h"
#import "WJViewController.h"
@interface ZCController1 ()
{
    SSDKUser *SDKUser;
}

@end

@implementation ZCController1

- (instancetype)initWithTitle:(NSString *)title andSSDKUser:(SSDKUser *)user;
{
    self = [super init];
    if (self) {
        self.title = title;
        SDKUser = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setedgesForExtendedLayoutNO];
    DJRegisterView *djzcView = [[DJRegisterView alloc]
                                initwithFrame:self.view.bounds djRegisterViewTypeSMS:DJRegisterViewTypeScanfPhoneSMS plTitle:@"请输入验证码"
                                title:@"下一步"
                                hq:^BOOL(NSString *phoneStr) {
                                    return YES;
                                }
                                
                                tjAction:^(NSString *yzmStr) {
//                                    获取手机号了，不yzmStr了
                                    if ([self.title isEqualToString:@"注册"]) {
                                        [self Sendverificationcode:yzmStr];
                                    }else if ([self.title isEqualToString:@"忘记密码"]){
                                        [self WJSendverificationcode:yzmStr];
                                    }else if ([self.title isEqualToString:@"绑定手机号"]){
                                        [self BindQQWX:yzmStr];
                                    }
                                    
                                }];
    [self.view addSubview:djzcView];
}


-(void)Sendverificationcode:(NSString *)phone{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (phone.length==0) {
        [self.view makeToast:@"请输入手机号"];
        return;
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            phone, @"phone",
                            nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/SendRegisterSmsCode" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        NSString *msg = [responseObject valueForKey:@"Msg"];
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            ZCController2 *VC = [[ZCController2 alloc]init];
            VC.account = phone;
            [self.navigationController pushViewController:VC animated:YES];
        }else if ([msg isEqualToString:@"手机号已存在"]){
        
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
}


-(void)WJSendverificationcode:(NSString *)phone{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (phone.length==0) {
        [self.view makeToast:@"请输入手机号"];
        return;
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            phone, @"phone",
                            nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/SendFindPwdSmsCode" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            WJViewController *VC = [[WJViewController alloc]initWithTitle:@"重置密码"];
            VC.account = phone;
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
}

//QQWX绑定-未注册
-(void)Isregier:(NSString *)phone{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (phone.length==0) {
        [self.view makeToast:@"请输入手机号"];
        return;
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            phone, @"phone",
                            nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/SendRegisterSmsCode" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        NSString *msg = [responseObject valueForKey:@"Msg"];
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            ZCController2 *VC = [[ZCController2 alloc]initBindQQWXsdkuser:SDKUser];
            VC.account = phone;
            [self.navigationController pushViewController:VC animated:YES];
        }else if ([msg isEqualToString:@"手机号已存在"]){
            [self BindQQWX:phone];
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
    

}

//已注册 直接绑定后 进入APP
- (void)BindQQWX:(NSString *)phone{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSString *type = SDKUser.platformType ==SSDKPlatformTypeQQ?@"1":@"2";
    NSString *gender = @"";
    switch (SDKUser.gender) {
        case SSDKGenderMale: {
            gender =@"1";
            break;
        }
        case SSDKGenderFemale: {
            gender =@"2";
            break;
        }
        case SSDKGenderUnknown: {
            gender =@"3";
            break;
        }
    }

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            phone, @"phone",
                            SDKUser.uid, @"openId",
                            type, @"type",
                            @"IOS", @"source",
                            SDKUser.nickname, @"nickName",
                            gender, @"gender",
                            SDKUser.icon, @"figureurl_qq_1",
                            SDKUser.icon, @"figureurl_qq_2",
                            SDKUser.icon, @"figureurl_1",
                            SDKUser.icon, @"figureurl_2",
                            nil];
    [SVProgressHUD showWithStatus:@"正在绑定手机..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/WxQqBind" params:params networkBlock:^{
        [SVProgressHUD dismiss];
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:NO]) {
            NSDictionary *MemberInfo = [responseObject valueForKey:@"MemberInfo"];
            [self saveLoginMemberInfo:MemberInfo username:[MemberInfo objectForKey:@"Phone"] password:@""];
        }else{
            [SVProgressHUD dismiss];
            NSString *msg = [responseObject valueForKey:@"Msg"];
            [self.view makeToast:msg];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
}

@end
