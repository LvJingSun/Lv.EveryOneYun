//
//  SecondViewController.m
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "SecondViewController.h"
#import "ReleaseActionViewController.h"
#import "PopupView.h"
#import "LewPopupViewController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "PackageController.h"
#import "XWAlterview.h"
#import "ContactDetailController.h"
#import "CompanyDetailController.h"
#import "KVNProgress.h"
#import "AddFriendViewController.h"
#import "UIImageView+WebCache.h"

@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate>{

    UISegmentedControl *segment;
    UINavigationItem *MainItem;
    UITableView *M_tableview;
    
    UIButton *PublishBtn;
    DBHelper *dbhelp;
    
    //下拉列表
    NSInteger _currentDataIndexleft;//选中的下拉项
    NSInteger _currentDataIndexright;
    NSInteger _currentDataIndexthree;
    NSInteger _currentDataIndexbackleft;
    NSInteger _currentDataIndexbackright;
    NSInteger _currentDataIndexbackthree;
    NSInteger _currentDataIndextime;
    NSInteger _currentDataIndexnum;
    
    NSString *fromShengId;
    NSString *fromShiId;
    NSString *fromQuId;
    NSString *toShengId;
    NSString *toShiId;
    NSString *toQuId;


    JSDropDownMenu *Mymenu;
    //物流车还是商品车（默认0物流车）
    NSInteger wlcORspc;
    
    NSInteger pageIndex;
    
    CTCallCenter *callCenter;
    
    BOOL DJYCallStateDialing;//拨打电话
    BOOL DJYCallStateConnected;//接通电话
    
    NSString *wlcInfoId;
    NSString *spcInfoId;
    NSString *jycInfoId;
    NSString *setCheInfoID;
    NSString *linkPhone;
    NSString *addFriendID;


}
@property (nonatomic, strong) NSMutableArray            *dataProvincesname;
@property (nonatomic, strong) NSMutableArray            *dataProvincescode;
@property (nonatomic, strong) NSMutableArray            *dataCityname;
@property (nonatomic, strong) NSMutableArray            *dataCitycode;
@property (nonatomic, strong) NSMutableArray            *dataAreaname;
@property (nonatomic, strong) NSMutableArray            *dataAreacode;
@property (nonatomic, strong) NSMutableArray            *dateTimeArr;
@property (nonatomic, strong) NSMutableArray            *dataCount;
@property (nonatomic, strong) NSMutableArray            *datawlcListArr;
@property (nonatomic, strong) NSMutableArray            *dataspcListArr;
@property (nonatomic, strong) NSMutableArray            *datajycListArr;
@property (nonatomic, strong) NSArray                   *ADUrlArray;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setedgesForExtendedLayoutNO];
    self.dataProvincesname = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataProvincescode = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataCityname = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataCitycode = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataAreaname = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataAreacode = [[NSMutableArray alloc]initWithCapacity:0];
    self.dateTimeArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.datawlcListArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataspcListArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.datajycListArr = [[NSMutableArray alloc]initWithCapacity:0];

    _currentDataIndexleft=_currentDataIndexright=_currentDataIndexthree=
    _currentDataIndexbackleft=_currentDataIndexbackright=_currentDataIndexbackthree=
    _currentDataIndextime=_currentDataIndexnum=-1;
    fromShengId=fromShiId=fromQuId=toShengId=toShiId=toQuId=@"";
    pageIndex = 1;
    M_tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    [self setSegmentedControl];

    [self allocexamplerefresh];
    [self allocexamplemore];
    
    [self allocSDSyScrollerView];
    [self allocPublishBtn];
    
    JSDropDownMenu *menu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, 0) andHeight:45];;
    menu.indicatorColor = UIColorDJYThemecolorsRGB;
    menu.separatorColor = UIColorDJYThemecolorsRGB;
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    menu.tag = 99999;
    [self.view addSubview:menu];
    self.dataCount = [[NSMutableArray alloc]initWithObjects:@"从多到少",@"从少到多", nil];

    //****获取城市***************************************************
    dbhelp = [[DBHelper alloc]init];
    [self loadcityandadre];
    [self requestAreaSubmit];
    [self requestTimeSubmit];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    M_tableview.frame = CGRectMake(0, 48, self.view.frame.size.width, self.view.frame.size.height-48);
    
    [self detectCall];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = UIColorDJYThemecolorsRGB;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    callCenter = nil;
    
}

-(void)selectTabbar:(UINavigationItem *)Item{
    if (!segment) {
        MainItem = Item;
        [self setSegmentedControl];
    }else{
        Item.titleView=segment;
    }
}

