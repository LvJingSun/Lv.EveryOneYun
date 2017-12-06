//
//  ReleaseActionViewController.m
//  Dajiayun
//
//  Created by CityAndCity on 16/1/31.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ReleaseActionViewController.h"
#import "ChooseparkViewController.h"
#import "ChooseViaCityController.h"
#import "MyDJYContactViewController.h"
#import "NSString+NSStringUtils.h"
#import "SPCChooseController.h"

@interface ReleaseActionViewController ()<UITableViewDataSource,UITableViewDelegate,Bzwdelegate>
{
    UITableView *M_tableview;
    
    /**
     选择的是哪个选择器
     0:go,1:back,2:途经
     */
    NSInteger PickGoorBack;
    NSString *baseAddress;
    UIView *PickBackgroundView;
    BzwPicker *pick;

    NSString *fromAddress;
    NSString *fromShengId;
    NSString *fromShiId;
    NSString *fromQuId;
    NSString *toAddress;
    NSString *toShengId;
    NSString *toShiId;
    NSString *toQuId;
    NSString *faCheShiJian;
    NSString *faCheShiJianDes;
    //用来界面显示的
    NSString *spcInfo;
    //用来请求传输的JYCBig,1|JYCMid,2|JYCSml,3
    NSString *cheInfo;
    NSString *yunFei;
    NSString *qiTa;
    NSString *tuJingChengShi;
    NSArray *tujingCSArr;
    NSString *linkName;
    NSString *linkPhone;

    DatePickerView *_datePickerView;///<时间选择器

}


@end

@implementation ReleaseActionViewController

