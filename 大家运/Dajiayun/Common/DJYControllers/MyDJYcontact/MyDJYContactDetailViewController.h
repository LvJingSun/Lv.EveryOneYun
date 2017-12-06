//
//  MyDJYContactDetailViewController.h
//  Dajiayun
//
//  Created by fenghq on 16/3/30.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "BaseXLFormViewController.h"
@protocol delegate <NSObject>
-(void)ActionSuccess;
@end

@interface MyDJYContactDetailViewController : BaseXLFormViewController

- (instancetype)initXLtitle:(NSString *)Title anddic:(NSDictionary *)dic;

@property(nonatomic,assign)id <delegate> delegate;

@end
