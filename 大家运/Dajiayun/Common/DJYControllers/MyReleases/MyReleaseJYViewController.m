//
//  MyReleaseJYViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/4/5.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "MyReleaseJYViewController.h"

@interface MyReleaseJYViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSInteger pageIndex;
    UITableView *M_tableview;
    NSIndexPath *_indexPath;
}
@property (nonatomic, strong) NSMutableArray            *dataArr;


@end

@implementation MyReleaseJYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setedgesForExtendedLayoutNO];
    pageIndex = 1;
    self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    
    [self allocexamplerefresh];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    
    longPress.minimumPressDuration = 1.0;
    
    [M_tableview addGestureRecognizer:longPress];
}

- (void)longPressClick:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [gesture locationInView:M_tableview];
        
        _indexPath = [M_tableview indexPathForRowAtPoint:point];
        
        if (_indexPath == nil) {
            
            return;
            
        }else {
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
            
            [sheet showInView:self.view];
            
        }
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ((int)buttonIndex == 0) {
        NSDictionary *cheInfo = self.dataArr[_indexPath.row];
        NSString *infoID = [cheInfo objectForKey:@"jycInfoId"];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                                [CachesDirectory getServerKey],@"key",
                                @"3",@"type",
                                infoID,@"infoID",
                                nil];
        [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/DeleteInfo" params:params networkBlock:^{
            [self.view makeToast:@"没有网络!"];
        } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
            BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
            if (success) {
                [self.view makeToast:[responseObject valueForKey:@"Msg"]];
            }else {
                [self.view makeToast:[responseObject valueForKey:@"Msg"]];
            }
            [M_tableview.header beginRefreshing];
            [M_tableview reloadData];
        } failedBlock:^(AFCustomClient *request, NSError *error) {
            [M_tableview.header beginRefreshing];
            [self.view makeToast:@"删除失败"];
            
        }];
        
    }
    
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
    static NSString *cellIdentifier = @"DJYXIBTableViewCell3";
    DJYXIBTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        cell = (DJYXIBTableViewCell3 *)[nib objectAtIndex:3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *jycInfo = self.dataArr[indexPath.row];
    cell.fromAddress.text = [jycInfo objectForKey:@"fromAddress"];
    cell.toAddress.text = [jycInfo objectForKey:@"toAddress"];
    cell.createDate.text = [jycInfo objectForKey:@"createDate"];
    cell.faCheShiJian.text = [jycInfo objectForKey:@"faCheShiJian"];
    cell.statusName.text = [jycInfo objectForKey:@"statusName"];
    cell.statusName.text = [NSString stringWithFormat:@"%@...",[jycInfo objectForKey:@"statusName"]];
    NSString *jycType = [jycInfo objectForKey:@"jycType"];
    if ([jycType isEqualToString:@"JYCSml"]) {
        cell.cheWeiShu.text = [NSString stringWithFormat:@"空闲车位:%@(小)",[jycInfo objectForKey:@"cheWeiShu"]];
    }else if ([jycType isEqualToString:@"JYCMid"]) {
        cell.cheWeiShu.text = [NSString stringWithFormat:@"空闲车位:%@(中)",[jycInfo objectForKey:@"cheWeiShu"]];
    }else if ([jycType isEqualToString:@"JYCBig"]) {
        cell.cheWeiShu.text = [NSString stringWithFormat:@"空闲车位:%@(大)",[jycInfo objectForKey:@"cheWeiShu"]];
    }else{
        cell.cheWeiShu.text = [NSString stringWithFormat:@"空闲车位:%@",[jycInfo objectForKey:@"cheWeiShu"]];
    }
    cell.call.tag = indexPath.row;
    [cell.call addTarget:self action:@selector(AlertSure:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *tuJingChengShi = [jycInfo objectForKey:@"tuJingChengShi"];
    NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
    if ([[self GETtujingCityName:tujingArr] isEqualToString:@""]) {
        [cell setFrame:CGRectMake(0, 0, Windows_WIDTH, 120)];
        cell.tujingchengshiimg.hidden = YES;
        cell.tuJingChengShi.text = @"";
    }else {
        [cell setFrame:CGRectMake(0, 0, Windows_WIDTH, 150)];
        cell.tujingchengshiimg.hidden = NO;
        NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
        cell.tuJingChengShi.text = [NSString stringWithFormat:@"途经城市：%@",[self GETtujingCityName:tujingArr]];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *wlcInfo = self.dataArr[indexPath.row];
    NSString *tuJingChengShi = [wlcInfo objectForKey:@"tuJingChengShi"];
    NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
    if ([[self GETtujingCityName:tujingArr] isEqualToString:@""]) {
        return 120.f;
    }else {
        return 150.f;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section  {
    return MINFOLATInSection;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return HeightForHeaderInSection;
}


#pragma mark - 商品车列表
- (void)requestMyJYCInfoList{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/MyJYCInfoList" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            self.dataArr = [responseObject valueForKey:@"jycList"];
            [self showReloadViewWithArray:self.dataArr WithMsg:@"暂无数据，轻点试试刷新" Withtableview:M_tableview];
        }
        [M_tableview.header endRefreshing];
        [M_tableview reloadData];
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
    [self requestMyJYCInfoList];
}

- (void)AlertSure:(UIButton *)sender{
    NSDictionary *jycInfoDIC = self.dataArr[sender.tag];
    NSString *phone = [jycInfoDIC objectForKey:@"phone"];
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