-(void)setSegmentedControl{
    if (!segment) {
        segment = [[UISegmentedControl alloc]initWithItems:nil];
        segment.frame=CGRectMake(0, 8, 180, 35);
        [segment insertSegmentWithTitle:@"物流车" atIndex: 0 animated: NO ];
        [segment insertSegmentWithTitle:@"商品车" atIndex: 1 animated: NO ];
        [segment insertSegmentWithTitle:@"救援车" atIndex: 2 animated: NO ];
        segment.selectedSegmentIndex = 0;//设置默认选择项索引
        segment.tintColor= UIColorDJYThemecolorsRGB;
        //设置跳转的方法
        [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        MainItem.titleView = segment;
    }
}

-(void)change:(UISegmentedControl *)Seg{
    switch (Seg.selectedSegmentIndex) {
        case 0:{
            wlcORspc = 0;
            break;
        }
        case 1:{
            wlcORspc = 1;
            break;
        }
        case 2:{
            wlcORspc = 2;
            break;
        }
        default:
            break;
    }
    [M_tableview reloadData];
    [M_tableview.header beginRefreshing];
    [self M_tableviewrefresh];

}

- (void)allocPublishBtn{

    PublishBtn = [[UIButton alloc]initWithFrame:CGRectMake(Windows_WIDTH-15-60, self.view.frame.size.height-15-60-60-48, 60, 60)];
    PublishBtn.backgroundColor = [UIColor clearColor];
    UILabel *Bview = [[UILabel alloc]initWithFrame:CGRectMake(Windows_WIDTH-15-60, self.view.frame.size.height-15-60-60-48, 60, 60)];
    Bview.text = @"发布";
    Bview.textColor = [UIColor whiteColor];
    Bview.textAlignment = NSTextAlignmentCenter;
    Bview.font = [UIFont systemFontOfSize:18];
    Bview.backgroundColor = RGBColor(242, 133, 65);
    [PublishBtn addTarget:self action:@selector(presentShareViewAdmion) forControlEvents:UIControlEventTouchUpInside];
    [self setLayer:Bview andcornerRadius:60];
    [self.view addSubview:Bview];
    [self.view addSubview:PublishBtn];

}



- (void)allocSDSyScrollerView {

    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 48, self.view.bounds.size.width, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    // 自定义分页控件小圆标颜色
    cycleScrollView2.currentPageDotColor = UIColorDJYThemecolorsRGB;
    M_tableview.tableHeaderView = cycleScrollView2;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            fromShiId,@"fromShiId",
                            nil];

    
    //广告
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DataBaseWebService.asmx/GetAdListNew" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSArray *adList= [responseObject valueForKey:@"admodelList"];
            
            NSMutableArray *tempArr = [NSMutableArray array];
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for (NSDictionary *dd in adList) {
                
                [tempArr addObject:dd[@"PicUrl"]];
                
                [temp addObject:dd[@"LinkUrl"]];
                
            }

            cycleScrollView2.imageURLStringsGroup = tempArr;
            
            self.ADUrlArray = temp;
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
    }];

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    CompanyDetailController *vc = [[CompanyDetailController alloc] init];
    
    vc.companyUrl = self.ADUrlArray[index];
    
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (wlcORspc) {
        case 0:
            return self.datawlcListArr.count;
            break;
        case 1:
            return self.dataspcListArr.count;
            break;
        case 2:
            return self.datajycListArr.count;
            break;
        default:
            break;
    }
    return 0;
}

- (void)allocDetailsView:(UIButton *)sender {
    
    NSInteger i = sender.tag;
    
    PopupView *view = [PopupView defaultPopupView];
    view.parentVC = self;
    
    view.callBtn.tag = i;
    
    view.addFriendsBtn.tag = i;
    
    view.detailsBtn.tag = i;
    
    [view.callBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view.addFriendsBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view.detailsBtn addTarget:self action:@selector(detailsClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
        
    }];

}

- (void)addClick:(UIButton *)sender {
    
    [self setPhone:(int)sender.tag];
    
    AddFriendViewController *vc = [[AddFriendViewController alloc] init];
    
    vc.sendAddPhone = linkPhone;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
}

//详情点击
- (void)detailsClick:(UIButton *)sender {
    
    [self setCheInfoId:(int)sender.tag];
    
    [self setPhone:(int)sender.tag];
 
    ContactDetailController *vc = [[ContactDetailController alloc] init];
    
    vc.cheInfoId = setCheInfoID;
    
    vc.phone = linkPhone;
    
    vc.type = wlcORspc;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
    
}

