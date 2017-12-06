//
//  DJRegisterView.h
//  DJRegisterView
//
//  Created by asios on 15/8/14.
//  Copyright (c) 2015年 LiangDaHong. All rights reserved.
//
//
//  邮箱： asiosldh@163.com
//

#import "DJRegisterView.h"
#import "MOTUserDataManager.h"

#define   WIN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define   WIN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// 登录界面颜色
#define   COLOR_LOGIN_VIEW [UIColor colorWithRed:0 green:114/255.0 blue:183/255.0 alpha:1]
// 注册界面颜色
#define   COLOR_ZC_VIEW [UIColor colorWithRed:0 green:114/255.0 blue:183/255.0 alpha:1]
#define SET_PLACE(text) [text  setValue:[UIFont boldSystemFontOfSize:(13)] forKeyPath:@"_placeholderLabel.font"];
#define   FONT(size)  ([UIFont systemFontOfSize:size])


@interface DJRegisterView () <UITextFieldDelegate>
{
    double _minHeight;
    UIButton *hqBtn;
    UIButton *zcBtn;
    
    BOOL _isTime;
    
    NSTimer *_timer;
    int timecount;
    
    IANActivityIndicatorButton *LButton;


}
// 登录界面
@property (nonatomic,assign)DJRegisterViewType djRegisterViewType;
@property (nonatomic,copy) void (^action)(NSString *acc,NSString *key,IANActivityIndicatorButton *loginBtn);
@property (nonatomic,copy) void (^zcAction)(void);
@property (nonatomic,copy) void (^wjAction)(void);

// 重置密码界面
@property (nonatomic,copy) void (^setPassAction)(NSString *key1,NSString *key2);


// 忘记密码 获取验证码界面
@property (nonatomic,assign)DJRegisterViewTypeSMS djRegisterViewTypeSms;
@property (nonatomic,copy) BOOL (^hqAction)(NSString *phoneStr);
@property (nonatomic,copy) void (^tjAction)(NSString *yzmStr);

@end


@implementation DJRegisterView

