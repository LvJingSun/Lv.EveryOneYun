//
//  MyReleasesViewControllers.m
//  Dajiayun
//
//  Created by fenghq on 16/1/29.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "MyReleasesViewControllers.h"
#import "MyReleaseProViewController.h"
#import "MyReleaseWLViewController.h"
#import "MyReleaseJYViewController.h"

@interface MyReleasesViewControllers ()

@end
@implementation MyReleasesViewControllers

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
    self.title = @"我的发布";
    //设置自定义属性
    self.selectedTitleColor = UIColorDJYThemecolorsRGB;
    self.selectedIndicatorColor = UIColorDJYThemecolorsRGB;
    self.selectedTitleFont = TextFontOfSizDefault;
    
    self.tagItemSize = CGSizeMake(Windows_WIDTH/3, 49);
    NSArray *titleArray = @[
                   @"物流车",
                   @"商品车",
                   @"救援车",
                   ];
    
    NSArray *classNames = @[
                            [MyReleaseWLViewController class],
                            [MyReleaseProViewController class],
                            [MyReleaseJYViewController class],
                            ];
    
    NSArray *params = @[@{@"MyReleaseWLViewController":@"XBParamImage"},
                        @{@"MyReleaseProViewController":@"XBParamImage"},
                        @{@"MyReleaseJYViewController":@"XBParamImage"}
                        ];
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:params];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
