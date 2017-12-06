//
//  CompanyDetailController.m
//  Dajiayun
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "CompanyDetailController.h"

@interface CompanyDetailController ()

@property (nonatomic, weak) UIWebView *webview;

@end

@implementation CompanyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公司详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    self.webview = webview;
    
    [self.view addSubview:webview];

}

- (void)viewWillAppear:(BOOL)animated {
    
    NSString *string = [NSString stringWithFormat:@"%@",self.companyUrl];
    
//    NSString *string = [NSString stringWithFormat:@"[http://www.baidu.com]"];

    NSURL *url = [NSURL URLWithString:string];
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
