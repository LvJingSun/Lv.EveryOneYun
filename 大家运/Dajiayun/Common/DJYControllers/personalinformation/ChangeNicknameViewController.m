//
//  ChangeNicknameViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/2/22.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ChangeNicknameViewController.h"

@interface ChangeNicknameViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *M_tableview;
    NSString *Nickname;

}


@end

@implementation ChangeNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    Nickname = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
    [self setedgesForExtendedLayoutNO];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    
    self.navigationItem.rightBarButtonItem = [self SetnavigationBartitle:@"完成" andaction:@selector(ChangeNickname)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    M_tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"DJYXIBTableViewCell11";
    DJYXIBTableViewCell11 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        cell = (DJYXIBTableViewCell11 *)[nib objectAtIndex:11];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.titlefield.text = Nickname;
    cell.titlefield.delegate = self;

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return HeightForRowInSection;
}

- (void)textFieldDidEndEditing:(UITextField *)textField; {
    Nickname = textField.text;
}

- (void)ChangeNickname{
    [self.view endEditing:YES];
    if (Nickname.length==0) {
        [self.view makeToast:@"请输入昵称"];
        return;
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            Nickname,@"nickName",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/ModifyNickName" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            [CachesDirectory addValue:Nickname andKey:CachesDirectory_MemberInfo_NickName];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
    }];
}

@end
