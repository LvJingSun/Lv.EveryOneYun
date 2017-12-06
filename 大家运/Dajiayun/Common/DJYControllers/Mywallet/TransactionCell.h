//
//  TransactionCell.h
//  Dajiayun
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TransactionCell : UITableViewCell

+ (instancetype)TransactionCellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UIImageView *imgImage;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *sourceLab;

@property (nonatomic, assign) CGFloat height;

@end
