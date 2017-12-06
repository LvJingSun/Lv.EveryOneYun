//
//  DetailHeadView.h
//  Dajiayun
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeadView : UIView

//头像
@property (nonatomic, weak) UIImageView *iconImageview;

//出发地
@property (nonatomic, weak) UILabel *fromPlace;

//目的地
@property (nonatomic, weak) UILabel *toPlace;

//车辆类型
@property (nonatomic, weak) UILabel *cheType;

//发布时间
@property (nonatomic, weak) UILabel *fabuTime;

@property (nonatomic, weak) UIButton *phoneBtn;

//期望费用
@property (nonatomic, weak) UILabel *expectPrice;

//途径城市
@property (nonatomic, weak) UILabel *citys;

//发车时间
@property (nonatomic, weak) UILabel *facheTime;

//联系电话
@property (nonatomic, weak) UILabel *phone;

//其他说明
@property (nonatomic, weak) UILabel *instructions;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UILabel *qita;

@property (nonatomic, weak) UIButton *zhankaiBtn;

@property (nonatomic, weak) UILabel *line3;

@property (nonatomic, assign) BOOL isOpen;

@end
