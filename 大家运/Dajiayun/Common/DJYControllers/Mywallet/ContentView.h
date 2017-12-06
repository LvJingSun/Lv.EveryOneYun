//
//  ContentView.h
//  Dajiayun
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView

@property (weak, nonatomic)  UILabel *Label1;
@property (weak, nonatomic)  UILabel *Label2;
@property (weak, nonatomic)  UILabel *Label3;
@property (weak, nonatomic)  UILabel *Label4;
@property (weak, nonatomic)  UILabel *Label5;
@property (weak, nonatomic)  UILabel *Label6;
@property (weak, nonatomic)  UILabel *Line1;
@property (weak, nonatomic)  UILabel *Line2;
@property (weak, nonatomic)  UILabel *Line3;
@property (weak, nonatomic)  UILabel *Line4;
@property (weak, nonatomic)  UITextField *type;
@property (weak, nonatomic)  UITextField *name;
@property (weak, nonatomic)  UITextField *kaihu;
@property (weak, nonatomic)  UITextField *count;

- (void)resignFirst;

@end