- (void)btnclick:(UIButton *)sender {

    [self AlertSure:(int)sender.tag];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"DJYXIBTableViewCell";
    DJYXIBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        cell = (DJYXIBTableViewCell *)[nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.call.tag = indexPath.row;
    [cell.call addTarget:self action:@selector(allocDetailsView:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *InfoDIC = [[NSDictionary alloc]init];
    NSString *infoType = @"";
    if (wlcORspc==0) {
        InfoDIC = self.datawlcListArr[indexPath.row];
        NSString *wlcType = [InfoDIC objectForKey:@"wlcType"];
        if ([wlcType isEqualToString:@"WLCBig"]) {
           infoType = @"(大)";
        }else if ([wlcType isEqualToString:@"WLCMid"]){
            infoType = @"(中)";
        }else if ([wlcType isEqualToString:@"WLCSml"]){
            infoType = @"(小)";
        }
        cell.cheWeiShu.text = [NSString stringWithFormat:@"空闲车位：%@个%@",[InfoDIC objectForKey:@"cheWeiShu"],infoType];
        cell.headIMG.image = [UIImage imageNamed:@"其它"];

        
    }else if (wlcORspc==1) {
        InfoDIC = self.dataspcListArr[indexPath.row];
       
        [cell.headIMG sd_setImageWithURL:[NSURL URLWithString:[InfoDIC objectForKey:@"imageSrc"]] placeholderImage:[UIImage imageNamed:@"defaultImage.png"]];
        
        NSString *spcType = [InfoDIC objectForKey:@"spcType"];

        cell.cheWeiShu.text = [NSString stringWithFormat:@"%@：%@个",spcType,[InfoDIC objectForKey:@"cheWeiShu"]];

    } else if (wlcORspc==2){
        
        InfoDIC = self.datajycListArr[indexPath.row];
        NSString *wlcType = [InfoDIC objectForKey:@"jycType"];
        if ([wlcType isEqualToString:@"JYCBig"]) {
            infoType = @"(大)";
        }else if ([wlcType isEqualToString:@"JYCMid"]){
            infoType = @"(中)";
        }else if ([wlcType isEqualToString:@"JYCSml"]){
            infoType = @"(小)";
        }
        cell.cheWeiShu.text = [NSString stringWithFormat:@"空闲车位：%@个%@",[InfoDIC objectForKey:@"cheWeiShu"],infoType];
        
        cell.headIMG.image = [UIImage imageNamed:@"jiuyuanche"];
    
    }

    cell.fromAddress.text = [NSString stringWithFormat:@"%@",[InfoDIC objectForKey:@"fromAddress"]];
    cell.toAddress.text = [NSString stringWithFormat:@"%@",[InfoDIC objectForKey:@"toAddress"]];
    cell.faCheShiJian.text =[NSString stringWithFormat:@"%@ %@",[InfoDIC objectForKey:@"faCheShiJian"],[InfoDIC objectForKey:@"faCheShiJianDes"]];
    
    NSString *tuJingChengShi = [InfoDIC objectForKey:@"tuJingChengShi"];
    NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
    if ([[self GETtujingCityName:tujingArr] isEqualToString:@""]) {
        [cell setFrame:CGRectMake(0, 0, Windows_WIDTH, 120)];
        cell.tuJingChengShiImgV.hidden = YES;
        cell.tuJingChengShi.text = @"";
    }else {
        [cell setFrame:CGRectMake(0, 0, Windows_WIDTH, 150)];
        cell.tuJingChengShiImgV.hidden = NO;
        NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
        cell.tuJingChengShi.text = [NSString stringWithFormat:@"途经城市：%@",[self GETtujingCityName:tujingArr]];
    }

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (wlcORspc==0 && self.datawlcListArr.count ) {
        NSDictionary *InfoDIC = self.datawlcListArr[indexPath.row];
        NSString *tuJingChengShi = [InfoDIC objectForKey:@"tuJingChengShi"];
        NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
        if ( [[self GETtujingCityName:tujingArr] isEqualToString:@""]) {
            return 120;
        }
    }else if (wlcORspc==1 && self.dataspcListArr.count) {
        NSDictionary *InfoDIC = self.dataspcListArr[indexPath.row];
        NSString *tuJingChengShi = [InfoDIC objectForKey:@"tuJingChengShi"];
        NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
        if ( [[self GETtujingCityName:tujingArr] isEqualToString:@""]) {
            return 120;
        }
    }else if (wlcORspc==2 && self.datajycListArr.count) {
        NSDictionary *InfoDIC = self.datajycListArr[indexPath.row];
        NSString *tuJingChengShi = [InfoDIC objectForKey:@"tuJingChengShi"];
        NSArray * tujingArr = [self toArrayOrNSDictionary:tuJingChengShi];
        if ( [[self GETtujingCityName:tujingArr] isEqualToString:@""]) {
            return 120;
        }
    }
    //如果有途经城市，返回150，没有，返回120.
    return 150.f;

}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section  {
    return 0.00001f;
}

#pragma 获取城市
- (void)loadcityandadre{
    [self loadProvinces];
    [self loadCity:0];
    [self loadArea:0];
}

-(void)loadProvinces
{
    NSArray *city = [dbhelp queryCityDJYParentId:@"0"];
    [self.dataProvincesname removeAllObjects];
    [self.dataProvincescode removeAllObjects];
    [self.dataProvincesname addObject:@"全国"];
    [self.dataProvincescode addObject:@""];
    [city enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataProvincesname addObject:[obj objectForKey:@"name"]];
        [self.dataProvincescode addObject:[obj objectForKey:@"code"]];
    }];
}

-(void)loadCity:(NSInteger)Indexpath;
{
    if (self.dataProvincescode.count) {
        NSString *code = [self.dataProvincescode objectAtIndex:Indexpath];
        NSArray *Area = [dbhelp queryCityDJYParentId:code];
        [self.dataCityname removeAllObjects];
        [self.dataCitycode removeAllObjects];
        [self.dataAreaname removeAllObjects];
        [self.dataAreacode removeAllObjects];
        if (Indexpath == 0) {
            return;
        }
        [self.dataCityname addObject:@"全省"];
        [self.dataCitycode addObject:@""];

        [Area enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataCityname addObject:[obj objectForKey:@"name"]];
            [self.dataCitycode addObject:[obj objectForKey:@"code"]];
        }];
    }
}

