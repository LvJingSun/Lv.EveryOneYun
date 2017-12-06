//
//  RecordController.m
//  Dajiayun
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "RecordController.h"
#import "MoneyView.h"
#import "LiuXSegmentView.h"
#import "TransactionCell.h"
#import "WithdrawalsController.h"

#define HOME_BACK_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]

@interface RecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) MoneyView *moneyView;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation RecordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self requestAllData];
    
    self.title = @"交易记录";
    
    self.view.backgroundColor = HOME_BACK_COLOR;
    
    UIButton *reflectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    reflectBtn.frame=CGRectMake(0, 0, 40, 40) ;
    
    reflectBtn.backgroundColor=[UIColor clearColor];
    
    [reflectBtn setTitle:@"提现" forState:UIControlStateNormal];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;

    MoneyView *moneyView = [[MoneyView alloc] initWithFrame:CGRectMake(10, rectNav.size.height + rectStatus.size.height + 10, self.view.bounds.size.width - 20, 80)];

    self.moneyView = moneyView;
    
    moneyView.layer.cornerRadius = 5;
    
    moneyView.layer.masksToBounds = YES;
    
    [self.view addSubview:moneyView];
    
    [reflectBtn addTarget:self action:@selector(addContactAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barreflectBtn=[[UIBarButtonItem alloc]initWithCustomView:reflectBtn];
    
    self.navigationItem.rightBarButtonItem = barreflectBtn;
    
    LiuXSegmentView *segmentview = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, rectNav.size.height + rectStatus.size.height + 100, self.view.bounds.size.width, 50) titles:@[@"全部",@"收入",@"支出"] clickBlick:^(NSInteger index) {
        
        if (index == 1) {
            
            [self requestAllData];
  
        }else if (index == 2) {
            
            [self IncomeArray];

        }else {
            
            [self RealeaseArray];
        }
        
        [self.tableview reloadData];
        
    }];
    
    segmentview.titleNomalColor = [UIColor grayColor];
    
    segmentview.titleSelectColor = [UIColor colorWithRed:15./255 green:116./255 blue:29./255 alpha:1.];
    
    [self.view addSubview:segmentview];
    
    
    CGFloat y = rectNav.size.height + rectStatus.size.height + 150;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无数据";
    
    label.textColor = [UIColor lightGrayColor];
    
    self.noLabel = label;
    
    [self.view addSubview:label];
    
    
    

}

- (void)addContactAction {
    
    WithdrawalsController *txCon = [[WithdrawalsController alloc] init];
    
    [self.navigationController pushViewController:txCon animated:YES];
    
}

- (void)requestAllData {

        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                                [CachesDirectory getServerKey],@"key",
                                nil];
        [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GetJiaoYiList" params:params networkBlock:^{
            [self.view makeToast:@"没有网络!"];
        } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
            BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
            if (success) {
                NSDictionary *dic = (NSDictionary *)responseObject;
                
                self.moneyView.balanceMoneyLab.text = dic[@"YuE"];
                
                self.moneyView.incomeMoneyLab.text = dic[@"ZongShouRu"];
                
                self.moneyView.expenditureMoneyLab.text = dic[@"ZongZhiChu"];
                
                NSArray *dataArr = dic[@"JiaoYiJiLuList"];
                
                if (dataArr.count == 0) {

                    self.tableview.hidden = YES;
                    
                    self.noLabel.hidden = NO;
                    
                }else {
                    
                    self.tableview.hidden = NO;
                    
                    self.noLabel.hidden = YES;
                    
                    self.dataArray = dic[@"JiaoYiJiLuList"];
                    
                    [self.tableview reloadData];
                    
                }
                
            }
            
        } failedBlock:^(AFCustomClient *request, NSError *error) {
            
            [self.view makeToast:@"数据加载失败"];
            
        }];
    
}

- (void)IncomeArray {

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            @"Income",@"type",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GetJiaoYiList" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            self.moneyView.balanceMoneyLab.text = dic[@"YuE"];
            
            self.moneyView.incomeMoneyLab.text = dic[@"ZongShouRu"];
            
            self.moneyView.expenditureMoneyLab.text = dic[@"ZongZhiChu"];
            
            NSArray *dataArr = dic[@"JiaoYiJiLuList"];
            if (dataArr.count == 0) {
                
                self.tableview.hidden = YES;
                
                self.noLabel.hidden = NO;
                
            }else {
                
                self.tableview.hidden = NO;
                
                self.noLabel.hidden = YES;
                
                self.dataArray = dic[@"JiaoYiJiLuList"];
                
                [self.tableview reloadData];
                
            }
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
        [self.view makeToast:@"数据加载失败"];
        
    }];
}

- (void)RealeaseArray {

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            @"Expenditure",@"type",
                            nil];
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GetJiaoYiList" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            self.moneyView.balanceMoneyLab.text = dic[@"YuE"];
            
            self.moneyView.incomeMoneyLab.text = dic[@"ZongShouRu"];
            
            self.moneyView.expenditureMoneyLab.text = dic[@"ZongZhiChu"];
            
            NSArray *dataArr = dic[@"JiaoYiJiLuList"];
            if (dataArr.count == 0) {
                self.tableview.hidden = YES;
                
                self.noLabel.hidden = NO;
            }else {
                
                self.tableview.hidden = NO;
                
                self.noLabel.hidden = YES;
                
                self.dataArray = dic[@"JiaoYiJiLuList"];
                
                [self.tableview reloadData];
                
            }
            
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
        [self.view makeToast:@"数据加载失败"];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    TransactionCell *cell = [TransactionCell TransactionCellWithTableView:tableView];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    cell.dateLab.text = dic[@"TransactionDateDay"];
    
    cell.timeLab.text = dic[@"TransactionDateTime"];
    
    if ([dic[@"TradingOperations"] isEqualToString:@"Income"]) {
        
        cell.imgImage.image = [UIImage imageNamed:@"income.png"];
        
        cell.countLab.textColor = [UIColor colorWithRed:15./255 green:116./255 blue:29./255 alpha:1.];
        
        cell.countLab.text = [NSString stringWithFormat:@"+%@",dic[@"Amount"]];
        
    }else {
    
        cell.imgImage.image = [UIImage imageNamed:@"release.png"];
        
        cell.countLab.textColor = [UIColor redColor];
        
        cell.countLab.text = [NSString stringWithFormat:@"-%@",dic[@"Amount"]];
        
    }
    
    cell.sourceLab.text = dic[@"TransactionTypeDes"];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionCell *cell = [TransactionCell TransactionCellWithTableView:tableView];
    
    return cell.height;
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
