//
//  GoodsCarCell.h
//  Dajiayun
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsCarFrame;

@interface GoodsCarCell : UITableViewCell

+ (instancetype)GoodsCarCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) GoodsCarFrame *carFrame;

@end