-(void)loadArea:(NSInteger)Indexpath;
{
    if (self.dataCitycode.count) {
    NSString *code = [self.dataCitycode objectAtIndex:Indexpath];
    NSArray *Area = [dbhelp queryCityDJYParentId:code];
    [self.dataAreaname removeAllObjects];
    [self.dataAreacode removeAllObjects];
    if (Indexpath == 0) {
        return;
    }
    [self.dataAreaname addObject:@"全市"];
    [self.dataAreacode addObject:@""];

    [Area enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataAreaname addObject:[obj objectForKey:@"name"]];
        [self.dataAreacode addObject:[obj objectForKey:@"code"]];
    }];
    }
    
}

#pragma 下拉菜单
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    return 4;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0||column==1) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0||column==1) {
        return 0.33;
    }
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    if (column==0) {
        return _currentDataIndexleft;
    }else if (column==1){
        return _currentDataIndexbackleft;
    }else if (column==2){
        return _currentDataIndextime;
    }else if (column==3){
        return _currentDataIndexnum;
    }
    return 0;
}

/**
 * 返回当前菜单右边表选中行
 */
- (NSInteger)currentRightSelectedRow:(NSInteger)column;{
    if (column==0) {
        [self loadCity:_currentDataIndexleft==-1?0:_currentDataIndexleft];
        [self loadArea:_currentDataIndexright==-1?0:_currentDataIndexright];
        return _currentDataIndexright;
    }else if (column==1){
        [self loadCity:_currentDataIndexbackleft==-1?0:_currentDataIndexbackleft];
        [self loadArea:_currentDataIndexbackright==-1?0:_currentDataIndexbackright];
        return _currentDataIndexbackright;
    }
    return 0;
    
}


- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {
            return self.dataProvincesname.count;
        } else if (leftOrRight==1) {
            return self.dataCityname.count;
        } else if (leftOrRight==2) {
            return self.dataAreaname.count;
        }
    }else if (column==1){
        if (leftOrRight==0) {
            return self.dataProvincesname.count;
        } else if (leftOrRight==1) {
            return self.dataCityname.count;
        } else if (leftOrRight==2) {
            return self.dataAreaname.count;
        }
    }else if (column==2){
        return self.dateTimeArr.count;
    }else if (column==3){
        return self.dataCount.count;
    }

    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return self.dataProvincesname.count? self.dataProvincesname[0]:@"出发地";
            break;
        case 1: return self.dataProvincesname.count? self.dataProvincesname[0]:@"目的地";
            break;
        case 2: return self.dateTimeArr.count? [self.dateTimeArr[0] objectForKey:@"time"]:@"时间";
            break;
        case 3: return self.dataCount.count? self.dataCount[0]:@"数量";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menuFirstTitle:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath;{
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==1) {
            return [self.self.dataProvincesname objectAtIndex:indexPath.leftRow];
        } else if (indexPath.leftOrRight==2) {
            return [self.self.dataCityname objectAtIndex:indexPath.rightrow];
        }
    }else if (indexPath.column==1){
        if (indexPath.leftOrRight==1) {
            return [self.self.dataProvincesname objectAtIndex:indexPath.leftRow];
        } else if (indexPath.leftOrRight==2) {
            return [self.self.dataCityname objectAtIndex:indexPath.rightrow];
        }
    }return @"";
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            return [self.self.dataProvincesname objectAtIndex:indexPath.threerow];
        } else if (indexPath.leftOrRight==1) {
            return [self.self.dataCityname objectAtIndex:indexPath.threerow];
        }else if (indexPath.leftOrRight==2) {
            return [self.self.dataAreaname objectAtIndex:indexPath.threerow];
        }
    }else if (indexPath.column==1){
        if (indexPath.leftOrRight==0) {
            return [self.dataProvincesname objectAtIndex:indexPath.threerow];
        } else if (indexPath.leftOrRight==1) {
            return [self.dataCityname objectAtIndex:indexPath.threerow];
        }else if (indexPath.leftOrRight==2) {
            return [self.dataAreaname objectAtIndex:indexPath.threerow];
        }
    }else if (indexPath.column==2){
        return [[self.dateTimeArr objectAtIndex:indexPath.threerow] objectForKey:@"time"];

    }else if (indexPath.column==3){
        return [self.dataCount objectAtIndex:indexPath.threerow];

    }

    return nil;
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        if(indexPath.leftOrRight==0){
            _currentDataIndexleft = indexPath.leftRow;
            fromShengId = self.dataProvincescode[_currentDataIndexleft];
            [self loadCity:indexPath.leftRow];
        }else if (indexPath.leftOrRight==1) {
            _currentDataIndexright = indexPath.rightrow;
            fromShiId = self.dataCitycode[_currentDataIndexright];
            [self allocSDSyScrollerView];
            [self loadArea:indexPath.rightrow];
        }else if (indexPath.leftOrRight==2){
            if (indexPath.threerow!=0) {
                _currentDataIndexthree= indexPath.threerow;
                fromQuId = self.dataAreacode[_currentDataIndexthree];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }
        }
        if (indexPath.leftRow == 0 ||indexPath.rightrow == 0 || indexPath.threerow == 0) {
            if (indexPath.leftRow==0 && indexPath.leftOrRight==0) {
                fromShengId = fromShiId = fromQuId = @"";
                [self allocSDSyScrollerView];
                [menu hiddenJSDropMenu];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }else if (indexPath.rightrow==0 && indexPath.leftOrRight==1){
                fromShiId = fromQuId = @"";
                [self allocSDSyScrollerView];
                [menu hiddenJSDropMenu];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }else if (indexPath.threerow == 0 && indexPath.leftOrRight==2) {
                fromQuId = @"";
                [menu hiddenJSDropMenu];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }

        }

    }else if (indexPath.column==1){
        if(indexPath.leftOrRight==0){
            _currentDataIndexbackleft = indexPath.leftRow;
            toShengId = self.dataProvincescode[_currentDataIndexbackleft];
            [self loadCity:indexPath.leftRow];
        }else if (indexPath.leftOrRight==1) {
            _currentDataIndexbackright = indexPath.rightrow;
            toShiId = self.dataCitycode[_currentDataIndexbackright];
            [self loadArea:indexPath.rightrow];
        }else if (indexPath.leftOrRight==2){
            if (indexPath.threerow!=0) {
                _currentDataIndexbackthree= indexPath.threerow;
                toQuId = self.dataAreacode[_currentDataIndexbackthree];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }
        }
        if (indexPath.leftRow == 0 ||indexPath.rightrow == 0 || indexPath.threerow == 0) {
            if (indexPath.leftRow==0 && indexPath.leftOrRight==0) {
                toShengId = toShiId = toQuId = @"";
                [menu hiddenJSDropMenu];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }else if (indexPath.rightrow==0 && indexPath.leftOrRight==1){
                toShiId = toQuId = @"";
                [menu hiddenJSDropMenu];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }else if (indexPath.threerow == 0 && indexPath.leftOrRight==2) {
                toQuId = @"";
                [menu hiddenJSDropMenu];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header beginRefreshing];
                    [self M_tableviewrefresh];
                });
            }
            
        }
    }else if (indexPath.column==2){
        _currentDataIndextime = indexPath.leftRow;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [M_tableview.header beginRefreshing];
            [self M_tableviewrefresh];
        });
    }else if (indexPath.column==3){
        _currentDataIndexnum = indexPath.leftRow;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [M_tableview.header beginRefreshing];
            [self M_tableviewrefresh];
        });
    }


}



#pragma mark - 城市请求数据
- (void)requestAreaSubmit{
    
    NSDictionary *versions = [dbhelp queryVersion];
    NSString *cityVer = [versions objectForKey:@"city"];
    if (cityVer == nil) {
        cityVer = @"0";
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            cityVer,@"memberCityVer",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DataBaseWebService.asmx/GetCityList" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSArray *versionList = [responseObject valueForKey:@"MemberVersion"];
            if (versionList == nil || [versionList count] == 0) {
                return;
            }
            NSInteger cityVersion = 0;
            for (NSDictionary *version in versionList) {
                NSString *type = [version objectForKey:@"VersionType"];
                if ([@"VersionCity" isEqualToString:type]) {
                    cityVersion = [[version objectForKey:@"MemberVersionNum"] intValue];
                }
            }
            if (cityVersion > 0) {
                NSArray *cityList = [responseObject valueForKey:@"memberCity"];
                [dbhelp updateData:cityList andType:@"city" andVersion:[NSString stringWithFormat:@"%ld", (long)cityVersion]];
                [self loadcityandadre];

            }
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        NSLog(@"城市获取失败");
    }];
    
}


