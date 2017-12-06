/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "UserProfileViewController.h"

#import "ChatViewController.h"
#import "UserProfileManager.h"
#import "UIImageView+HeadImage.h"

@interface UserProfileViewController ()
{
    Contact *Member;

}
@property (strong, nonatomic) UserProfileEntity *user;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *usernameLabel;

@end

@implementation UserProfileViewController

- (instancetype)initWithUsername:(NSString *)username
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _username = username;
        Member = [ContactsDao queryDataMember:[_username intValue]];
        [self getmemberInfoFrmoID:_username];
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"title.profile", @"Profile");
    
    self.view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.allowsSelection = NO;
    
    [self setupBarButtonItem];
    [self loadUserProfile];
}

- (UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.frame = CGRectMake(20, 10, 60, 60);
        _headImageView.contentMode = UIViewContentModeScaleToFill;
    }
    [_headImageView imageWithUsername:_username placeholderImage:nil];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:Member.photoMid]];
    return _headImageView;
}

- (UILabel*)usernameLabel
{
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10.f, 10, 200, 20);
        _usernameLabel.text = Member.nickName;
        _usernameLabel.textColor = [UIColor lightGrayColor];
    }
    return _usernameLabel;
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    if ([loginUsername isEqualToString:[NSString stringWithFormat:@"%d",Member.memberId]]) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 0) {
        //cell.textLabel.text = NSLocalizedString(@"setting.personalInfoUpload", @"Upload HeadImage");
        [cell.contentView addSubview:self.headImageView];
        [cell.contentView addSubview:self.usernameLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = NSLocalizedString(@"setting.profileNickname", @"Nickname");
        UserProfileEntity *entity = [[UserProfileManager sharedInstance] getUserProfileByUsername:_username];
        if (entity && entity.nickname.length>0) {
            cell.detailTextLabel.text = entity.nickname;
        } else {
            cell.detailTextLabel.text = _username;
            cell.detailTextLabel.text = Member.nickName;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 2){
        static NSString *cellIdentifier = @"DJYXIBTableViewCell6";
        DJYXIBTableViewCell6 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
            cell = (DJYXIBTableViewCell6 *)[nib objectAtIndex:6];
            cell.titlelabel.text = @"删除聊天记录";
            
        }
        return cell;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self clearAction];
    }
}

- (void)setupBarButtonItem
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)loadUserProfile
{
    [self hideHud];
//    [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
    __weak typeof(self) weakself = self;
    [[UserProfileManager sharedInstance] loadUserProfileInBackground:@[_username] saveToLoacal:YES completion:^(BOOL success, NSError *error) {
        [weakself hideHud];
        if (success) {
            [weakself.tableView reloadData];
        }
    }];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//*根据id获取会员信息*********************************************
- (void)getmemberInfoFrmoID:(NSString *)Ids{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            Ids, @"Ids",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GetMemberInfoByIds" params:params networkBlock:^{
        
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSArray *memberList =[responseObject valueForKey:@"memberList"];
            if ([memberList isKindOfClass:[NSArray class]]&&memberList.count!=0) {
                NSDictionary * MemberInfo = memberList[0];
                Member = [Contact objectWithKeyValues:MemberInfo];
                [self updatamemberIndb:Member];
                [self.tableView reloadData];
            }
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
    }];
}

- (void)updatamemberIndb:(Contact *)MemberInfo{
    if ([ContactsDao queryDataISMember:MemberInfo.memberId]) {
        [ContactsDao updateData:MemberInfo];
    }else{
        [ContactsDao insertData:MemberInfo];
    }
}

- (void)clearAction
{
    [EMAlertView showAlertWithTitle:NSLocalizedString(@"prompt", @"Prompt")
                            message:NSLocalizedString(@"sureToDelete", @"please make sure to delete")
                    completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
                        if (buttonIndex == 1) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllMessages" object:[NSString stringWithFormat:@"%d",Member.memberId]];
                        }
                    } cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                  otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    
}

@end
