//
//  ContactDetailController.m
//  Dajiayun
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ContactDetailController.h"
#import "DetailHeadView.h"
#import "HeadCell.h"
#import "PingjiaCell.h"
#import "WuliuCell.h"

#define VIEWWIDTH self.view.bounds.size.width
#define VIEWHEIGHT self.view.bounds.size.height

@interface ContactDetailController ()<UITableViewDelegate,UITableViewDataSource> {

    NSInteger pageIndex;
    
    
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) DetailHeadView *headview;

@property (nonatomic, strong) NSMutableArray *qitaArray;

@end

@implementation ContactDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.qitaArray = [NSMutableArray array];

    [self initTitle];
    
    [self initWithTableview];
    
    [self initWithHeadView];
    
    [self allocexamplerefresh];
    
    [self allocexamplemore];
    
}

- (void)initTitle {

    self.title = @"信息详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

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
    self.tableview.header = header;
    
}

- (void)M_tableviewrefresh
{
    pageIndex = 1;
    
    switch (self.type) {
        case 0:
        {
        
            [self requestWLCListWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
            break;
            
        case 1:
        {
            
            [self requestSPCListWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
            break;
            
        case 2:
        {
            
            [self requestJYCListWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)requestWLCListWithPageIndex:(NSString *)page{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.cheInfoId,@"CheInfoID",
//                            @"161",@"CheInfoID",
                            page,@"pageIndex",
                            nil];
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"WLCWebService.asmx/WLCDetial" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            
            if (pageIndex==1) {
                
                self.headview.iconImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[responseObject valueForKey:@"PhotoBig"]]]];
                
                self.headview.fromPlace.text = [responseObject valueForKey:@"fromAddress"];
                
                self.headview.toPlace.text = [responseObject valueForKey:@"toAddress"];
                
                self.headview.expectPrice.text = [NSString stringWithFormat:@"%@元",[responseObject valueForKey:@"YunFei"]];
                
              self.headview.fabuTime.text = [NSString stringWithFormat:@"发布时间:%@",[responseObject valueForKey:@"PublicDate"]];
                
                if ([[responseObject valueForKey:@"tuJingChengShi"] isEqualToString:@""]) {
                    
                    self.headview.citys.text = @"暂无途经城市";
                    
                }else {
                    
                    self.headview.citys.text = [responseObject valueForKey:@"tuJingChengShi"];
                    
                }
                
                self.headview.facheTime.text = [responseObject valueForKey:@"faCheShiJian"];
                
                self.headview.phone.text = [responseObject valueForKey:@"linkPhone"];
                
                if ([[responseObject valueForKey:@"QiTa"] isEqualToString:@""]) {
                    
                    self.headview.instructions.text = @"暂无说明";
                    
                    [self.headview.zhankaiBtn setUserInteractionEnabled:NO];
                    
                }else {
                    
                    self.headview.instructions.text = [responseObject valueForKey:@"QiTa"];
                    
                    [self.headview.zhankaiBtn setUserInteractionEnabled:YES];
                    
                }
                
                self.headview.cheType.text = @"物流车";
                
                self.qitaArray = [responseObject valueForKey:@"wlcQiTa"];
                
                [self.tableview.header endRefreshing];
                
                if (self.qitaArray.count<[PageSizeTableView2 integerValue]) {
                    
                    [self.tableview.footer endRefreshingWithNoMoreData];
                    
                }else{
                    
                    [self.tableview.footer resetNoMoreData];
                    
                }
                
            }else {
                
                NSArray *reArr = [responseObject valueForKey:@"wlcQiTa"];
                if (reArr.count) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.qitaArray];
                    [array addObjectsFromArray:reArr];
                    self.qitaArray =array;
                    [self.tableview.footer endRefreshing];
                    if (reArr.count<[PageSizeTableView2 integerValue]) {
                        [self.tableview.footer endRefreshingWithNoMoreData];
                    }else{
                        [self.tableview.footer resetNoMoreData];
                    }
                }else{
                    pageIndex --;
                }

            }
            
            [self.tableview reloadData];
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.tableview.header endRefreshing];

    }];
    
}