#pragma mark - 商品可装车时间
- (void)requestTimeSubmit{
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"WLCWebService.asmx/WLCTimeList" params:nil networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"全部",@"time",
                                    @"全部",@"weekName",
                                    nil];
            [self.dateTimeArr addObject:params];
            [self.dateTimeArr addObjectsFromArray:[responseObject valueForKey:@"timeList"]];
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
    }];
    
}


-(void)presentShareViewAdmion
{

    int i = 0;
    
    if (i == 1) {
        
        XWAlterview *alert = [[XWAlterview alloc] initWithTitle:@"提示" contentText:@"亲，您发布的信息已超过10条，需要购买套餐才能继续发布" leftButtonTitle:@"取消" rightButtonTitle:@"开通套餐"];
        
        alert.rightBlock = ^(){
        
            PackageController *vc = [[PackageController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
        [alert show];
        
    }else {
    
        DOPAction *action1 = [[DOPAction alloc] initWithName:@"发布物流车" iconName:@"其它_选中" handler:^{
            [self action1block];
        }];
        DOPAction *action2 = [[DOPAction alloc] initWithName:@"发布商品车" iconName:@"大型_选中" handler:^{
            [self action2block];
        }];
        DOPAction *action3 = [[DOPAction alloc] initWithName:@"发布救援车" iconName:@"jiuyuanche_selected" handler:^{
            [self action3block];
        }];
        
        NSArray *actions = @[@"",
                             @[action1, action2,action3]
                             ];
        
        DOPScrollableActionSheet *as = [[DOPScrollableActionSheet alloc] initWithActionArray:actions];
        [as show];
        
    }
    
}

-(void)action1block{
    ReleaseActionViewController *VC = [[ReleaseActionViewController alloc]initWithTitle:@"发布物流车"];
    [self PUSHWithBlockView:VC andblock:^(NSDictionary *BlockDIC) {
        [self M_tableviewrefresh];
    }];
}

-(void)action2block{
    ReleaseActionViewController *VC = [[ReleaseActionViewController alloc]initWithTitle:@"发布商品车"];
    [self PUSHWithBlockView:VC andblock:^(NSDictionary *BlockDIC) {
        [self M_tableviewrefresh];
    }];
}

-(void)action3block{
    ReleaseActionViewController *VC = [[ReleaseActionViewController alloc]initWithTitle:@"发布救援车"];
    [self PUSHWithBlockView:VC andblock:^(NSDictionary *BlockDIC) {
        [self M_tableviewrefresh];
    }];
}

- (void)setCheInfoId:(int)i {

    NSDictionary *cheDIC = [[NSDictionary alloc] init];
    
    switch (wlcORspc) {
        case 0:
            cheDIC = self.datawlcListArr[i];
            setCheInfoID = cheDIC[@"wlcInfoID"];
            break;
        case 1:
            cheDIC = self.dataspcListArr[i];
            setCheInfoID = cheDIC[@"cheInfoID"];
            break;
        case 2:
            cheDIC = self.datajycListArr[i];
            setCheInfoID = cheDIC[@"jycInfoID"];
            break;
        default:
            break;
    }
}

- (void)setMemberID:(int)i {
    
    NSDictionary *cheDIC = [[NSDictionary alloc] init];
    
    switch (wlcORspc) {
        case 0:
            cheDIC = self.datawlcListArr[i];
            addFriendID = cheDIC[@"memberId"];
            break;
        case 1:
            cheDIC = self.dataspcListArr[i];
            addFriendID = cheDIC[@"memberId"];
            break;
        case 2:
            cheDIC = self.datajycListArr[i];
            addFriendID = cheDIC[@"memberId"];
            break;
        default:
            break;
    }
}

- (void)setPhone:(int)i {
    
    NSDictionary *cheDIC = [[NSDictionary alloc] init];
    
    switch (wlcORspc) {
        case 0:
            cheDIC = self.datawlcListArr[i];
            linkPhone = cheDIC[@"linkPhone"];
            break;
        case 1:
            cheDIC = self.dataspcListArr[i];
            linkPhone = cheDIC[@"linkPhone"];
            break;
        case 2:
            cheDIC = self.datajycListArr[i];
            linkPhone = cheDIC[@"linkPhone"];
            break;
        default:
            break;
    }
}

- (void)AlertSure:(int)i{
    
    NSDictionary *wlcInfoDIC = [[NSDictionary alloc]init];
    switch (wlcORspc) {
        case 0:
            wlcInfoDIC = self.datawlcListArr[i];
            wlcInfoId = [wlcInfoDIC objectForKey:@"wlcInfoID"];
            spcInfoId = @"0";
            jycInfoId = @"0";
            break;
        case 1:
            wlcInfoDIC = self.dataspcListArr[i];
            wlcInfoId = @"0";
            jycInfoId = @"0";
            spcInfoId = [wlcInfoDIC objectForKey:@"cheInfoID"];
            break;
        case 2:
            wlcInfoDIC = self.datajycListArr[i];
            spcInfoId = @"0";
            wlcInfoId = @"0";
            jycInfoId = [wlcInfoDIC objectForKey:@"jycInfoID"];
            break;
        default:
            break;
    }
    
    NSString *phone = [wlcInfoDIC objectForKey:@"linkPhone"];
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

#pragma mark - 物流车列表
- (void)requestWLCList{
    NSString *faCheShiJian = _currentDataIndextime==-1?@"":[NSString stringWithFormat:@"%@",[self.dateTimeArr[_currentDataIndextime] objectForKey:@"time"]];
    if (_currentDataIndextime==0) {
       faCheShiJian = @"";
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            fromShengId,@"fromShengId",
                            fromShiId,@"fromShiId",
                            fromQuId,@"fromQuId",
                            toShengId,@"toShengId",
                            toShiId,@"toShiId",
                            toQuId,@"toQuId",
                            @"0",@"longitude",
                            @"0",@"latitude",
                            faCheShiJian,@"faCheShiJian",
                            [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                            PageSizeTableView,@"pageSize",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"WLCWebService.asmx/WLCList_1" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            if (pageIndex==1) {
                self.datawlcListArr = [responseObject valueForKey:@"wlcList"];
                NSLog(@"物流车：%@",self.datawlcListArr);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header endRefreshing];
                });
                if (self.datawlcListArr.count<[PageSizeTableView integerValue]) {
                    [M_tableview.footer endRefreshingWithNoMoreData];
                }else{
                    [M_tableview.footer resetNoMoreData];
                }
            }else{
                NSArray *reArr = [responseObject valueForKey:@"wlcList"];
                if (reArr.count) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.datawlcListArr];
                    [array addObjectsFromArray:reArr];
                    self.datawlcListArr =array;
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
            if (wlcORspc==0) {
                [M_tableview reloadData];
            }

        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [M_tableview.footer endRefreshing];

    }];
    
}

#pragma mark - 商品车列表
- (void)requestSPCList{
    NSString *faCheShiJian = _currentDataIndextime==-1?@"":[NSString stringWithFormat:@"%@",[self.dateTimeArr[_currentDataIndextime] objectForKey:@"time"]];
    if (_currentDataIndextime==0) {
        faCheShiJian = @"";
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            fromShengId,@"fromShengId",
                            fromShiId,@"fromShiId",
                            fromQuId,@"fromQuId",
                            toShengId,@"toShengId",
                            toShiId,@"toShiId",
                            toQuId,@"toQuId",
                            @"0",@"longitude",
                            @"0",@"latitude",
                            faCheShiJian,@"faCheShiJian",
                            [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                            PageSizeTableView,@"pageSize",
                            nil];
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"SPCWebService.asmx/SPCList_2" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            if (pageIndex==1) {
                self.dataspcListArr = [responseObject valueForKey:@"spcList"];
                NSLog(@"66666%@",self.dataspcListArr);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header endRefreshing];
                });
                if (self.dataspcListArr.count<[PageSizeTableView integerValue]) {
                    [M_tableview.footer endRefreshingWithNoMoreData];
                }else{
                    [M_tableview.footer resetNoMoreData];
                }

            }else{
                NSArray *spArr = [responseObject valueForKey:@"spcList"];
                if (spArr.count) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.dataspcListArr];
                    [array addObjectsFromArray:spArr];
                    self.dataspcListArr =array;
                    [M_tableview.footer endRefreshing];
                    if (spArr.count<[PageSizeTableView integerValue]) {
                        [M_tableview.footer endRefreshingWithNoMoreData];
                    }else{
                        [M_tableview.footer resetNoMoreData];
                    }
                }else{
                    pageIndex --;
                }
  
            }
            if (wlcORspc==1) {
                [M_tableview reloadData];
            }

        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [M_tableview.footer endRefreshing];
    }];
    
}

