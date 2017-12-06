
//
//  ZCController.m
//  DJRegisterViewDemo
//
//  Created by asios on 15/8/15.
//  Copyright (c) 2015年 梁大红. All rights reserved.
//

#import "ZCController2.h"
#import "DJRegisterView.h"
@interface ZCController2 ()
{
    UIButton *hqBtn;
    int timecount;
    NSTimer *_timer;
    BOOL _isTime;
    UIButton *choseSF;
    UIButton *XI;

    NSInteger memberRole;
    
    /**
     *  是否绑定QQWX
     */
    BOOL Isbind;
    SSDKUser *SDKUser;
}

@end

@implementation ZCController2
//需要绑定QQWX
- (instancetype)initBindQQWXsdkuser:(SSDKUser *)user
{
    self = [super init];
    if (self) {
        Isbind = YES;
        SDKUser =user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setedgesForExtendedLayoutNO];
    self.title = @"设置密码";
    [self presentShareViewAdmion];
    
    choseSF = [[UIButton alloc]initWithFrame:CGRectMake(30, 10, Windows_WIDTH-60, 40)];
    choseSF.backgroundColor = [UIColor whiteColor];
    [choseSF setTitleColor:UIColorDJYThemecolorsRGB forState:UIControlStateNormal];
    [choseSF setTitle:@"选择身份"forState:UIControlStateNormal];
    [self setLayerBorder:choseSF andcornerRadius:5 andborderWidth:1 andborderColor:UIColorDJYThemecolorsRGB.CGColor];
    [choseSF addTarget:self action:@selector(presentShareViewAdmion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choseSF];
    
    
    UITextField *passText = [[UITextField alloc] initWithFrame:CGRectMake(30, 70, Windows_WIDTH-60, 30)];
    [self.view addSubview:passText];
    passText.placeholder = @"请输入验证码";
    [passText  setValue:[UIFont boldSystemFontOfSize:(13)] forKeyPath:@"_placeholderLabel.font"];
    passText.tag = 201;
    
    // 线
    UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 98, Windows_WIDTH-56, 2)];
    [self.view addSubview:passImage];
    passImage.image = [UIImage imageNamed:@"pic_line"];
    
    hqBtn = [UIButton buttonWithType:0];
    hqBtn.frame = CGRectMake(Windows_WIDTH-130, 70, 100, 25);
    [hqBtn setTitle:@"获取验证码" forState:0];
    hqBtn.backgroundColor = UIColorDJYThemecolorsRGB;
    [self.view addSubview:hqBtn];
    hqBtn.clipsToBounds = YES;
    hqBtn.layer.cornerRadius = 5.0f;
    [hqBtn addTarget:self action:@selector(Sendverificationcode) forControlEvents:UIControlEventTouchUpInside];
    hqBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self hqBtnClick];
    
    [self creatSetPass];
}


-(void)hqBtnClick{

    timecount = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(time) userInfo:nil repeats:NO];
    
    hqBtn.backgroundColor = [UIColor grayColor];
    hqBtn.userInteractionEnabled = NO;
    _isTime = YES;
    [NSTimer scheduledTimerWithTimeInterval:5*60.0 target:self selector:@selector(endTime) userInfo:nil repeats:NO];

}

-(void)Sendverificationcode{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.account, @"phone",
                            nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/SendRegisterSmsCode" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            [self hqBtnClick];
        }
        [SVProgressHUD dismiss];
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
    
    
}

- (void)timerFired
{
    [hqBtn setTitle:[NSString stringWithFormat:@"(%ds)重新获取",timecount--] forState:0];
    if (timecount==1||timecount<1) {
        [_timer invalidate];
        [hqBtn setTitle:@"获取验证码" forState:0];
    }
}
- (void)time
{
    hqBtn.backgroundColor = UIColorDJYThemecolorsRGB;
    hqBtn.userInteractionEnabled = YES;
}
- (void)endTime
{
    _isTime = NO;
}


