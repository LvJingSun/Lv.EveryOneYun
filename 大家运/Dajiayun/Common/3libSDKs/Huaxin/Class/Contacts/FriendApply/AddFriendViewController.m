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

#import "AddFriendViewController.h"

#import "ApplyViewController.h"
#import "AddFriendCell.h"
#import "InvitationManager.h"

@interface AddFriendViewController ()<UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableDictionary *dataDic;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation AddFriendViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [NSMutableArray array];
        _dataDic = [NSMutableDictionary dictionary];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.title = NSLocalizedString(@"friend.add", @"Add friend");
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    self.tableView.tableFooterView = footerView;
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [searchButton setTitle:NSLocalizedString(@"search", @"Search") forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:32 / 255.0 green:134 / 255.0 blue:158 / 255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:searchButton]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self.view addSubview:self.textField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        if (self.ScanAddFriendPhone.length!=0) {
            _textField.text = self.ScanAddFriendPhone;
        }
        if (self.sendAddPhone.length!=0) {
            _textField.text = self.sendAddPhone;
            
            [self getmemberInfoFrmophone:self.sendAddPhone];
            
            [self showMessageAlertView];
            
        }
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = NSLocalizedString(@"friend.inputNameToSearch", @"input to find friends");
        _textField.placeholder = @"输入手机号查找";
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
    }
    
    return _textField;
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
        _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        
        [_headerView addSubview:_textField];
    }
    
    return _headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddFriendCell";
    AddFriendCell *cell = (AddFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[AddFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"photoMid"]]] placeholderImage:[UIImage imageNamed:@"chatListCellHead"] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
        [self CachesDirectoryImagePath:[NSString stringWithFormat:@"%@%@",DJY_headimage_data,[NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"photoMid"]]] data:image];
    }];
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndexPath = indexPath;
    NSString *buddyName = [self.dataSource objectAtIndex:indexPath.row];
    if ([self didBuddyExist:buddyName]) {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeat", @"'%@'has been your friend!"), buddyName];
        
        [EMAlertView showAlertWithTitle:message
                                message:nil
                        completionBlock:nil
                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                      otherButtonTitles:nil];
        
    }
    else if([self hasSendBuddyRequest:buddyName])
    {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatApply", @"you have send fridend request to '%@'!"), buddyName];
        [EMAlertView showAlertWithTitle:message
                                message:nil
                        completionBlock:nil
                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                      otherButtonTitles:nil];
        
    }else{
        [self showMessageAlertView];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - action

- (void)searchAction
{
    [_textField resignFirstResponder];
    if(_textField.text.length > 0)
    {
#warning 由用户体系的用户，需要添加方法在已有的用户体系中查询符合填写内容的用户
#warning 以下代码为测试代码，默认用户体系中有一个符合要求的同名用户
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        if ([_textField.text isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notAddSelf", @"can't add yourself as a friend") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        //判断是否已发来申请
        NSArray *applyArray = [[ApplyViewController shareController] dataSource];
        if (applyArray && [applyArray count] > 0) {
            for (ApplyEntity *entity in applyArray) {
                ApplyStyle style = [entity.style intValue];
                BOOL isGroup = style == ApplyStyleFriend ? NO : YES;
                if (!isGroup && [entity.applicantUsername isEqualToString:_textField.text]) {
                    NSString *str = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatInvite", @"%@ have sent the application to you"), _textField.text];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:str delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    return;
                }
            }
        }
//        [self.dataSource removeAllObjects];
//        [self.dataSource addObject:_textField.text];
//        [self.tableView reloadData];
        
        [self getmemberInfoFrmophone:_textField.text];
    }
}

- (BOOL)hasSendBuddyRequest:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState == eEMBuddyFollowState_NotFollowed &&
            buddy.isPendingApproval) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState != eEMBuddyFollowState_NotFollowed) {
            return YES;
        }
    }
    return NO;
}

- (void)showMessageAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:NSLocalizedString(@"saySomething", @"say somthing")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                                          otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *username = [loginInfo objectForKey:kSDKUsername];
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@：%@", username, messageTextField.text];
        }
        else{
            messageStr = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyInvite", @"%@ invite you as a friend"), username];
        }
        [self sendFriendApplyAtIndexPath:self.selectedIndexPath
                                 message:messageStr];
    }
}

- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath
                           message:(NSString *)message
{
    NSString *buddyName = [self.dataSource objectAtIndex:indexPath.row];
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:[_dataDic objectForKey:@"memberId"] message:message error:&error];
        [self hideHud];
        if (error) {
            [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
        }
        else{
            [self requestAddFriends:[_dataDic objectForKey:@"memberId"]];
//            [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//添加好友审请
- (void)requestAddFriends:(NSString *)ids{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            ids, @"toMemberId",
                            nil];

    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/AddFriends" params:params networkBlock:^{
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        
        [self showHint:((NSDictionary *)responseObject)[@"Msg"]];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
        [self showHint:@"添加失败"];
        
    }];
}

//*根据手机号获取会员信息*********************************************
- (void)getmemberInfoFrmophone:(NSString *)phone{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            phone, @"phone",
                            nil];

    [SVProgressHUD showWithStatus:@"正在请求..."];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GetMemberByPhone" params:params networkBlock:^{
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            [_dataDic setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"memberId"]] forKey:@"memberId"];
            [_dataDic setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"photoMid"]] forKey:@"photoMid"];
            [_dataDic setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"phone"]] forKey:@"phone"];
            [_dataDic setObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"nickName"]] forKey:@"nickName"];
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"nickName"]]];
            [self.tableView reloadData];
        }else
        {
            [self.view makeToast:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Msg"]]];

        }

        [SVProgressHUD dismiss];

    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


/**
 * 存储数据
 */
- (void)CachesDirectoryImagePath:(NSString *)fileName data:(UIImage *)image;{
    NSData* imageData = UIImagePNGRepresentation(image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [imageData writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName] atomically:YES];
}


@end
