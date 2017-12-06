//
//  FirstViewController.m
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//
#import "FirstViewController.h"
//#import "FriendsTimeLineViewController.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *M_tableview;
}
@property (nonatomic, strong) NSMutableArray            *dataArr;

@end


@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];

}

- (void)viewWillAppear:(BOOL)animated
{
    M_tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)selectTabbar:(UINavigationItem *)Item{
    Item.rightBarButtonItem = nil;
    UIButton *FriendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    FriendBtn.frame=CGRectMake(0, 0, 40, 40) ;
    FriendBtn.backgroundColor=[UIColor clearColor];
    [FriendBtn setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    UIButton *AddBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    AddBtn.frame=CGRectMake(0, 0, 40, 40) ;
    AddBtn.backgroundColor=[UIColor clearColor];
    [AddBtn  setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    UIBarButtonItem *barFriendBtn=[[UIBarButtonItem alloc]initWithCustomView:FriendBtn];
    UIBarButtonItem *barAddBtn=[[UIBarButtonItem alloc]initWithCustomView:AddBtn];
    NSArray *rightBtns=[NSArray arrayWithObjects:barAddBtn,barFriendBtn, nil];
    Item.rightBarButtonItems=rightBtns;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"FirstViewContrller";
    UITableViewCell *cell                       = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:@"7"];
    cell.textLabel.text = @"物流圈";
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return HeightForHeaderInSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return HeightForRowInSection;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end

