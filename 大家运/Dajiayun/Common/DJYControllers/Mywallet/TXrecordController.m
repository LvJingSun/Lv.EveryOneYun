//
//  TXrecordController.m
//  Dajiayun
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "TXrecordController.h"
#import "TXrecordCell.h"
#import "DetailedController.h"
#define HOME_BACK_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]

@interface TXrecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation TXrecordController

-(NSArray *)typeArray {

    if (_typeArray == nil) {
        
        _typeArray = @[@"待审核",@"处理中",@"已完成",@"已退回"];
        
    }
    
    return _typeArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现记录";
    
    self.view.backgroundColor = HOME_BACK_COLOR;
    
    [self requestData];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    self.tableview = tableView;
    
    [self.view addSubview:tableView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无数据";
    
    label.textColor = [UIColor lightGrayColor];
    
    self.noLabel = label;
    
    [self.view addSubview:label];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.typeArray.count;
        
    }else {
        
        return self.array.count;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 20;
        
    }else {
        
        return 0;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *ID = @"ID";
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = self.typeArray[indexPath.row];
        
        return cell;
        
    }else {
        
        TXrecordCell *cell = [[TXrecordCell alloc] init];
        
        NSDictionary *dic = (NSDictionary *)self.array[indexPath.row];
        
        cell.RealNameLabel.text = dic[@"RealName"];
        
        cell.StatusDesLabel.text = dic[@"StatusDes"];
        
        cell.AmountLabel.text = dic[@"Amount"];
        
        if ([dic[@"TiXianType"] isEqualToString:@"TiXianType_1"]) {
            
            cell.TiXianTypeDesImageView.image = [UIImage imageNamed:@"银联.png"];
            
        }else {
        
            cell.TiXianTypeDesImageView.image = [UIImage imageNamed:@"支付宝.png"];
            
        }
        
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 40;
        
    }else {
        
        TXrecordCell *cell = [[TXrecordCell alloc] init];
        
        return cell.height;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        DetailedController *detailvc = [[DetailedController alloc] init];
        
        detailvc.str = self.typeArray[indexPath.row];
        
        detailvc.array = self.array;
        
        [self.navigationController pushViewController:detailvc animated:YES];
        
    }
    
}

- (void)requestData {

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GetTiXianList" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            self.array = [responseObject valueForKey:@"TiXianModelList"];
            if (self.array.count == 0) {
                self.tableview.hidden = YES;
                self.noLabel.hidden = NO;
            }else {
                self.tableview.hidden = NO;
                self.noLabel.hidden = YES;
            }

//            [self showReloadViewWithArray:self.array WithMsg:@"暂无数据，轻点试试刷新" Withtableview:M_tableview];
            
        }else {
            [self.view makeToast:[responseObject valueForKey:@"Msg"]];
        }
        [self.tableview reloadData];
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:@"数据请求失败"];
    }];
    
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
