//
//  TXrecordCell.h
//  Dajiayun
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXrecordCell : UITableViewCell

+ (instancetype)TXrecordCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *RealNameLabel;

//@property (nonatomic, weak) UILabel *TiXianTypeDesLabel;

@property (nonatomic, weak) UIImageView *TiXianTypeDesImageView;

@property (nonatomic, weak) UILabel *StatusDesLabel;

@property (nonatomic, weak) UILabel *AmountLabel;

@property (nonatomic, assign) CGFloat height;

@end