- (instancetype)initWithTitle:(NSString *)title;
{
    self = [super init];
    if (self) {
        self.title = title;
        fromAddress=@"";
        fromShengId=@"";
        fromShiId=@"";
        fromQuId=@"";
        toAddress=@"";
        toShengId=@"";
        toShiId=@"";
        toQuId=@"";
        faCheShiJian=@"";
        faCheShiJianDes=@"";
        spcInfo=@"";
        cheInfo=@"";
        yunFei=@"";
        qiTa=@"";
        tuJingChengShi=@"";
        linkName=@"";
        linkPhone=@"";

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setedgesForExtendedLayoutNO];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
    DJYXIBTableViewCell9 *cell = (DJYXIBTableViewCell9 *)[nib objectAtIndex:9];
    [self setLayerBorder:cell.titlelabel andcornerRadius:3 andborderWidth:0 andborderColor:UIColorDJYThemecolorsRGB.CGColor];
    if ([self.title isEqualToString:@"发布物流车"]) {
        [cell.titlelabel addTarget:self action:@selector(requestPublishWLC) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.title isEqualToString:@"发布商品车"]){
        [cell.titlelabel addTarget:self action:@selector(requestPublishSPC) forControlEvents:UIControlEventTouchUpInside];

    }else if ([self.title isEqualToString:@"发布救援车"]){
        [cell.titlelabel addTarget:self action:@selector(requestPublishJYC) forControlEvents:UIControlEventTouchUpInside];
        
    }
    M_tableview.tableFooterView = cell;

    // Do any additional setup after loading the view.
    pick = [[BzwPicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    pick.delegatee = self;
    pick.backgroundColor = [UIColor whiteColor];
    PickBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    PickBackgroundView.backgroundColor = [UIColor lightGrayColor];
    PickBackgroundView.alpha = 0;
    [self.view addSubview:PickBackgroundView];
    [self.view addSubview:pick];
    
    [pick.leftBtn addTarget:self action:@selector(cacleBtn) forControlEvents:UIControlEventTouchUpInside];
    [pick.rightBtn addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.row) {
        case 0:
        {
            static NSString *cellIdentifier = @"DJYXIBTableViewCell4";
            DJYXIBTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if ( cell == nil ) {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
                cell = (DJYXIBTableViewCell4 *)[nib objectAtIndex:4];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.Citygo.tag=101;
            cell.Cityback.tag=102;
            cell.Citygotitle.enabled = cell.Citybacktitle.enabled = NO;
            [cell.Citygo addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
            [cell.Cityback addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CleareBtn addTarget:self action:@selector(clearAdress) forControlEvents:UIControlEventTouchUpInside];
            
            cell.Citygotitle.text = fromAddress;
            cell.Citybacktitle.text = toAddress;

            return cell;
        }
        break;
        case 1:
        {
            static NSString *cellIdentifier = @"DJYXIBTableViewCell5";
            DJYXIBTableViewCell5 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if ( cell == nil ) {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
                cell = (DJYXIBTableViewCell5 *)[nib objectAtIndex:5];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if ([self.title isEqualToString:@"发布物流车"]||[self.title isEqualToString:@"发布救援车"]) {
               cell.spcInfoUITextField.placeholder = @"空闲车位";
            }else{
                cell.spcInfoUITextField.placeholder = @"车量";
            }
            if ([self.title isEqualToString:@"发布商品车"]) {
                [cell.tuJingChengShiUITextField removeFromSuperview];
                [cell.tuJingChengShi removeFromSuperview];
                [cell.chengshiImg removeFromSuperview];
                [cell.chengshiView removeFromSuperview];
                
            }
            cell.linkPhoneUITextField.enabled =cell.tuJingChengShiUITextField.enabled =cell.yunFeiUITextField.enabled = cell.qiTaUITextField.enabled = cell.faCheShiJianUITextField.enabled = cell.spcInfoUITextField.enabled = NO;
            cell.faCheShiJianUITextField.text = [NSString stringWithFormat:@"%@%@",faCheShiJian,faCheShiJianDes];
            
            NSLog(@"cellspcInfo:%@",spcInfo);
            cell.spcInfoUITextField.text = spcInfo;
            cell.yunFeiUITextField.text = yunFei;
            cell.qiTaUITextField.text = qiTa;
            cell.linkPhoneUITextField.text = linkPhone;

            [cell.faCheShiJian addTarget:self action:@selector(chooseDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.spcInfo addTarget:self action:@selector(ChooseParkVC) forControlEvents:UIControlEventTouchUpInside];
            [cell.yunFei addTarget:self action:@selector(inputyunFei) forControlEvents:UIControlEventTouchUpInside];
            [cell.qiTa addTarget:self action:@selector(inputqiTa) forControlEvents:UIControlEventTouchUpInside];
            [cell.tuJingChengShi addTarget:self action:@selector(viaCityVC) forControlEvents:UIControlEventTouchUpInside];

            if (tujingCSArr.count!=0) {
                NSDictionary *citydic = [tujingCSArr firstObject];
                cell.tuJingChengShiUITextField.text = citydic[@"address"];
                [cell.tuJingChengShiUIView showBadgeWithStyle:WBadgeStyleNumber value:tujingCSArr.count animationType:WBadgeAnimTypeNone];
            }
            
            [cell.linkPhone addTarget:self action:@selector(linkPhoneVC) forControlEvents:UIControlEventTouchUpInside];


            return cell;
            
        }
            break;
        default:
            break;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.row) {
        case 0:
            return 105.f;
            break;
        case 1:
            return 200.f;
            break;
            
        default:
            break;
    }
    return 0.f;
}


-(void)btnDown:(UIButton *)btn;
{
    if (btn.tag==101) {
        PickGoorBack=0;
    }else if (btn.tag==102){
        PickGoorBack=1;
    }
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0.3;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height-190, self.view.frame.size.width, 190)];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
//取消
-(void)cacleBtn
{
    [self clearAdress];
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
//暂时没做其他操作   仅仅是取消
-(void)okBtn
{
    if (fromAddress.length==0&&PickGoorBack==0) {
        fromAddress = baseAddress;
    }else if (toAddress.length==0&&PickGoorBack==1){
        toAddress = baseAddress;
    }
    [M_tableview reloadData];
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
-(void)didSelete:(NSString *)pro andCity:(NSString *)city andTown:(NSString *)town
{
    if (PickGoorBack==0) {
        fromAddress = [NSString stringWithFormat:@"%@,%@,%@",pro,city,town];
    }else if (PickGoorBack==1){
        toAddress = [NSString stringWithFormat:@"%@,%@,%@",pro,city,town];
    }

}

-(void)didSelete:(NSString *)ShengId ShiId:(NSString *)city QuId:(NSString *)town;
{
    if (PickGoorBack==0) {
        fromShengId = ShengId;
        fromShiId = city;
        fromQuId = town;
    }else if (PickGoorBack==1){
        toShengId = ShengId;
        toShiId = city;
        toQuId = town;
    }
}


-(void)pickerViewtitle:(NSString *)title ShengId:(NSString *)ShengId ShiId:(NSString *)ShiId QuId:(NSString *)QuId;{
    baseAddress = title;
    fromShengId = toShengId = ShengId;
    fromShiId = toShiId = ShiId;
    fromQuId = toQuId = QuId;
    
}

-(void)clearAdress{
    fromAddress = @"";
    toAddress = @"";
    [M_tableview reloadData];
}


- (void)chooseDateBtnClick
{
    [self.view endEditing:YES];
    _datePickerView = [[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:nil options:nil][0];
    UITapGestureRecognizer *gestrue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CancelChoose)];//给view视图添加一个点击手势
    [_datePickerView addGestureRecognizer:gestrue];
    [_datePickerView.cancelBtn addTarget:self action:@selector(CancelChoose) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerView.doneBtn addTarget:self action:@selector(DoneChoose) forControlEvents:UIControlEventTouchUpInside];
    _datePickerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //完成上移动画
     __weak __typeof(&*self)weakSelf = self;
    CGRect actionSheetViewRect = _datePickerView.actionSheetView.frame;
    actionSheetViewRect.origin.y = self.view.frame.size.height;
    _datePickerView.actionSheetView.frame = actionSheetViewRect;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect actionSheetViewRect = _datePickerView.actionSheetView.frame;
        actionSheetViewRect.origin.y = weakSelf.view.frame.size.height - 206;
        _datePickerView.actionSheetView.frame = actionSheetViewRect;
    }];
    [self.view addSubview:_datePickerView];
}

//点击DatePicker取消按钮触发的事件
- (void)CancelChoose
{
    [self CancelAction];
}
//点击DatePicker完成按钮触发的事件
- (void)DoneChoose
{
    faCheShiJian = [_datePickerView.datePickerText substringToIndex:10];
    faCheShiJianDes = [_datePickerView.datePickerText substringFromIndex:10];
    [self CancelAction];
    [M_tableview reloadData];
}

//取消DatePicker选择动作
- (void)CancelAction
{
    //完成下移动画
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^
     {
         CGRect actionSheetViewRect = _datePickerView.actionSheetView.frame;
         actionSheetViewRect.origin.y = weakSelf.view.frame.size.height;
         _datePickerView.actionSheetView.frame = actionSheetViewRect;
     } completion:^(BOOL finished)
     {
         [_datePickerView removeFromSuperview];
     }];
}

- (void)ChooseParkVC {
    
    ChooseparkViewController *VC = nil;
    if ([self.title isEqualToString:@"发布物流车"]) {
        VC = [[ChooseparkViewController alloc]initWithwlorspType:0];
        VC.type = @"发布物流车";
        [self PUSHWithBlockView:VC andblock:^(NSDictionary *BlockDIC) {
            spcInfo = [BlockDIC objectForKey:@"spcInfo"];
            cheInfo = [BlockDIC objectForKey:@"cheInfo"];
            [M_tableview reloadData];
        }];
    }else if ([self.title isEqualToString:@"发布商品车"]){
//        VC = [[ChooseparkViewController alloc]initWithwlorspType:1];
//        VC.type = @"发布商品车";
        SPCChooseController *vc = [[SPCChooseController alloc] init];
        
        [vc returnDic:^(NSString *cheInfo1) {
            
            cheInfo = cheInfo1;
            
            spcInfo = cheInfo1;
            
            [M_tableview reloadData];
            
        }];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([self.title isEqualToString:@"发布救援车"]){
        VC = [[ChooseparkViewController alloc]initWithwlorspType:2];
        VC.type = @"发布救援车";
        [self PUSHWithBlockView:VC andblock:^(NSDictionary *BlockDIC) {
            spcInfo = [BlockDIC objectForKey:@"spcInfo"];
            cheInfo = [BlockDIC objectForKey:@"cheInfo"];
            [M_tableview reloadData];
        }];
    }
    

}

- (void)inputyunFei {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入期望费用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *manualalt = [alert textFieldAtIndex:0];
    manualalt.keyboardType = UIKeyboardTypeNumberPad;
    alert.tag =111;
    [alert show];
    
}

- (void)inputqiTa {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入备注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    alert.tag =112;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        if (messageTextField.text.length > 0){
            if (alertView.tag ==111) {
                yunFei = [messageTextField.text formatMonery];
//                yunFei = messageTextField.text;
            }else if (alertView.tag ==112){
                qiTa = messageTextField.text;

            }
            [M_tableview reloadData];
        }
    }
}



#pragma mark - 发布物流车
- (void)requestPublishWLC{
    if (fromAddress.length==0) {
        [self.view makeToast:@"请选择出发地"];
        return;
    }else if (toAddress.length==0){
        [self.view makeToast:@"请选择目的地"];
        return;
    }else if (faCheShiJian.length==0){
        [self.view makeToast:@"请选择装车时间"];
        return;
    }else if (cheInfo.length==0){
        [self.view makeToast:@"请选择需求信息"];
        return;
    }else if (linkPhone.length==0){
        [self.view makeToast:@"请添加联系人"];
        return;
    }

    [SVProgressHUD showWithStatus:@"正在提交..."];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            fromAddress,@"fromAddress",
                            @"0",@"fromJingDu",
                            @"0",@"fromWeiDu",
                            fromShengId,@"fromShengId",
                            fromShiId,@"fromShiId",
                            fromQuId,@"fromQuId",
                            toAddress,@"toAddress",
                            @"0",@"toJingDu",
                            @"0",@"toWeiDu",
                            toShengId,@"toShengId",
                            toShiId,@"toShiId",
                            toQuId,@"toQuId",
                            faCheShiJian,@"faCheShiJian",
                            faCheShiJianDes,@"faCheShiJianDes",
                            cheInfo,@"wlcInfo",
                            yunFei,@"yunFei",
                            qiTa,@"qiTa",
                            linkName,@"linkName",
                            linkPhone,@"linkPhone",
                            tuJingChengShi,@"tuJingChengShi",
                            nil];
    NSLog(@"发布物流车:%@",params);
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"WLCWebService.asmx/PublishWLC_1" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self POPViewControllerForDictionary:nil];
            });
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark - 发布商品车
- (void)requestPublishSPC{
    if (fromAddress.length==0) {
        [self.view makeToast:@"请选择出发地"];
        return;
    }else if (toAddress.length==0){
        [self.view makeToast:@"请选择目的地"];
        return;
    }else if (faCheShiJian.length==0){
        [self.view makeToast:@"请选择装车时间"];
        return;
    }else if (cheInfo.length==0){
        [self.view makeToast:@"请选择需求信息"];
        return;
    }else if (linkPhone.length==0){
        [self.view makeToast:@"请添加联系人"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在提交..."];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            fromAddress,@"fromAddress",
                            @"0",@"fromJingDu",
                            @"0",@"fromWeiDu",
                            fromShengId,@"fromShengId",
                            fromShiId,@"fromShiId",
                            fromQuId,@"fromQuId",
                            toAddress,@"toAddress",
                            @"0",@"toJingDu",
                            @"0",@"toWeiDu",
                            toShengId,@"toShengId",
                            toShiId,@"toShiId",
                            toQuId,@"toQuId",
                            faCheShiJian,@"faCheShiJian",
                            faCheShiJianDes,@"faCheShiJianDes",
                            cheInfo,@"spcInfo",
                            yunFei,@"yunFei",
                            qiTa,@"qiTa",
                            linkName,@"linkName",
                            linkPhone,@"linkPhone",
                            tuJingChengShi,@"tuJingChengShi",
                            nil];
    NSLog(@"aaaaa发布商品车:%@",params);
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"SPCWebService.asmx/PublishSPC_2" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self POPViewControllerForDictionary:nil];
            });
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark - 发布救援车
- (void)requestPublishJYC{
    if (fromAddress.length==0) {
        [self.view makeToast:@"请选择出发地"];
        return;
    }else if (toAddress.length==0){
        [self.view makeToast:@"请选择目的地"];
        return;
    }else if (faCheShiJian.length==0){
        [self.view makeToast:@"请选择装车时间"];
        return;
    }else if (cheInfo.length==0){
        [self.view makeToast:@"请选择需求信息"];
        return;
    }else if (linkPhone.length==0){
        [self.view makeToast:@"请添加联系人"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在提交..."];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            fromAddress,@"fromAddress",
                            @"0",@"fromJingDu",
                            @"0",@"fromWeiDu",
                            fromShengId,@"fromShengId",
                            fromShiId,@"fromShiId",
                            fromQuId,@"fromQuId",
                            toAddress,@"toAddress",
                            @"0",@"toJingDu",
                            @"0",@"toWeiDu",
                            toShengId,@"toShengId",
                            toShiId,@"toShiId",
                            toQuId,@"toQuId",
                            faCheShiJian,@"faCheShiJian",
                            faCheShiJianDes,@"faCheShiJianDes",
                            cheInfo,@"jycInfo",
                            yunFei,@"yunFei",
                            qiTa,@"qiTa",
                            linkName,@"linkName",
                            linkPhone,@"linkPhone",
                            tuJingChengShi,@"tuJingChengShi",
                            nil];
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"JYCWebService.asmx/PublishJYC_1" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
        [SVProgressHUD dismiss];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self POPViewControllerForDictionary:nil];
            });
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

/**
 *  返回途经城市
 */
- (void)viaCityVC{
    ChooseViaCityController *VC = [[ChooseViaCityController alloc]init];
    [self PUSHWithBlockView:VC andblock:^(NSDictionary *BlockDIC) {
        tujingCSArr = BlockDIC[@"city"];
        if (tujingCSArr.count!=0) {
            tuJingChengShi = [tujingCSArr JSONString];
            [M_tableview reloadData];
        }
    }];
}
/**
 *  返回联系人
 */
- (void)linkPhoneVC{
    
    MyDJYContactViewController *VC =[[MyDJYContactViewController alloc]initWithDictionary:@{@"ChoseContact":@"YES"}];
    [self PUSHWithBlockView:VC andblock:^(NSDictionary *BlockDIC) {
        linkPhone = [BlockDIC objectForKey:@"phone"];
        linkName = [BlockDIC objectForKey:@"name"];
        [M_tableview reloadData];
    }];
    
}


@end
