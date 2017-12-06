//
//  MyReleaseWLViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/1/29.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ReportRViewController.h"

@interface ReportRViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *M_tableview;
    NSInteger pageIndex;

}
@property (nonatomic, strong) NSMutableArray            *dataArr;

@end


@implementation ReportRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setedgesForExtendedLayoutNO];
    self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    pageIndex = 1;
    [self allocexamplerefresh];
    [self allocexamplemore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//上个界面传过来传赋值（FirstViewController）
- (void)setDJYXBParamdic:(NSMutableDictionary *)DJYXBParamdic
{
    
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
    static NSString *cellIdentifier = @"DJYXIBTableViewCell8";
    DJYXIBTableViewCell8 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        cell = (DJYXIBTableViewCell8 *)[nib objectAtIndex:8];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dbsxDIC = self.dataArr[indexPath.row];
    cell.statusName.text = [dbsxDIC objectForKey:@"statusName"];
    cell.statusName.textColor = RGBColor(255, 210, 80);
    cell.desciprion.text = [dbsxDIC objectForKey:@"desciprion"];
    cell.createDate.text = [dbsxDIC objectForKey:@"createDate"];
    cell.fromAddress.text = [dbsxDIC objectForKey:@"fromAddress"];
    cell.toAddress.text = [dbsxDIC objectForKey:@"toAddress"];
    cell.call.tag = indexPath.row;
    [cell.call addTarget:self action:@selector(AlertSure:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 175.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section  {
    return 0.00001f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return HeightForHeaderInSection;
}

#pragma mark - 代办事项-当前的
- (void)requestDaiBanShiXiangList{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            @"3",@"type",
                            [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                            PageSizeTableView,@"pageSize",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/DaiBanShiXiangList" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            if (pageIndex==1) {
                NSLog(@"成功");
                self.dataArr = [responseObject valueForKey:@"dbsxList"];
                [M_tableview.header endRefreshing];
                if (self.dataArr.count<[PageSizeTableView integerValue]) {
                    [M_tableview.footer endRefreshingWithNoMoreData];
                    [self showReloadViewWithArray:self.dataArr WithMsg:@"暂无数据，轻点试试刷新" Withtableview:M_tableview];
                }else{
                    [M_tableview.footer resetNoMoreData];
                }
            }else{
                NSArray *reArr = [responseObject valueForKey:@"dbsxList"];
                if (reArr.count) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.dataArr];
                    [array addObjectsFromArray:reArr];
                    self.dataArr =array;
                    [M_tableview.footer endRefreshing];
                    if (reArr.count<[PageSizeTableView integerValue]) {
                        [M_tableview.footer endRefreshingWithNoMoreData];
                    }else{
                        [M_tableview.footer resetNoMoreData];
                    }
                }else{
                    pageIndex --;
                }
                
            }
            [M_tableview reloadData];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {

        [M_tableview.footer endRefreshing];
        
    }];
}

#pragma mark UITableView + 下拉刷新 默认
- (void)allocexamplerefresh
{
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(M_tableviewrefresh)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    M_tableview.header = header;
}
- (void)M_tableviewrefresh
{
    pageIndex =1;
    [self requestDaiBanShiXiangList];
}

#pragma mark UITableView + 上拉刷新 默认
- (void)allocexamplemore
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(M_tableviewmore)];
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    // 设置footer
    M_tableview.footer = footer;
}

- (void)M_tableviewmore
{
    pageIndex ++;
//    [self requestDaiBanShiXiangList];
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




@end