#pragma mark - 救援车列表
- (void)requestJYCList{
    NSString *faCheShiJian = _currentDataIndextime==-1?@"":[NSString stringWithFormat:@"%@",[self.dateTimeArr[_currentDataIndextime] objectForKey:@"time"]];
    if (_currentDataIndextime==0) {
        faCheShiJian = @"";
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            fromShengId,@"fromShengId",
                            fromShiId,@"fromShiId",
                            fromQuId,@"fromQuId",
                            toShengId,@"toShengId",
                            toShiId,@"toShiId",
                            toQuId,@"toQuId",
                            @"0",@"longitude",
                            @"0",@"latitude",
                            faCheShiJian,@"faCheShiJian",
                            [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                            PageSizeTableView,@"pageSize",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"JYCWebService.asmx/JYCList_1" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            if (pageIndex==1) {
                self.datajycListArr = [responseObject valueForKey:@"jycList"];
                NSLog(@"999%@",self.datajycListArr);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [M_tableview.header endRefreshing];
                });
                if (self.datajycListArr.count<[PageSizeTableView integerValue]) {
                    [M_tableview.footer endRefreshingWithNoMoreData];
                }else{
                    [M_tableview.footer resetNoMoreData];
                }
                
            }else{
                NSArray *spArr = [responseObject valueForKey:@"jycList"];
                if (spArr.count) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.datajycListArr];
                    [array addObjectsFromArray:spArr];
                    self.datajycListArr =array;
                    [M_tableview.footer endRefreshing];
                    if (spArr.count<[PageSizeTableView integerValue]) {
                        [M_tableview.footer endRefreshingWithNoMoreData];
                    }else{
                        [M_tableview.footer resetNoMoreData];
                    }
                }else{
                    pageIndex --;
                }
                
            }
            if (wlcORspc==2) {
                [M_tableview reloadData];
            }
            
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
    pageIndex = 1;
    switch (wlcORspc) {
        case 0:
            [self requestWLCList];
            break;
        case 1:
            [self requestSPCList];
            break;
        case 2:
            [self requestJYCList];
            break;
        default:
            break;
    }
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
    switch (wlcORspc) {
        case 0:
            [self requestWLCList];
            break;
        case 1:
            [self requestSPCList];
            break;
        case 2:
            [self requestJYCList];
            break;
        default:
            break;
    }
}

