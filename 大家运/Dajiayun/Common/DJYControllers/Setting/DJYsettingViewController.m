//
//  DJYsettingViewController.m
//  Dajiayun
//
//  Created by CityAndCity on 16/1/31.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "DJYsettingViewController.h"
#import "ApplyViewController.h"
#import "SettingsViewController.h"
#import "WJViewController.h"
#import "DjyPublicWebViewController.h"
#import "AppDelegate.h"

@interface DJYsettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *M_tableview;
    
}


@end

@implementation DJYsettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setedgesForExtendedLayoutNO];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    M_tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).IsNewUpdate isEqualToString:@"1"]) {
                return 4;
            }
            return 3;
            break;
        case 2:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return HeightForHeaderInSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return MINFOLATInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *Identifier = @"DJYsetting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    if (indexPath.section==0) {
        cell.imageView.image = [UIImage imageNamed:@"29"];
        cell.textLabel.text = @"消息设置";
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            cell.imageView.image = [UIImage imageNamed:@"27"];
            cell.textLabel.text = @"修改密码";
        }else if (indexPath.row==1){
            cell.imageView.image = [UIImage imageNamed:@"28"];
            cell.textLabel.text = @"帮助中心";
        }else if (indexPath.row==2){
            cell.imageView.image = [UIImage imageNamed:@"14"];
            [self setLayer:cell.imageView andcornerRadius:cell.imageView.frame.size.width/2];
            cell.textLabel.text = @"关于我们";
        }else if (indexPath.row==3){
            cell.imageView.image = [UIImage imageNamed:@"12"];
            [self setLayer:cell.imageView andcornerRadius:cell.imageView.frame.size.width/2];
            cell.textLabel.text = @"检测版本";
            cell.detailTextLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        }
    }else if (indexPath.section==2){
        static NSString *cellIdentifier = @"DJYXIBTableViewCell6";
        DJYXIBTableViewCell6 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
            cell = (DJYXIBTableViewCell6 *)[nib objectAtIndex:6];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    return HeightForRowInSection;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        SettingsViewController *VC = [[SettingsViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];     
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            [self SendverificationSure];
        }else if (indexPath.row==1){
            DjyPublicWebViewController *VC = [[DjyPublicWebViewController alloc]initWithDjyPublicWebType:helper];
            [self PUSHWithBlockView:VC andblock:nil];
        }else if (indexPath.row==2){
            DjyPublicWebViewController *VC = [[DjyPublicWebViewController alloc]initWithDjyPublicWebType:about];
            [self PUSHWithBlockView:VC andblock:nil];
        }else if (indexPath.row==3){
            [self onCheckVersion];
        }
    }
    else if (indexPath.section==2) {
        [self cancellationAction];
    }
    
}


- (void)cancellationAction
{
    MMPopupItemHandler block = ^(NSInteger index){
        [self logoutAction];
    };
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finish){

    };
    NSArray *items =
    @[MMItemMake(@"退出登录", MMItemTypeHighlight, block)];
    
    [[[MMSheetView alloc] initWithTitle:nil
                                  items:items] showWithBlock:completeBlock];
    
}

- (void)logoutAction
{
    __weak DJYsettingViewController *weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"setting.logoutOngoing", @"loging out...")];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        [weakSelf hideHud];
        if (error && error.errorCode != EMErrorServerNotLogin) {
            [weakSelf showHint:error.description];
        }
        else{
            [[ApplyViewController shareController] clear];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        }
    } onQueue:nil];
}

- (void)SendverificationSure
{
    MMPopupItemHandler block = ^(NSInteger index){

        if (index) {
            [self Sendverificationcode];
        }
    };
    NSArray *items =
    @[MMItemMake(@"取消", MMItemTypeNormal, block),
      MMItemMake(@"发送验证码", MMItemTypeNormal, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"系统将会发送短信验证到您的手机,确定发送？"
                                                         detail:nil
                                                          items:items];
    alertView.attachedView = [MMPopupWindow sharedWindow];
    [alertView show];
    
}

-(void)Sendverificationcode{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",                             nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/SendChangePwdSmsCode" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            WJViewController *VC = [[WJViewController alloc]initWithTitle:@"修改密码"];
            [self.navigationController pushViewController:VC animated:YES];
        }
        [SVProgressHUD dismiss];
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [SVProgressHUD dismiss];
    }];
}

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
            NSString *CFBundleShortVersionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            if ([[appsVersion objectForKey:@"versionNumber"] floatValue]>[CFBundleShortVersionString floatValue]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有新版本啦"
                                                                    message:[appsVersion objectForKey:@"coreIntro"]
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"立即更新", nil];
                alertView.tag = 99999;
                
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"已经是最新版本啦"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil, nil];
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
        if ( buttonIndex == 1 ) {
            // 点击进入版本升级的url-appStore下载的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/da-jia-yun/id1077964360?l=zh&ls=1&mt=8"]];
        }
    }
}

@end
