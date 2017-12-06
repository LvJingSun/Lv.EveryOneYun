//
//  WithdrawalsController.m
//  Dajiayun
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "WithdrawalsController.h"
#import "ContentView.h"
#import "GMDCircleLoader.h"
#import "TXrecordController.h"
#define HOME_BACK_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]
#define Width  ([[UIScreen mainScreen] bounds].size.width)
#define Height  ([[UIScreen mainScreen] bounds].size.height)

@interface WithdrawalsController () {
    NSString *TiXianType;
    
    NSString *amount;
    
    NSString *zhangHao;
    
    NSString *realName;
    
    NSString *kaiHuHang;
    
    NSString *wangDian;
}

@property (nonatomic, weak) UISegmentedControl *segmview;

@property (nonatomic, weak) ContentView *contentview;

@property (nonatomic, weak) UIButton *sureBtn;

@property (nonatomic, weak) UILabel *waring;



@end

@implementation WithdrawalsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
    self.view.backgroundColor = HOME_BACK_COLOR;
    
    UIButton *reflectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    reflectBtn.frame=CGRectMake(0, 0, 80, 40) ;
    
    reflectBtn.backgroundColor=[UIColor clearColor];
    
    [reflectBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    
    [reflectBtn addTarget:self action:@selector(addContactAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barreflectBtn=[[UIBarButtonItem alloc]initWithCustomView:reflectBtn];
    
    self.navigationItem.rightBarButtonItem = barreflectBtn;
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"银行卡",@"支付宝"]];
    
    segmview.frame = CGRectMake(Width * 0.35, 79, Width * 0.3, 30);
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = [UIColor colorWithRed:19/255. green:151/255. blue:36/255. alpha:1.];
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
    [self setContentView];
    
    self.contentview.Label1.text = @"到账银行卡";
    
    TiXianType = @"TiXianType_1";
    
    [self setSureBtn];
    
    [self setTextView];
    
    // Do any additional setup after loading the view.
}

- (void)addContactAction {

    TXrecordController *vc = [[TXrecordController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.contentview resignFirst];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
    NSInteger index = segm.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            [self setYinHangKa];
            break;
            
        case 1:
            [self setZhiFuBao];
            break;
            
        default:
            break;
    }
    
}

- (void)setZhiFuBao {
    
    TiXianType = @"TiXianType_2";
    
    self.contentview.Label1.text = @"到账支付宝";
    self.contentview.Label2.text = @"用户姓名";
    self.contentview.Label6.text = [NSString stringWithFormat:@"账户余额¥1000"];
    
    self.contentview.type.text = @"";
    self.contentview.name.text = @"";
    self.contentview.kaihu.text = @"";
    self.contentview.count.text = @"";
    
    self.contentview.Label3.hidden = YES;
    self.contentview.kaihu.hidden = YES;
    self.contentview.Line3.hidden = YES;
    
}

- (void)setYinHangKa {
    
    TiXianType = @"TiXianType_1";
    
    self.contentview.Label1.text = @"到账银行卡";
    self.contentview.Label2.text = @"开户姓名";
    self.contentview.Label6.text = [NSString stringWithFormat:@"账户余额¥1000"];
    
    self.contentview.type.text = @"";
    self.contentview.name.text = @"";
    self.contentview.kaihu.text = @"";
    self.contentview.count.text = @"";
    
    self.contentview.Label3.hidden = NO;
    self.contentview.kaihu.hidden = NO;
    self.contentview.Line3.hidden = NO;
    
}

- (void)setContentView {

    ContentView *contentview = [[ContentView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.segmview.frame) + 15, Width - 60, Height * 0.3)];
    
    contentview.backgroundColor = [UIColor whiteColor];
    
    self.contentview = contentview;
    
    contentview.layer.cornerRadius = 5;
    
    [self.view addSubview:contentview];
    
    UILabel *waring = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(contentview.frame) + 5, Width - 60, 20)];
    
    waring.text = @"预计三天内到账";
    
    waring.textColor = [UIColor lightGrayColor];
    
    waring.textAlignment = NSTextAlignmentCenter;
    
    self.waring = waring;
    
    [self.view addSubview:waring];
    
}

- (void)setSureBtn {

    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.waring.frame) + 5, Width - 60, 30)];
    
    [sureBtn setTitle:@"提现" forState:UIControlStateNormal];
    
    sureBtn.backgroundColor = [UIColor colorWithRed:19/255. green:151/255. blue:36/255. alpha:1.];
    
    [sureBtn addTarget:self action:@selector(tiXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.sureBtn = sureBtn;
    
    sureBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:sureBtn];
    
}

- (void)tiXianBtnClick {
    
    [self.contentview resignFirst];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"提交数据中..." animated:YES];
    
    amount = self.contentview.count.text;
    
    zhangHao = self.contentview.type.text;
    
    realName = self.contentview.name.text;
    
    kaiHuHang = self.contentview.kaihu.text;
    
    wangDian = @"默认";

    [self requestData];
    
}

- (void)requestData {
    
    [GMDCircleLoader hideFromView:self.view animated:YES];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            realName,@"realName",
                            zhangHao,@"zhangHao",
                            wangDian,@"wangDian",
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            TiXianType,@"tiXianType",
                            amount,@"amount",
                            kaiHuHang,@"kaiHuHang",
                            nil];
    
    NSLog(@"%@",params);
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/TiXianAdd" params:params networkBlock:^{
        [GMDCircleLoader hideFromView:self.view animated:YES];
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            
            [GMDCircleLoader hideFromView:self.view animated:YES];
            
            [self.view makeToast:[responseObject valueForKey:@"Msg"]];
            
        }else {
            [GMDCircleLoader hideFromView:self.view animated:YES];
            
            [self.view makeToast:[responseObject valueForKey:@"Msg"]];
            
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [GMDCircleLoader hideFromView:self.view animated:YES];
        [self.view makeToast:@"数据加载失败"];
        
    }];
    
}

- (void)setTextView {

    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.sureBtn.frame) + 15, Width - 60, Height * 0.3)];
    
    textview.backgroundColor = [UIColor lightGrayColor];
    
    textview.textColor = [UIColor darkGrayColor];
    
    textview.text = @"温馨提示：\n1.请确保您输入的提现金额，以及账户信息无误。\n2.如果您填写的提现信息不正确可能会导致体现失败，由此产生的提现费用将不予返还。\n3.在双休日和法定节假日期间，用户可以申请提现，工作人员会在下一个工作日进行处理。由此造成的不便，请多多谅解！\n4.平台禁止洗钱、虚假交易等行为，一经发现并确认，将终止该用户的使用。";
    
    textview.layer.cornerRadius = 5;
    
    textview.editable = NO;
    
    [self.view addSubview:textview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
