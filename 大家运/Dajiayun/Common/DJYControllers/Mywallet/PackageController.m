//
//  PackageController.m
//  Dajiayun
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "PackageController.h"
#import "BuyPackageView.h"

@interface PackageController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {

    int price;
    
    NSString *type;
    
    NSString *allPrice;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) BuyPackageView *buyView;

@property (nonatomic, weak) UIButton *model1Btn;

@property (nonatomic, weak) UIButton *model2Btn;

@property (nonatomic, weak) UIButton *model3Btn;

@property (nonatomic, weak) UIButton *weixinBtn;

@property (nonatomic, weak) UIButton *zhifubaoBtn;

@property (nonatomic, weak) UITextField *countField;

@end

@implementation PackageController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    price = 1;
    
    type = @"";
    
    self.title = @"购买套餐";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    BuyPackageView *buyView = [[BuyPackageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 410)];
    
    self.buyView = buyView;
    
    tableview.tableHeaderView = buyView;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [buyView.model1Btn addTarget:self action:@selector(selectModel1:) forControlEvents:UIControlEventTouchUpInside];
    
    self.model1Btn = buyView.model1Btn;
    
    [buyView.model2Btn addTarget:self action:@selector(selectModel2:) forControlEvents:UIControlEventTouchUpInside];
    
    self.model2Btn = buyView.model2Btn;
    
    [buyView.model3Btn addTarget:self action:@selector(selectModel3:) forControlEvents:UIControlEventTouchUpInside];
    
    self.model3Btn = buyView.model3Btn;
    
    [buyView.weixinBtn addTarget:self action:@selector(weixinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.weixinBtn = buyView.weixinBtn;
    
    [buyView.zhifubaoBtn addTarget:self action:@selector(zhifubaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.zhifubaoBtn = buyView.zhifubaoBtn;
    
    self.model1Btn.backgroundColor = [UIColor blueColor];
    
    self.model1Btn.alpha = 0.3;
    
    buyView.countField.delegate = self;
    
    self.countField = buyView.countField;
    
}

- (void)selectModel1:(UIButton *)sender {

    price = 1;
    
    self.model1Btn.backgroundColor = [UIColor blueColor];
    
    self.model1Btn.alpha = 0.3;
    
    self.model2Btn.backgroundColor = [UIColor clearColor];
    
    self.model2Btn.alpha = 1.0;
    
    self.model3Btn.backgroundColor = [UIColor clearColor];
    
    self.model3Btn.alpha = 1.0;
    
    int count = [self.buyView.countField.text intValue];
    
    self.buyView.allPriceLabel.text = [NSString stringWithFormat:@"%.1f元",(float)(price * count)];
    
}

- (void)selectModel2:(UIButton *)sender {

    price = 50;
    
    self.model2Btn.backgroundColor = [UIColor blueColor];
    
    self.model2Btn.alpha = 0.3;
    
    self.model1Btn.backgroundColor = [UIColor clearColor];
    
    self.model1Btn.alpha = 1.0;
    
    self.model3Btn.backgroundColor = [UIColor clearColor];
    
    self.model3Btn.alpha = 1.0;
    
    int count = [self.buyView.countField.text intValue];
    
    self.buyView.allPriceLabel.text = [NSString stringWithFormat:@"%.1f元",(float)(price * count)];
    
}

- (void)selectModel3:(UIButton *)sender {

    price = 365;
    
    self.model3Btn.backgroundColor = [UIColor blueColor];
    
    self.model3Btn.alpha = 0.3;
    
    self.model2Btn.backgroundColor = [UIColor clearColor];
    
    self.model2Btn.alpha = 1.0;
    
    self.model1Btn.backgroundColor = [UIColor clearColor];
    
    self.model1Btn.alpha = 1.0;
    
    int count = [self.buyView.countField.text intValue];
    
    self.buyView.allPriceLabel.text = [NSString stringWithFormat:@"%.1f元",(float)(price * count)];
    
}

- (void)weixinBtnClick {

    type = @"微信";
    
    self.weixinBtn.backgroundColor = [UIColor blueColor];
    
    self.weixinBtn.alpha = 0.3;
    
    self.zhifubaoBtn.backgroundColor = [UIColor clearColor];
    
    self.zhifubaoBtn.alpha = 1.0;
}

- (void)zhifubaoBtnClick {

    type = @"支付宝";
    
    self.zhifubaoBtn.backgroundColor = [UIColor blueColor];
    
    self.zhifubaoBtn.alpha = 0.3;
    
    self.weixinBtn.backgroundColor = [UIColor clearColor];
    
    self.weixinBtn.alpha = 1.0;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    int count = [textField.text intValue];
    
    self.buyView.allPriceLabel.text = [NSString stringWithFormat:@"%.1f元",(float)(price * count)];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
    
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