- (void)requestSPCListWithPageIndex:(NSString *)page{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.cheInfoId,@"CheInfoID",
                            page,@"pageIndex",
                            nil];

    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"SPCWebService.asmx/SPCDetial" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            
            if (pageIndex==1) {
            
                self.headview.iconImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[responseObject valueForKey:@"PhotoBig"]]]];
                
                self.headview.fromPlace.text = [responseObject valueForKey:@"fromAddress"];
                
                self.headview.toPlace.text = [responseObject valueForKey:@"toAddress"];
                
                self.headview.expectPrice.text = [NSString stringWithFormat:@"%@元",[responseObject valueForKey:@"YunFei"]];
    
                if ([[responseObject valueForKey:@"tuJingChengShi"] isEqualToString:@""]) {
                    
                    self.headview.citys.text = @"暂无途经城市";
                    
                }else {
                
                    self.headview.citys.text = [responseObject valueForKey:@"tuJingChengShi"];
                
                }
    
                self.headview.facheTime.text = [responseObject valueForKey:@"faCheShiJian"];
                
                self.headview.phone.text = [responseObject valueForKey:@"linkPhone"];
    
                if ([[responseObject valueForKey:@"QiTa"] isEqualToString:@""]) {
                    
                    self.headview.instructions.text = @"暂无说明";
                    
                    [self.headview.zhankaiBtn setUserInteractionEnabled:NO];
                    
                }else {
                
                    self.headview.instructions.text = [responseObject valueForKey:@"QiTa"];
                    
                    [self.headview.zhankaiBtn setUserInteractionEnabled:YES];
                    
                }
                
                self.headview.cheType.text = [NSString stringWithFormat:@"%@ %@辆",[responseObject valueForKey:@"cheXingHao"],[responseObject valueForKey:@"cheWeiShu"]];
                
//                if (self.qitaArray.count == 0) {
//                    
//                }else {
//                
//                    [self.qitaArray removeAllObjects];
//                    
//                }
                
                self.qitaArray = [responseObject valueForKey:@"spcQiTa"];

                [self.tableview.header endRefreshing];

                if (self.qitaArray.count<[PageSizeTableView2 integerValue]) {
                
                    [self.tableview.footer endRefreshingWithNoMoreData];
                
                }else{

                    [self.tableview.footer resetNoMoreData];
                    
                }
            
            }else {
                
                NSArray *reArr = [responseObject valueForKey:@"spcQiTa"];
                if (reArr.count) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.qitaArray];
                    [array addObjectsFromArray:reArr];
                    self.qitaArray =array;
                    [self.tableview.footer endRefreshing];
                    if (reArr.count<[PageSizeTableView2 integerValue]) {
                        [self.tableview.footer endRefreshingWithNoMoreData];
                    }else{
                        [self.tableview.footer resetNoMoreData];
                    }
                }else{
                    pageIndex --;
                }
                
            }
            
            [self.tableview reloadData];
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.tableview.header endRefreshing];

    }];
    
}

- (void)requestJYCListWithPageIndex:(NSString *)page{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.cheInfoId,@"CheInfoID",
                            page,@"pageIndex",
                            nil];
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"JYCWebService.asmx/JYCDetial" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            
            if (pageIndex==1) {
                
                self.headview.iconImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[responseObject valueForKey:@"PhotoBig"]]]];
                
                self.headview.fromPlace.text = [responseObject valueForKey:@"fromAddress"];
                
                self.headview.toPlace.text = [responseObject valueForKey:@"toAddress"];
                
                self.headview.expectPrice.text = [NSString stringWithFormat:@"%@元",[responseObject valueForKey:@"YunFei"]];
                
                if ([[responseObject valueForKey:@"tuJingChengShi"] isEqualToString:@""]) {
                    
                    self.headview.citys.text = @"暂无途经城市";
                    
                }else {
                    
                    self.headview.citys.text = [responseObject valueForKey:@"tuJingChengShi"];
                    
                }
                
                self.headview.facheTime.text = [responseObject valueForKey:@"faCheShiJian"];
                
                self.headview.phone.text = [responseObject valueForKey:@"linkPhone"];
                
                if ([[responseObject valueForKey:@"QiTa"] isEqualToString:@""]) {
                    
                    self.headview.instructions.text = @"暂无说明";
                    
                    [self.headview.zhankaiBtn setUserInteractionEnabled:NO];
                    
                }else {
                    
                    self.headview.instructions.text = [responseObject valueForKey:@"QiTa"];
                    
                    [self.headview.zhankaiBtn setUserInteractionEnabled:YES];
                    
                }
                
                self.headview.cheType.text = @"救援车";
                
