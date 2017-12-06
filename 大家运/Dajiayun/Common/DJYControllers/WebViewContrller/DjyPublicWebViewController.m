//
//  DjyPublicWebViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/4/6.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "DjyPublicWebViewController.h"

@interface DjyPublicWebViewController ()
{
    UIWebView *M_webView;
    DjyPublicWebType M_webViewType;
}

@end

@implementation DjyPublicWebViewController

- (instancetype)initWithDjyPublicWebType:(DjyPublicWebType )Type
{
    self = [super init];
    if (self) {
        M_webViewType = Type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    M_webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSURL *url = [[NSURL alloc]initWithString:[self screeningType]];
    [M_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:M_webView];

}

- (NSString *)screeningType{
    NSString *Url = @"";
    switch (M_webViewType) {
        case about:
            Url = @"http://wap.dajiayun.club/about.aspx";
            self.title = @"关于我们";
            break;
        case helper:
            Url = @"http://wap.dajiayun.club/helper.aspx";
            self.title = @"帮助中心";
            break;
            
        default:
            break;
    }

    return Url;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    M_webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