- (void)creatSetPass
{
    NSArray *descTitles = @[@"请输入密码",@"请再次输入密码"];
    double H = 105;
    for (int i=0; i<2; i++) {
        
        UITextField *passText = [[UITextField alloc]
                                 initWithFrame:CGRectMake(20, H+i*(35+10), Windows_WIDTH-40, 35)];
        [passText  setValue:[UIFont boldSystemFontOfSize:(13)] forKeyPath:@"_placeholderLabel.font"];
        passText.placeholder = descTitles[i];
        passText.tag = 301+i;
        passText.clipsToBounds = YES;
        [self.view addSubview:passText];
        //icon
        UIImageView *passIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, passText.frame.origin.y, 25, 25)];
        passIcon.image = [UIImage imageNamed:@"icon_password"];
        passText.leftView = passIcon;
        passText.leftViewMode = UITextFieldViewModeAlways;
        // 线
        UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, passText.frame.origin.y+passText.frame.size.height, Windows_WIDTH-56, 2)];
        [self.view addSubview:passImage];
        passImage.image = [UIImage imageNamed:@"pic_line"];
        
    }
    
    
    XI = [UIButton buttonWithType:0];
    XI.frame = CGRectMake(20, 130+65 , Windows_WIDTH-40, 40);
    [XI setTitle:@"我同意《大家运软件许可与服务协议》" forState:0];
    [XI addTarget:self action:@selector(choseXI) forControlEvents:UIControlEventTouchUpInside];
    [XI setImage:[UIImage imageNamed:@"group_chat_selected"] forState:UIControlStateNormal];
    [XI setTitleColor:UIColorDJYThemecolorsRGB forState:UIControlStateNormal];
    XI.titleLabel.font = [UIFont systemFontOfSize:13];
    XI.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    XI.backgroundColor = [UIColor clearColor];
    [XI setSelected:YES];
    [self.view addSubview:XI];

    
    UIButton *submitButton = [UIButton buttonWithType:0];
    submitButton.frame = CGRectMake(20, 130+105 , Windows_WIDTH-40, 40);
    [submitButton setTitle:@"提交" forState:0];
    submitButton.backgroundColor = UIColorDJYThemecolorsRGB;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 5.0;
    submitButton.clipsToBounds = YES;
    [submitButton addTarget:self action:@selector(setPassBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

-(void)presentShareViewAdmion
{
    DOPAction *action1 = [[DOPAction alloc] initWithName:@"车主" iconName:@"iconfont-chezhu" handler:^{
        memberRole =1;
        [choseSF setTitle:@"我是司机"forState:UIControlStateNormal];
    }];
    DOPAction *action2 = [[DOPAction alloc] initWithName:@"货主" iconName:@"iconfont-goods" handler:^{
        memberRole =2;
        [choseSF setTitle:@"我是商品车车主"forState:UIControlStateNormal];
    }];
    DOPAction *action3 = [[DOPAction alloc] initWithName:@"物流公司" iconName:@"iconfont-wuliu" handler:^{
        memberRole =3;
        [choseSF setTitle:@"我是物流公司"forState:UIControlStateNormal];
    }];
    
    NSArray *actions = @[@"",
                         @[action1, action2,action3]
                         ];
    
    DOPScrollableActionSheet *as = [[DOPScrollableActionSheet alloc] initWithActionArray:actions];
    [as show];
    
}


-(void)choseXI{
    if (XI.selected) {
        [XI setSelected:NO];
        [XI setImage:[UIImage imageNamed:@"group_chat_normal"] forState:UIControlStateNormal];
    }else{
        [XI setSelected:YES];
        [XI setImage:[UIImage imageNamed:@"group_chat_selected"] forState:UIControlStateNormal];
    }
}



-(void)setPassBtnClick{
    if (memberRole == 0) {
        [self.view makeToast:@"请选择角色"];
        return;
    }
    UITextField *smsCode = (UITextField *)[self.view viewWithTag:201];
    if (smsCode.text.length == 0) {
        [self.view makeToast:@"请输入验证码"];
        return;
    }
    UITextField *password = (UITextField *)[self.view viewWithTag:301];
    UITextField *confirmPassword = (UITextField *)[self.view viewWithTag:302];
    if (password.text.length == 0|| confirmPassword.text.length==0) {
        [self.view makeToast:@"密码不能为空"];
        return;
    }
    if (![password.text isEqualToString:confirmPassword.text]) {
        [self.view makeToast:@"两次密码不一致"];
        return;
    }
    if (XI.selected == NO) {
        [self.view makeToast:@"请选择同意《大家运软件许哥与服务协议》"];
        return;
    }
    if (!Isbind) {
        [self setPassBtnClickRequest];
    }else{
        [self WxQqBindRegisterRequest];
    }
    
}

//普通注册
-(void)setPassBtnClickRequest{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    UITextField *smsCode = (UITextField *)[self.view viewWithTag:201];
    UITextField *password = (UITextField *)[self.view viewWithTag:301];
    UITextField *confirmPassword = (UITextField *)[self.view viewWithTag:302];
    NSString *role = [NSString stringWithFormat:@"MemberRole_%ld",(long)memberRole];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.account, @"account",
                            password.text, @"password",
                            confirmPassword.text, @"confirmPassword",
                            smsCode.text, @"smsCode",
                            role, @"memberRole",
                            @"Source_3", @"source",
                            nil];
    [SVProgressHUD showWithStatus:@"正在提交..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/MemberRegister" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            // 0.5秒后执行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });

        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
        [self.view makeToast:error.localizedDescription];
    }];
}

//注册并绑定
- (void)WxQqBindRegisterRequest{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    UITextField *smsCode = (UITextField *)[self.view viewWithTag:201];
    UITextField *password = (UITextField *)[self.view viewWithTag:301];
    UITextField *confirmPassword = (UITextField *)[self.view viewWithTag:302];
    NSString *role = [NSString stringWithFormat:@"MemberRole_%ld",(long)memberRole];
    
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
                            self.account, @"account",
                            password.text, @"password",
                            confirmPassword.text, @"confirmPassword",
                            smsCode.text, @"smsCode",
                            role, @"memberRole",
                            @"Source_3", @"source",
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
    [SVProgressHUD showWithStatus:@"正在提交..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/WxQqBindRegister" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            // 0.5秒后执行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
        [self.view makeToast:error.localizedDescription];
    }];

}



@end
