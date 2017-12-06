//
//  MyDJYContactViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/1/29.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "MyDJYContactViewController.h"
#import "MyDJYContactDetailViewController.h"

@interface MyDJYContactViewController ()<UITableViewDataSource,UITableViewDelegate,delegate>
{
    UITableView *M_tableview;
    
    NSString *ChoseType;
}
@property (nonatomic, strong) NSMutableArray            *dataArr;

@end


@implementation MyDJYContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的联系人";
   self.navigationItem.rightBarButtonItem = [self SetNavigationBarImage:@"5" andaction:@selector(RightAction)];
    [self setedgesForExtendedLayoutNO];
    self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    [self allocexamplerefresh];

    [self allocDIC];
}

- (void)allocDIC{

    ChoseType = [self.PushDICParams objectForKey:@"ChoseContact"];
    
}

- (void)RightAction{

    MyDJYContactDetailViewController *VC = [[MyDJYContactDetailViewController alloc]initXLtitle:@"新增联系人" anddic:nil];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];

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
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"DJYXIBTableViewCell13";
    DJYXIBTableViewCell13 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        cell = (DJYXIBTableViewCell13 *)[nib objectAtIndex:13];
    }
    NSDictionary *dbsxDIC = self.dataArr[indexPath.row];
    cell.phone.text = [dbsxDIC objectForKey:@"phone"];
    cell.name.text = [dbsxDIC objectForKey:@"name"];
    cell.modifyDate.text = [dbsxDIC objectForKey:@"modifyDate"];
    cell.address.text = [dbsxDIC objectForKey:@"address"];
    cell.Callphone.tag = indexPath.row;
    [cell.Callphone addTarget:self action:@selector(AlertSure:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 150.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section  {
    return MINFOLATInSection;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return HeightForHeaderInSection;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dbsxDIC = self.dataArr[indexPath.row];
    if ([ChoseType isEqualToString:@"YES"]) {
        [self POPViewControllerForDictionary:dbsxDIC];
    }else{
    MyDJYContactDetailViewController *VC = [[MyDJYContactDetailViewController alloc]initXLtitle:@"编辑联系人" anddic:dbsxDIC];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - 我的联系人
- (void)requestMyLinkerList{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/MyLinkerList" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            self.dataArr = [responseObject valueForKey:@"linkerList"];
            [self showReloadViewWithArray:self.dataArr WithMsg:@"暂无数据，轻点试试刷新" Withtableview:M_tableview];
            [M_tableview.header endRefreshing];
            [M_tableview reloadData];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
        [M_tableview.footer endRefreshing];

    }];
}

#pragma mark UITableView + 下拉刷新 默认
- (void)allocexamplerefresh
{
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMyLinkerList)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    M_tableview.header = header;
}

- (void)AlertSure:(UIButton *)sender{
    NSDictionary *wlcInfoDIC = self.dataArr[sender.tag];
    NSString *phone = [wlcInfoDIC objectForKey:@"phone"];
    MMPopupItemHandler block = ^(NSInteger index){
        NSLog(@"clickd %@ button",@(index));
        if (index) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
        }
    };
    NSArray *items =
    @[MMItemMake(@"取消", MMItemTypeNormal, block),
      MMItemMake(@"拨打", MMItemTypeNormal, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:phone
                                                         detail:nil
                                                          items:items];
    alertView.attachedView = [MMPopupWindow sharedWindow];
    [alertView show];
}


-(void)ActionSuccess{
    [self requestMyLinkerList];
}



@end
