//
//  WuliuCell.h
//  Dajiayun
//
//  Created by mac on 16/6/15.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuliuCell : UITableViewCell

+ (instancetype)WuliuCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *cheIcon;

@property (nonatomic, weak) UILabel *fromPlace;

@property (nonatomic, weak) UILabel *citys;

@property (nonatomic, weak) UILabel *toPlace;

@property (nonatomic, weak) UILabel *time;

@property (nonatomic, weak) UIImageView *phone;

@property (nonatomic, weak) UIButton *phoneBtn;

@property (nonatomic, assign) CGFloat height;

@end
