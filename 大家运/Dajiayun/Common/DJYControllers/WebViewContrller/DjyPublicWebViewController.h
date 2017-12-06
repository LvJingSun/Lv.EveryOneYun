//
//  DjyPublicWebViewController.h
//  Dajiayun
//
//  Created by fenghq on 16/4/6.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "HQBaseViewController.h"
/*
 *  反转方向
 */
typedef enum {
    
    //关于我们：
    about=0,
    
    //帮助中心
    helper,
    
    
}DjyPublicWebType;

@interface DjyPublicWebViewController : HQBaseViewController

- (instancetype)initWithDjyPublicWebType:(DjyPublicWebType )Type;

@end
