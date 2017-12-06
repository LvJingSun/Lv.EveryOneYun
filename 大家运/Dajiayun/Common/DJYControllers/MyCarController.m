//
//  MyCarController.m
//  Dajiayun
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "MyCarController.h"
#import "GoodsCar.h"
#import "GoodsCarFrame.h"
#import "GoodsCarCell.h"

@interface MyCarController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *goodsCarFrameArray;

@end

@implementation MyCarController

-(NSArray *)goodsCarFrameArray {
    
    if (_goodsCarFrameArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"GoodsCar.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            
            GoodsCar *goodsCar = [[GoodsCar alloc] initWithDict:dic];
            
            GoodsCarFrame *frame = [[GoodsCarFrame alloc] init];
            
            frame.goodsCar = goodsCar;
            
            [tempArray addObject:frame];
            
        }
        
        _goodsCarFrameArray = tempArray;
        
    }
    
    return _goodsCarFrameArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的车辆";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //状态栏和导航栏的高度
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - rectStatus.size.height - rectNav.size.height)];
    
    //    tableview.backgroundColor = [UIColor blackColor];
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    self.tableview = tableview;
    
    [self.view addSubview:tableview];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.goodsCarFrameArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsCarCell *cell = [GoodsCarCell GoodsCarCellWithTableView:tableView];
    
    cell.carFrame = self.goodsCarFrameArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsCarFrame *frame = self.goodsCarFrameArray[indexPath.row];
    
    return frame.height;
    
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