//                if (self.qitaArray.count == 0) {
//                    
//                }else {
//                    
//                    [self.qitaArray removeAllObjects];
//                    
//                }
                
                self.qitaArray = [responseObject valueForKey:@"jycQiTa"];
                
                [self.tableview.header endRefreshing];
                
                if (self.qitaArray.count<[PageSizeTableView2 integerValue]) {
                    
                    [self.tableview.footer endRefreshingWithNoMoreData];
                    
                }else{
                    
                    [self.tableview.footer resetNoMoreData];
                    
                }
                
            }else {
                
                NSArray *reArr = [responseObject valueForKey:@"jycQiTa"];
                if (reArr.count) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.qitaArray];
                    [array addObjectsFromArray:reArr];
                    self.qitaArray =array;
                    [self.tableview.footer endRefreshing];
                    if (reArr.count<[PageSizeTableView2 integerValue]) {
                        [self.tableview.footer endRefreshingWithNoMoreData];
                    }else{
                        [self.tableview.footer resetNoMoreData];
                    }
                }else{
                    pageIndex --;
                }
                
            }
            
            [self.tableview reloadData];
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.tableview.header endRefreshing];
        
    }];
    
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
    self.tableview.footer = footer;
}

- (void)M_tableviewmore
{
    pageIndex ++;
    
    switch (self.type) {
        case 0:
        {
            
            [self requestWLCListWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
            break;
            
        case 1:
        {
            
            [self requestSPCListWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
            break;
            
        case 2:
        {
            
            [self requestJYCListWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)initWithHeadView {
    
    DetailHeadView *view = [[DetailHeadView alloc] init];
    
    self.headview = view;
    
    view.frame = CGRectMake(0, 0, VIEWWIDTH, view.height);

    [view.zhankaiBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view.phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableview.tableHeaderView = view;
    
}

- (void)phoneBtnClick {

    NSString *phone = self.phone;
    MMPopupItemHandler block = ^(NSInteger index){
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

- (void)BtnClick {
    
    self.tableview.tableHeaderView = nil;

    self.headview.frame = CGRectMake(0, 0, VIEWWIDTH, self.headview.height);
    
    self.tableview.tableHeaderView = self.headview;
    
}

- (void)initWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 4;
        
    }else if (section == 1) {
    
        return 3;
        
    }else {
    
        return self.qitaArray.count + 1;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            HeadCell *cell = [[HeadCell alloc] init];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.line.backgroundColor = [UIColor colorWithRed:239/255. green:153/255. blue:136/255. alpha:1.];
            
            cell.title.text = @"评价";
            
            return cell;
            
        }else {
        
            PingjiaCell *cell = [[PingjiaCell alloc] init];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            HeadCell *cell = [[HeadCell alloc] init];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.line.backgroundColor = [UIColor colorWithRed:228/255. green:106/255. blue:112/255. alpha:1.];
            
            cell.title.text = @"投诉信息";
            
            return cell;
            
        }else {
            
            PingjiaCell *cell = [[PingjiaCell alloc] init];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
    }else {
    
        if (indexPath.row == 0) {
            
            HeadCell *cell = [[HeadCell alloc] init];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.line.backgroundColor = [UIColor colorWithRed:49/255. green:171/255. blue:238/255. alpha:1.];
            
            cell.title.text = @"其他相关信息";
            
            cell.moreBtn.hidden = YES;
            
            return cell;
            
        }else {
            
            if (self.type == 0) {
                
                NSDictionary *dic = self.qitaArray[indexPath.row - 1];
                
                WuliuCell *cell = [[WuliuCell alloc] init];
                
                if ([dic[@"wLCType"] isEqualToString:@"WLCBig"]) {
                    
                    cell.cheIcon.image = [UIImage imageNamed:@"大车.png"];
                    
                }else if ([dic[@"wLCType"] isEqualToString:@"WLCMid"]) {
                
                    cell.cheIcon.image = [UIImage imageNamed:@"中车.png"];
                    
                }else if ([dic[@"wLCType"] isEqualToString:@"WLCSml"]) {
                
                    cell.cheIcon.image = [UIImage imageNamed:@"小车.png"];
                    
                }else {
                
                    cell.cheIcon.image = [UIImage imageNamed:@"其它车.png"];

                }
                
                cell.fromPlace.text = dic[@"fromAddress"];
                
                cell.toPlace.text = dic[@"toAddress"];
                
                if ([dic[@"tuJingChengShi"] isEqualToString:@""]) {
                    
                    cell.citys.text = @"暂无途经城市";
                    
                }else {
                    
                    cell.citys.text = dic[@"tuJingChengShi"];
                    
                }
                
                cell.time.text = [NSString stringWithFormat:@"发车时间:%@",dic[@"faCheShiJian"]];
                
                cell.phoneBtn.tag = indexPath.row - 1;
                
                [cell.phoneBtn addTarget:self action:@selector(PhoneClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
                
            }else if (self.type == 1) {
            
                NSDictionary *dic = self.qitaArray[indexPath.row - 1];
                
                WuliuCell *cell = [[WuliuCell alloc] init];
                
                cell.cheIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"imageSrc"]]]];
                
                cell.fromPlace.text = dic[@"fromAddress"];
                
                cell.toPlace.text = dic[@"toAddress"];
                
                if ([dic[@"tuJingChengShi"] isEqualToString:@""]) {
                    
                    cell.citys.text = @"暂无途经城市";
                    
                }else {
                
                    cell.citys.text = dic[@"tuJingChengShi"];
                    
                }
                
                cell.time.text = [NSString stringWithFormat:@"发车时间:%@",dic[@"faCheShiJian"]];
                
                cell.phoneBtn.tag = indexPath.row - 1;
                
                [cell.phoneBtn addTarget:self action:@selector(PhoneClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
                
            }else {
            
                NSDictionary *dic = self.qitaArray[indexPath.row - 1];
                
                WuliuCell *cell = [[WuliuCell alloc] init];
                
                if ([dic[@"jYCType"] isEqualToString:@"JYCBig"]) {
                    
                    cell.cheIcon.image = [UIImage imageNamed:@"大车.png"];
                    
                }else if ([dic[@"jYCType"] isEqualToString:@"JYCMid"]) {
                    
                    cell.cheIcon.image = [UIImage imageNamed:@"中车.png"];
                    
                }else if ([dic[@"jYCType"] isEqualToString:@"JYCSml"]) {
                    
                    cell.cheIcon.image = [UIImage imageNamed:@"小车.png"];
                    
                }else {
                    
                    cell.cheIcon.image = [UIImage imageNamed:@"其它车.png"];
                    
                }
                
                cell.fromPlace.text = dic[@"fromAddress"];
                
                cell.toPlace.text = dic[@"toAddress"];
                
                if ([dic[@"tuJingChengShi"] isEqualToString:@""]) {
                    
                    cell.citys.text = @"暂无途经城市";
                    
                }else {
                    
                    cell.citys.text = dic[@"tuJingChengShi"];
                    
                }
                
                cell.time.text = [NSString stringWithFormat:@"发车时间:%@",dic[@"faCheShiJian"]];
                
                cell.phoneBtn.tag = indexPath.row - 1;
                
                [cell.phoneBtn addTarget:self action:@selector(PhoneClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
                
            }
            
        }
        
    }
}

- (void)PhoneClick:(id)sender {
    
    NSIndexPath *indexPath;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        indexPath = [self.tableview indexPathForCell:(WuliuCell *)[sender superview]];
        
    }else {
        
        indexPath = [self.tableview indexPathForCell:(WuliuCell *)[[sender superview] superview]];
    }

    NSDictionary *dic = self.qitaArray[indexPath.row - 1];
    
    NSString *phone = dic[@"linkPhone"];
    MMPopupItemHandler block = ^(NSInteger index){
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            HeadCell *cell = [[HeadCell alloc] init];
            
            return cell.height;
            
        }else {
            
            PingjiaCell *cell = [[PingjiaCell alloc] init];
            
            return cell.height;
            
        }
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            HeadCell *cell = [[HeadCell alloc] init];
            
            return cell.height;
            
        }else {
            
            PingjiaCell *cell = [[PingjiaCell alloc] init];
            
            return cell.height;
            
        }
        
    }else {
        
        if (indexPath.row == 0) {
            
            HeadCell *cell = [[HeadCell alloc] init];
            
            return cell.height;
            
        }else {
            
            WuliuCell *cell = [[WuliuCell alloc] init];
            
            return cell.height;
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