- (instancetype)init
{
    if(self = [super init]) {
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [self setViewY:0 animation:YES];

}

#pragma mark - 登录界面
- (instancetype )initwithFrame:(CGRect)frame
            djRegisterViewType:(DJRegisterViewType)djRegisterViewType
                        action:(void (^)(NSString *acc,NSString *key,IANActivityIndicatorButton *loginBtn))action
                      zcAction:(void (^)(void))zcAction
                      wjAction:(void (^)(void))wjAction
{
    if ([self  initWithFrame:frame]) {
        [self creatUI:djRegisterViewType];
        self.action = action;
        self.zcAction = zcAction;
        self.wjAction = wjAction;
    }
    return self;
}
- (void)creatUI:(DJRegisterViewType ) djRegisterViewType
{
    self.djRegisterViewType = djRegisterViewType;
    
    //背景图
//    UIImageView *BgImageV = [[UIImageView alloc]
//                             initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    BgImageV.image = [UIImage imageNamed:@"pic_bg"];
//    BgImageV.userInteractionEnabled = YES;
//    [self addSubview:BgImageV];
    
    // 头像
    UIImageView *headIcon = [[UIImageView alloc]
                             initWithFrame:CGRectMake((WIN_WIDTH-100)/2.0, 60, 100, 80)];
    headIcon.layer.cornerRadius = 4;  // 将图层的边框设置为圆脚
    headIcon.layer.masksToBounds = YES; // 隐藏边界
    headIcon.image = [UIImage imageNamed:@"logo"];
    [self addSubview:headIcon];
    
    // 账户
    UITextField *accText = [[UITextField alloc] initWithFrame:CGRectMake(30, 190, WIN_WIDTH-60, 30)];
    NSString *keyUserName=[MOTUserDataManager readUserName];
    if (keyUserName.length) {
        accText.text = keyUserName;
    }
    accText.clearButtonMode = UITextFieldViewModeWhileEditing;
    accText.placeholder = @"请输入手机号";
    [self addSubview:accText];
    accText.delegate = self;
    
        //icon
//    UIImageView *accIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    accIcon.image = [UIImage imageNamed:@"icon_user"];
    UILabel *accIcon = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    accIcon.textAlignment = NSTextAlignmentLeft;
    accIcon.text = @"+86";
    accText.leftView = accIcon;
    accText.leftViewMode = UITextFieldViewModeAlways;
        // 线
    UIImageView *accImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 225, WIN_WIDTH-56, 2)];
    [self addSubview:accImage];
    accImage.image = [UIImage imageNamed:@"pic_line"];
    
    // 密码
    UITextField *passText = [[UITextField alloc] initWithFrame:CGRectMake(30, 240, WIN_WIDTH-60, 30)];
    NSString *keyPassWord=[MOTUserDataManager readPassWord];
    if (keyPassWord.length) {
        passText.text = keyPassWord;
    }
    passText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passText.placeholder = @"请输入密码";
    passText.secureTextEntry = YES;
    [self addSubview:passText];
    passText.delegate = self;
        //icon
    UILabel *passIcon = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    passIcon.textAlignment = NSTextAlignmentLeft;
    passIcon.text = @"密码";
    passText.leftView = passIcon;
    passText.leftViewMode = UITextFieldViewModeAlways;
        // 线
    UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 275, WIN_WIDTH-56, 2)];
    [self addSubview:passImage];
    passImage.image = [UIImage imageNamed:@"pic_line"];
    
    
    // 登录
    LButton = [[IANActivityIndicatorButton alloc] init];
    LButton.frame = CGRectMake(30, 300, WIN_WIDTH-60, (Windows_WIDTH-60)/7);
    LButton.backgroundColor = UIColorDJYThemecolorsRGB;
    
    [LButton setTitle:@"登录" forState:UIControlStateNormal];
    LButton.clipsToBounds = YES;
    LButton.layer.cornerRadius = 5.0f;
    [self addSubview:LButton];
    LButton.tag = 2423;
    __weak typeof(self) weakSelf = self;
    LButton.TouchBlock = ^(IANActivityIndicatorButton *myButton){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [myButton startButtonActivityIndicatorView];
        [strongSelf loginBtnClick];
    };

    // 注册 忘记密码
    UIButton *dlzcBtn = [UIButton buttonWithType:0];
    dlzcBtn.frame = CGRectMake(40, 360, 30, 25);
    [dlzcBtn setTitle:@"注册" forState:0];
    dlzcBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [dlzcBtn setTitleColor:UIColorDJYThemecolorsRGB forState:0];
    [self addSubview:dlzcBtn];
    [dlzcBtn addTarget:self action:@selector(zcBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *wjBtn = [UIButton buttonWithType:0];
    wjBtn.frame = CGRectMake(WIN_WIDTH-30-80, 360, 80, 25);
    [wjBtn setTitle:@"忘记密码？" forState:0];
    wjBtn.titleLabel.font = FONT(13);
    wjBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [wjBtn setTitleColor:UIColorDJYThemecolorsRGB forState:0];
    [self addSubview:wjBtn];
    [wjBtn addTarget:self action:@selector(wjBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    accText.tag = 201;
    accImage.tag = 301;
    
    passText.tag = 202;
    passImage.tag = 302;
    _minHeight = 340;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGSize size = [[UIScreen mainScreen] bounds].size;

    if (size.width<321) {

        if (_minHeight>WIN_HEIGHT-216-30 && self.djRegisterViewType==0) {
                [self setViewY:WIN_HEIGHT-216-30 - _minHeight animation:YES];
        }
        else if (_minHeight>WIN_HEIGHT-64-216-30 && self.djRegisterViewType==1) {
                [self setViewY:WIN_HEIGHT-64-216-30 - _minHeight animation:YES];
        }
    }
    else if (size.width<377){

        if (_minHeight>WIN_HEIGHT-64-258 && self.djRegisterViewType==0) {
                [self setViewY:WIN_HEIGHT-64-258 - _minHeight animation:YES];
        }
        else if (_minHeight>WIN_HEIGHT-258 && self.djRegisterViewType==1){
                [self setViewY:WIN_HEIGHT-258 - _minHeight animation:YES];
        }
    }
    else if (size.width>410){

        if (_minHeight>WIN_HEIGHT-64-271 && self.djRegisterViewType==0) {
                [self setViewY:WIN_HEIGHT-64-271 - _minHeight animation:YES];
        }
        else if (_minHeight>WIN_HEIGHT-271 && self.djRegisterViewType==1){
                [self setViewY:WIN_HEIGHT-271 - _minHeight animation:YES];
        }
    }
    UIImageView *im = (UIImageView *)[self viewWithTag:textField.tag+100];
    im.image = [UIImage imageNamed:@"textfield_activated_holo_light.9.png"];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self setViewY:0 animation:YES];
    UIImageView *im = (UIImageView *)[self viewWithTag:textField.tag+100];
    im.image = [UIImage imageNamed:@"pic_line"];
}
- (void)setViewY:(double)viewY animation:(BOOL)animation
{
    CGRect frame = self.frame;
    frame.origin.y = viewY;
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
    }
    else{
        self.frame = frame;
    }
}

- (void)loginBtnClick
{
    [self endEditing:YES];
    [self setViewY:0 animation:YES];
    if (self.action) {
        UITextField *acc = (UITextField *)[self viewWithTag:201];
        UITextField *key = (UITextField *)[self viewWithTag:202];
        self.action(acc.text,key.text,LButton);
    }
}
- (void)zcBtnClick
{
    [self endEditing:YES];
    [self setViewY:0 animation:YES];
    if (self.zcAction) {
        self.zcAction();
    }
}
- (void)wjBtnClick
{
    [self endEditing:YES];
    [self setViewY:0 animation:YES];
    if (self.wjAction) {
        self.wjAction();
    }
}





#pragma mark - 置密码界面
- (instancetype )initwithFrame:(CGRect)frame
                        action:(void (^)(NSString *key1,NSString *key2))action
{
    if ([self  initWithFrame:frame]) {
//        [self creatSetPass];
        self.setPassAction = action;
    }
    return self;
}

- (void)setPassBtnClick
{
    if (self.setPassAction) {
        UITextField *text1 = (UITextField *)[self viewWithTag:301];
        UITextField *text2 = (UITextField *)[self viewWithTag:302];
        self.setPassAction(text1.text,text2.text);
    }
}


#pragma mark - 1.找回密码 (界面)  2.输入手机号获取验证码界面
- (instancetype )initwithFrame:(CGRect)frame
         djRegisterViewTypeSMS:(DJRegisterViewTypeSMS)djRegisterViewTypeSMS
                       plTitle:(NSString *)plTitle
                         title:(NSString *)title
                            hq:(BOOL (^)(NSString *phoneStr))hqAction
                      tjAction:(void (^)(NSString *yzmStr))tjAction
{
    if ([self  initWithFrame:frame]) {
        [self creatZhaoHePassWithTitle:title plTitle:plTitle djRegisterViewTypeSMS:djRegisterViewTypeSMS];
        self.djRegisterViewTypeSms = djRegisterViewTypeSMS;
        self.hqAction = hqAction;
        self.tjAction = tjAction;
    }
    return self;
}
- (void)creatZhaoHePassWithTitle:(NSString *)title
                         plTitle:(NSString *)plTitle
           djRegisterViewTypeSMS:(DJRegisterViewTypeSMS)djRegisterViewTypeSMS
{
     // 找回密码 (界面)
    if (djRegisterViewTypeSMS == DJRegisterViewTypeNoScanfSMS) {
        // 验证码
        UITextField *passText = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, WIN_WIDTH-60, 30)];
        [self addSubview:passText];
        passText.placeholder = plTitle;
        [passText  setValue:[UIFont boldSystemFontOfSize:(13)] forKeyPath:@"_placeholderLabel.font"];
        passText.tag = 201;
        // 线
        UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 65, WIN_WIDTH-56, 2)];
        [self addSubview:passImage];
        passImage.image = [UIImage imageNamed:@"pic_line"];
        passText.keyboardType =  UIKeyboardTypeNumberPad;
        
        
        hqBtn = [UIButton buttonWithType:0];
        hqBtn.frame = CGRectMake(WIN_WIDTH-130, 30, 100, 25);
        [hqBtn setTitle:@"获取验证码" forState:0];
        hqBtn.backgroundColor = UIColorDJYThemecolorsRGB;
        [self addSubview:hqBtn];
        hqBtn.clipsToBounds = YES;
        hqBtn.layer.cornerRadius = 5.0f;
        [hqBtn addTarget:self action:@selector(hqBtnClick) forControlEvents:UIControlEventTouchUpInside];
        hqBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        zcBtn = [UIButton buttonWithType:0];
        zcBtn.frame = CGRectMake(30, 90, WIN_WIDTH-60, 40);
        [zcBtn setTitle:title forState:0];
        zcBtn.backgroundColor = UIColorDJYThemecolorsRGB;
        [self addSubview:zcBtn];
        zcBtn.clipsToBounds = YES;
        zcBtn.layer.cornerRadius = 5.0f;
        [zcBtn addTarget:self action:@selector(tjBtnClick) forControlEvents:UIControlEventTouchUpInside
         ];
    }
    
     // 输入手机号获取验证码界面
    else if (djRegisterViewTypeSMS == DJRegisterViewTypeScanfPhoneSMS ){
        
        // 手机号码
        UITextField *accText = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, WIN_WIDTH-60, 30)];
        [self addSubview:accText];
        accText.placeholder = @"请输入手机号码";
        SET_PLACE(accText);
        accText.tag = 501;

        //icon
        UIImageView *accIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        accIcon.image = [UIImage imageNamed:@"label_phone.png"];
        accText.leftView = accIcon;
        accText.leftViewMode = UITextFieldViewModeAlways;
        
        
        // 线
        UIImageView *accImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 65, WIN_WIDTH-56, 2)];
        [self addSubview:accImage];
        accImage.image = [UIImage imageNamed:@"pic_line"];
        
        
        
        
        // 密码
        UITextField *passText = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, WIN_WIDTH-60, 30)];
