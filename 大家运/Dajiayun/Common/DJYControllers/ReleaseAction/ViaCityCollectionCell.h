//
//  ViaCityCollectionCell.h
//  Dajiayun
//
//  Created by CityAndCity on 16/1/31.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViaCityCollectionCell;

@protocol ZXCollectionCellDelegate <NSObject>

-(void)moveImageBtnClick:(ViaCityCollectionCell *)aCell;


@end

@interface ViaCityCollectionCell : UICollectionViewCell
@property(nonatomic ,strong)UIImageView *imgView;
@property (strong, nonatomic) UITextField *tuJingChengShiUITextField;
@property(nonatomic,strong)UIButton * close;
@property(nonatomic,assign)id<ZXCollectionCellDelegate>delegate;

@end
