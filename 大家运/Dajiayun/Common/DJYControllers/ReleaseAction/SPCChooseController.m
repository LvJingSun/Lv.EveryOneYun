//
//  SPCChooseController.m
//  Dajiayun
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "SPCChooseController.h"
#import "ChooseCarController.h"
#define viewWidth self.view.bounds.size.width

@interface SPCChooseController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *carName;
    
    NSString *count;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UITextField *carNameField;

@property (nonatomic, weak) UILabel *countLabel;

@property (nonatomic, weak) UIButton *reduceBtn;

@property (nonatomic, weak) UIButton *addBtn;

@property (nonatomic, weak) UIImageView *cheImage;

@end

@implementation SPCChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择车型";
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:244/255. alpha:1.];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:244/255. alpha:1.];
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
    [self initWithHeadView];
    
    [self setRightBtn];

}

- (void)initWithHeadView {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 110)];
    
    view.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:244/255. alpha:1.];
    
    self.tableview.tableHeaderView = view;
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, viewWidth, 80)];
    
    view2.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:view2];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth * 0.075, 5, viewWidth * 0.1, 35)];
    
    icon.image = [UIImage imageNamed:@"小型_选中.png"];
    
    self.cheImage = icon;
    
    [view2 addSubview:icon];
    
    UITextField *carNameLabel = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.25, 5, viewWidth * 0.55, 35)];
    
    carNameLabel.font = [UIFont systemFontOfSize:14];
    
    carNameLabel.placeholder = @"请选择品牌/车型";
    
    carNameLabel.textColor = [UIColor colorWithRed:31/255. green:31/255. blue:31/255. alpha:1.];
    
    self.carNameField = carNameLabel;
    
    [view2 addSubview:carNameLabel];
    
    UIImageView *jiantouImageview = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth * 0.925, 15, viewWidth * 0.025, 10)];
    
    jiantouImageview.image = [UIImage imageNamed:@"list_row_arrow.png"];
    
    [view2 addSubview:jiantouImageview];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.05, CGRectGetMaxY(icon.frame), viewWidth * 0.9, 1)];
    
    line1.backgroundColor = [UIColor colorWithRed:226/255. green:226/255. blue:228/255. alpha:1.];
    
    [view2 addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.25, CGRectGetMaxY(line1.frame), 1, 29)];
    
    line2.backgroundColor = [UIColor colorWithRed:226/255. green:226/255. blue:228/255. alpha:1.];
    
    [view2 addSubview:line2];
    
    UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), viewWidth * 0.25, 29)];
    
    [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    
    [reduceBtn setTitleColor:[UIColor colorWithRed:226/255. green:226/255. blue:228/255. alpha:1.] forState:UIControlStateNormal];
    
    self.reduceBtn = reduceBtn;
    
    [reduceBtn addTarget:self action:@selector(reduceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view2 addSubview:reduceBtn];
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.75, CGRectGetMaxY(line1.frame), 1, 29)];
    
    line3.backgroundColor = [UIColor colorWithRed:226/255. green:226/255. blue:228/255. alpha:1.];
    
    [view2 addSubview:line3];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth * 0.75, CGRectGetMaxY(line1.frame), viewWidth * 0.25, 29)];
    
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    
    [addBtn setTitleColor:[UIColor colorWithRed:226/255. green:226/255. blue:228/255. alpha:1.] forState:UIControlStateNormal];
    
    self.addBtn = addBtn;
    
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view2 addSubview:addBtn];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.25, CGRectGetMaxY(line1.frame), viewWidth * 0.5, 29)];
    
    countLabel.textAlignment = NSTextAlignmentCenter;
    
    countLabel.textColor = [UIColor blackColor];
    
    countLabel.text = @"0";
    
    self.countLabel = countLabel;
    
    [view2 addSubview:countLabel];
    
    UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 40)];
    
    [selectBtn addTarget:self action:@selector(selectCarClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view2 addSubview:selectBtn];
    
}

- (void)viewWillAppear:(BOOL)animated {

    if ([self.carNameField.text isEqualToString:@""]) {
        
        self.countLabel.text = @"0";
        
    }else {
    
        self.countLabel.text = @"1";
        
    }
    
    if ([self.countLabel.text isEqualToString:@"0"]) {
        
        self.addBtn.enabled = NO;
        
        self.reduceBtn.enabled = NO;
        
    }else if ([self.countLabel.text isEqualToString:@"1"]) {
    
        self.addBtn.enabled = YES;
        
        [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.reduceBtn.enabled = NO;
        
    }else {
    
        self.addBtn.enabled = YES;
        
        [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.reduceBtn.enabled = YES;
        
        [self.reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
}

- (void)selectCarClick {

    ChooseCarController *vc = [[ChooseCarController alloc] init];
    
    [vc returnCarName:^(NSString *carName1, NSString *image) {
        
        self.carNameField.text = carName1;
        
        self.cheImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
        
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)reduceBtnClick {
    
    if ([self.countLabel.text intValue] == 2) {
        
        self.reduceBtn.enabled = NO;
        
        [self.reduceBtn setTitleColor:[UIColor colorWithRed:226/255. green:226/255. blue:228/255. alpha:1.] forState:UIControlStateNormal];
        
    }
    
    int i = [self.countLabel.text intValue];
    
    i --;
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",i];

}

- (void)addBtnClick {

    int i = [self.countLabel.text intValue];
    
    self.reduceBtn.enabled = YES;
    
    [self.reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    i ++;
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",i];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
    
}

- (void)setRightBtn {

    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    screenBtn.frame = CGRectMake(0, 0, 60, 20);
    
    [screenBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [screenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    
    self.navigationItem.rightBarButtonItem = screenBarBtn;
    
}

- (void)screenBtnClick {
    
    if ([self.carNameField.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择车型" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
    
        carName = self.carNameField.text;
        
        count = self.countLabel.text;
        
        NSString *string = [NSString stringWithFormat:@"%@,%@",carName,count];
        
        self.cheInfo(string);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)returnDic:(ReturnDic)block {

    self.cheInfo = block;
    
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
