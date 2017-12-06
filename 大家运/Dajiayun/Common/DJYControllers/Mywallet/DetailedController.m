//
//  DetailedController.m
//  Dajiayun
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "DetailedController.h"
#import "TXrecordCell.h"

@interface DetailedController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation DetailedController

-(NSArray *)dataArray {

    if (_dataArray == nil) {
        
        NSMutableArray *mutArr = [NSMutableArray array];
        
        for (int i = 0; i < self.array.count; i++) {
            
            NSDictionary *dic = (NSDictionary *)self.array[i];
            
            if ([dic[@"StatusDes"] isEqualToString:self.str]) {
                
                [mutArr addObject:self.array[i]];
                
            }
            
        }
        
        _dataArray = mutArr;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.str;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    if (self.dataArray.count == 0) {
        
        self.tableview.hidden = YES;
        
        self.noLabel.hidden = NO;
        
    }else {
    
        self.tableview.hidden = NO;
        
        self.noLabel.hidden = YES;
        
    }

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    TXrecordCell *cell = [[TXrecordCell alloc] init];
    
    NSDictionary *dic = (NSDictionary *)self.dataArray[indexPath.row];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TXrecordCell *cell = [[TXrecordCell alloc] init];
    
    return cell.height;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
