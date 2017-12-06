//
//  SPCChooseController.h
//  Dajiayun
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnDic)(NSString *cheInfo);

@interface SPCChooseController : UIViewController

@property (nonatomic, copy) ReturnDic cheInfo;

- (void)returnDic:(ReturnDic)block;

@end