-(void)detectCall
{
     callCenter= [[CTCallCenter alloc] init];
    __unsafe_unretained __typeof(self) weakSelf = self;
    callCenter.callEventHandler=^(CTCall* call)
    {
        if (call.callState == CTCallStateDisconnected)
        {
            NSLog(@"Call has been disconnected（不管进来的，还是打出来的）电话断开了");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (DJYCallStateDialing==YES) {
                    [weakSelf GenZongAlertSure];
                }
                DJYCallStateDialing = NO;

            });

            
        }
        else if (call.callState == CTCallStateConnected)
        {
            NSLog(@"Call has just been connected通话接通了");
        }
        
        else if(call.callState == CTCallStateIncoming)
        {
            NSLog(@"Call is incoming有电话进来");
            //self.viewController.signalStatus=NO;
        }
        
        else if (call.callState ==CTCallStateDialing)
        {
            
            NSLog(@"call is dialing拨出去电话");
            DJYCallStateDialing = YES;
        }
        else
        {
            NSLog(@"Nothing is done");
        }
    };
}

- (void)GenZongAlertSure{
    MMPopupItemHandler block = ^(NSInteger index){
        NSLog(@"clickd %@ button",@(index));
        if (index==0) {
            [self requestGenZongTel2:@"GenZongStatus_2"];
        }else if (index==1){
            [self requestGenZongTel2:@"GenZongStatus_3"];
        }else if (index==2){
            [self requestGenZongTel2:@"GenZongStatus_4"];
        }else if (index==3){
            [self requestGenZongTel2:@"GenZongStatus_5"];
        }
        
    };
    NSArray *items =
    @[MMItemMake(@"谈成了", MMItemTypeNormal, block),
      MMItemMake(@"未谈成", MMItemTypeNormal, block),
      MMItemMake(@"未接通", MMItemTypeNormal, block),
      MMItemMake(@"虚假信息举报", MMItemTypeNormal, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"联系进度"
                                                         detail:nil
                                                          items:items];
    alertView.attachedView = [MMPopupWindow sharedWindow];
    [alertView show];
}

#pragma mark - 跟踪信息
- (void)requestGenZongTel2:(NSString *)status{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            wlcInfoId,@"wlcInfoId",
                            spcInfoId,@"cheInfoId",
                            jycInfoId,@"jycInfoId",
                            status,@"status",
                            @"",@"yuanYin",
                            @"来自iOS",@"remark",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GenZongTel2" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [self isSuccess:responseObject showSucces:YES showError:YES];
    } failedBlock:^(AFCustomClient *request, NSError *error) {
    }];
    
}


@end
