//
//  ChooseCarController.h
//  Dajiayun
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnCarName)(NSString *carName1, NSString *image);

@interface ChooseCarController : UIViewController

@property (nonatomic, copy) ReturnCarName carName1;

- (void)returnCarName:(ReturnCarName)block;

@end
