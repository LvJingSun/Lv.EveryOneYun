//
//  WJViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/2/3.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "WJViewController.h"

@interface WJViewController ()
{
    
    int timecount;
    UIButton *hqBtn;
    NSTimer *_timer;
    BOOL _isTime;


}

@end

@implementation WJViewController

- (instancetype)initWithTitle:(NSString *)title;
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setedgesForExtendedLayoutNO];
    
    UITextField *passText = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, Windows_WIDTH-60, 30)];
    [self.view addSubview:passText];
    passText.placeholder = @"请输入验证码";
    [passText  setValue:[UIFont boldSystemFontOfSize:(13)] forKeyPath:@"_placeholderLabel.font"];
    passText.tag = 201;
    
    // 线
    UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 58, Windows_WIDTH-56, 2)];
    [self.view addSubview:passImage];
    passImage.image = [UIImage imageNamed:@"pic_line"];
    
    hqBtn = [UIButton buttonWithType:0];
    hqBtn.frame = CGRectMake(Windows_WIDTH-130, 30, 100, 25);
    [hqBtn setTitle:@"获取验证码" forState:0];
    hqBtn.backgroundColor = UIColorDJYThemecolorsRGB;
    [self.view addSubview:hqBtn];
    hqBtn.clipsToBounds = YES;
    hqBtn.layer.cornerRadius = 5.0f;
    [hqBtn addTarget:self action:@selector(WJSendverificationcode) forControlEvents:UIControlEventTouchUpInside];
    hqBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self hqBtnClick];
    
    [self creatSetPass];
}


-(void)WJSendverificationcode{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.account, @"phone",
                            nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/SendFindPwdSmsCode" params:params networkBlock:^{
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    double H = 65;
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
    
    
    UIButton *submitButton = [UIButton buttonWithType:0];
    submitButton.frame = CGRectMake(20, 155 , Windows_WIDTH-40, 40);
    [submitButton setTitle:@"提交" forState:0];
    submitButton.backgroundColor = UIColorDJYThemecolorsRGB;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 5.0;
    submitButton.clipsToBounds = YES;
    [submitButton addTarget:self action:@selector(setPassBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

-(void)setPassBtnClick{
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
    
    if ([self.title isEqualToString:@"重置密码"]) {
        [self setPassBtnClickRequest];

    }else{
        [self setPassBtnChangePwd];

    }
    
}


-(void)setPassBtnClickRequest{
    UITextField *smsCode = (UITextField *)[self.view viewWithTag:201];
    UITextField *password = (UITextField *)[self.view viewWithTag:301];
    UITextField *confirmPassword = (UITextField *)[self.view viewWithTag:302];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.account, @"account",
                            [NSString stringWithFormat:@"%@",password.text], @"password",
                            [NSString stringWithFormat:@"%@",confirmPassword.text], @"confirmPassword",
                            [NSString stringWithFormat:@"%@",smsCode.text], @"smsCode",
                            nil];
    [SVProgressHUD showWithStatus:@"正在提交..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/MemberFindPassword" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            [SVProgressHUD showSuccessWithStatus:@"密码找回成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        [SVProgressHUD dismiss];
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
    
    
}

-(void)setPassBtnChangePwd{
    UITextField *smsCode = (UITextField *)[self.view viewWithTag:201];
    UITextField *password = (UITextField *)[self.view viewWithTag:301];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",                            [NSString stringWithFormat:@"%@",password.text], @"password",
                            [NSString stringWithFormat:@"%@",smsCode.text], @"smsCode",
                            nil];
    [SVProgressHUD showWithStatus:@"正在提交..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/ChangePwd" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD dismiss];
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
    
    
}


@end
