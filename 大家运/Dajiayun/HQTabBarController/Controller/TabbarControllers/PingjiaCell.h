//
//  PingjiaCell.h
//  Dajiayun
//
//  Created by mac on 16/6/15.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarsView;

@interface PingjiaCell : UITableViewCell

+ (instancetype)PingjiaCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *icon;

@property (nonatomic, weak) UILabel *name;

@property (nonatomic, weak) StarsView *star;

@property (nonatomic, weak) UILabel *score;

@property (nonatomic, weak) UILabel *time;

@property (nonatomic, weak) UILabel *describe;

@property (nonatomic, assign) CGFloat height;

@end
