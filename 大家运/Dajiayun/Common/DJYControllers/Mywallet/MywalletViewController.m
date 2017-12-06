//
//  MywalletViewController.m
//  Dajiayun
//
//  Created by CityAndCity on 16/2/21.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "MywalletViewController.h"
#import "RecordController.h"
#import "PackageController.h"

@interface MywalletViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *M_tableview;
}
@end

@implementation MywalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    [self setedgesForExtendedLayoutNO];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    // Do any additional setup after loading the view.
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
//    return 2;
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    if (indexPath.row == 0) {
    
        static NSString *cellIdentifier = @"DJYXIBTableViewCell2";
        DJYXIBTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
            cell = (DJYXIBTableViewCell2 *)[nib objectAtIndex:2];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.headimageview.image = [UIImage imageNamed:@"11"];
        cell.titlelabel.text = @"我的钱包";
        cell.detaillabel.text = @"￥0";
        cell.detaillabel.textColor = UIColorDJYThemecolorsRGB;
        
        return cell;
        
//    }else {
//    
//        static NSString *cellIdentifier = @"DJYXIBTableViewCell2";
//        DJYXIBTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if ( cell == nil ) {
//            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
//            cell = (DJYXIBTableViewCell2 *)[nib objectAtIndex:2];
//            cell.selectionStyle = UITableViewCellSelectionStyleGray;
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        cell.headimageview.image = [UIImage imageNamed:@"11"];
//        cell.titlelabel.text = @"购买套餐";
////        cell.detaillabel.text = @"￥0";
//        cell.detaillabel.textColor = UIColorDJYThemecolorsRGB;
//        
//        return cell;
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return HeightForRowInSection;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section  {
    return 0.00001f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return HeightForHeaderInSection;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row == 0) {
    
        RecordController *vc = [[RecordController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
//    }else {
//    
//        PackageController *vc = [[PackageController alloc] init];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }
    
}


@end