//        [self addSubview:passText];
        passText.placeholder = plTitle;
        SET_PLACE(passText);
        passText.tag = 201;
        
        
        // 线
        UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 115, WIN_WIDTH-56, 2)];
//        [self addSubview:passImage];
        passImage.image = [UIImage imageNamed:@"pic_line"];
        
        hqBtn = [UIButton buttonWithType:0];
        hqBtn.frame = CGRectMake(WIN_WIDTH-130, 80, 100, 25);
        [hqBtn setTitle:@"获取验证码" forState:0];
        hqBtn.backgroundColor = UIColorDJYThemecolorsRGB;
//        [self addSubview:hqBtn];
        hqBtn.clipsToBounds = YES;
        hqBtn.layer.cornerRadius = 5.0f;
        [hqBtn addTarget:self action:@selector(hqBtnClick) forControlEvents:UIControlEventTouchUpInside];
        hqBtn.titleLabel.font = FONT(13);
        
        zcBtn = [UIButton buttonWithType:0];
        zcBtn.frame = CGRectMake(30, 140, WIN_WIDTH-60, 40);
        zcBtn.center = CGPointMake(Windows_WIDTH/2, 115);
        [zcBtn setTitle:title forState:0];
        zcBtn.backgroundColor = UIColorDJYThemecolorsRGB;
        [self addSubview:zcBtn];
        zcBtn.clipsToBounds = YES;
        zcBtn.layer.cornerRadius = 5.0f;
        [zcBtn addTarget:self action:@selector(tjBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)hqBtnClick
{
    if (self.djRegisterViewTypeSms == DJRegisterViewTypeScanfPhoneSMS && self.hqAction) {
        UITextField *tex = (UITextField *)[self viewWithTag:501];
        if (self.hqAction(tex.text)) {
            timecount = 60;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
            [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(time) userInfo:nil repeats:NO];
            
            hqBtn.backgroundColor = [UIColor grayColor];
            hqBtn.userInteractionEnabled = NO;
            _isTime = YES;
            [NSTimer scheduledTimerWithTimeInterval:5*60.0 target:self selector:@selector(endTime) userInfo:nil repeats:NO];
        }
    }
    
    else if (self.djRegisterViewTypeSms == DJRegisterViewTypeNoScanfSMS && self.hqAction)
    {
        if (self.hqAction(nil)) {
            timecount = 60;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
            [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(time) userInfo:nil repeats:NO];
            
            hqBtn.backgroundColor = [UIColor grayColor];
            hqBtn.userInteractionEnabled = NO;
            _isTime = YES;
            [NSTimer scheduledTimerWithTimeInterval:5*60.0 target:self selector:@selector(endTime) userInfo:nil repeats:NO];
        }
    }
}

- (void)tjBtnClick
{
    if (self.tjAction) {
        UITextField *tex = (UITextField *)[self viewWithTag:501];
        //改传手机号
        self.tjAction(tex.text);
    }
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
@end
