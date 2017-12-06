//
//  ChooseparkViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/2/1.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ChooseparkViewController.h"
#import "ChooseCarController.h"

@interface ChooseparkViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *M_tableview;
    
    //0表示物流1表示商品车
    NSInteger wlorspType;
}
@property (nonatomic, strong) NSMutableArray            *dataArr;
@property (nonatomic, strong) NSMutableArray            *dataminArr;
@property (nonatomic, strong) NSMutableArray            *datacarnameArr;
@property (nonatomic, strong) NSMutableArray            *datacarimageArr;


@end

@implementation ChooseparkViewController

- (instancetype)initWithwlorspType:(NSInteger)Type;
{
    self = [super init];
    if (self) {
        wlorspType = Type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择车位";
    // Do any additional setup after loading the view.
    [self setedgesForExtendedLayoutNO];
    self.datacarimageArr = [[NSMutableArray alloc]initWithObjects:@"大型",@"中型",@"小型", nil];
    self.datacarnameArr = [[NSMutableArray alloc]initWithObjects:@"吉普型",@"轿车",@"其他", nil];
    //    self.datacarnameArr = [[NSMutableArray alloc]initWithObjects:@"请选择",@"请选择",@"请选择", nil];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0", nil];
    self.dataminArr = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0", nil];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    
    self.navigationItem.rightBarButtonItem = [self SetnavigationBartitle:@"完成" andaction:@selector(rightAction)];
    
}

- (void)rightAction{
    __block NSString *spcInfo = @"";
    __block NSString *cheInfo = @"";
    
    [self.dataArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@"0"]) {
            if (idx==0) {
                spcInfo = [NSString stringWithFormat:@"吉普:%@",obj];
            }else if (idx==1){
                spcInfo = [NSString stringWithFormat:@"%@轿车:%@",spcInfo,obj];
            }else if (idx==2){
                spcInfo = [NSString stringWithFormat:@"%@其他:%@",spcInfo,obj];
            }
        }
        
        if (idx==0) {
            if (wlorspType==0) {
                cheInfo = [NSString stringWithFormat:@"WLCBig,%@",obj];
            }else if (wlorspType==1){
                cheInfo = [NSString stringWithFormat:@"SPCBig,%@",obj];
            }else if (wlorspType==2){
                cheInfo = [NSString stringWithFormat:@"JYCBig,%@",obj];
            }
        }else if (idx==1){
            if (wlorspType==0) {
                cheInfo = [NSString stringWithFormat:@"%@|WLCMid,%@",cheInfo,obj];
            }else if (wlorspType==1){
                cheInfo = [NSString stringWithFormat:@"%@|SPCMid,%@",cheInfo,obj];
            }else if (wlorspType==2){
                cheInfo = [NSString stringWithFormat:@"%@|JYCMid,%@",cheInfo,obj];
            }
        }else if (idx==2){
            if (wlorspType==0) {
                cheInfo = [NSString stringWithFormat:@"%@|WLCSml,%@",cheInfo,obj];
            }else if (wlorspType==1){
                cheInfo = [NSString stringWithFormat:@"%@|SPCSml,%@",cheInfo,obj];
            }else if (wlorspType==2){
                cheInfo = [NSString stringWithFormat:@"%@|JYCSml,%@",cheInfo,obj];
            }
        }
        
    }];
    
    [self POPViewControllerForDictionary:@{@"spcInfo":spcInfo,@"cheInfo":cheInfo}];
    
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
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIdentifier = @"DJYXIBTableViewCell7";
    DJYXIBTableViewCell7 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        cell = (DJYXIBTableViewCell7 *)[nib objectAtIndex:7];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.numberlabel.text = self.dataArr[indexPath.row];
    [cell.titlelabelBtn setTitle:self.datacarnameArr[indexPath.row] forState:UIControlStateNormal];
    //    [cell.titlelabelBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.titlelabelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.imageview.image = [UIImage imageNamed:self.datacarimageArr[indexPath.row]];
    if ([cell.numberlabel.text isEqualToString:@"0"]) {
        cell.jian.enabled = NO;
    }else{
        cell.jian.enabled = YES;
    }
    cell.jian.tag = indexPath.row;
    cell.jia.tag = indexPath.row;
    [cell.jian addTarget:self action:@selector(setpperjian:) forControlEvents:UIControlEventTouchUpInside];
    [cell.jia addTarget:self action:@selector(setpperjia:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)chooseBtnClick:(UIButton *)sender {
    
    ChooseCarController *vc = [[ChooseCarController alloc] init];
    
    [vc returnCarName:^(NSString *carName, NSString *image) {
        
        sender.titleLabel.text = carName;
        
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 58.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    if (indexPath.section==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setpperjian:(UIButton *)jian{
    NSInteger old = [[self.dataArr objectAtIndex:jian.tag] integerValue];
    if (old!=0) {
        old--;
    }
    [self.dataArr replaceObjectAtIndex:jian.tag withObject:[NSString stringWithFormat:@"%ld",(long)old]];
    [M_tableview reloadData];
}

-(void)setpperjia:(UIButton *)jia{
    NSInteger old = [[self.dataArr objectAtIndex:jia.tag] integerValue];
    old++;
    [self.dataArr replaceObjectAtIndex:jia.tag withObject:[NSString stringWithFormat:@"%ld",(long)old]];
    [M_tableview reloadData];
    
}


@end
