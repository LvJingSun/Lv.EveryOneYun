//
//  WilltodoViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/2/1.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "WilltodoViewController.h"
#import "NowtodoViewController.h"
#import "DoneRViewController.h"
#import "ReportRViewController.h"

@interface WilltodoViewController ()

@end

@implementation WilltodoViewController

//重载init方法
- (instancetype)init
{
    if (self = [super initWithTagViewHeight:49])
    {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待办事项";
    //设置自定义属性
    self.selectedTitleColor = UIColorDJYThemecolorsRGB;
    self.selectedIndicatorColor = UIColorDJYThemecolorsRGB;
    self.selectedTitleFont = TextFontOfSizDefault;
    
    self.tagItemSize = CGSizeMake(Windows_WIDTH/3, 49);
    NSArray *titleArray = @[
                            @"当前",
                            @"联系过的",
                            @"我的举报",
                            ];
    
    NSArray *classNames = @[
                            [NowtodoViewController class],
                            [DoneRViewController class],
                            [ReportRViewController class],
                            ];
    
    NSArray *params = @[
                        @{@"123":@"XBParamImage"},
                        @{@"123":@"XBParamImage"},
                        @{@"123":@"XBParamImage"}
                        ];
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:params];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
