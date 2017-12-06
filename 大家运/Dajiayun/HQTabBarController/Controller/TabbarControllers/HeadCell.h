//
//  HeadCell.h
//  Dajiayun
//
//  Created by mac on 16/6/15.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadCell : UITableViewCell

+ (instancetype)HeadCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *line;

@property (nonatomic, weak) UILabel *title;

@property (nonatomic, weak) UIButton *moreBtn;

@property (nonatomic, assign) CGFloat height;

@end
