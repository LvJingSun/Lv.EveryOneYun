//
//  BzwPicker.h
//  PickerView
//
//  Created by Bao on 15/12/14.
//  Copyright © 2015年 Microlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Bzwdelegate <NSObject>

-(void)didSelete:(NSString *)pro andCity:(NSString *)city andTown:(NSString *)town;
-(void)didSelete:(NSString *)ShengId ShiId:(NSString *)city QuId:(NSString *)town;
-(void)pickerViewtitle:(NSString *)title ShengId:(NSString *)ShengId ShiId:(NSString *)ShiId QuId:(NSString *)QuId;
@end


@interface BzwPicker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    DBHelper *dbhelp;
}

@property(nonatomic,weak)id<Bzwdelegate>delegatee;

@property (strong,nonatomic)UIPickerView *pick;

@property (strong, nonatomic) NSMutableArray *selectedArray;//



@property (nonatomic, strong) NSMutableArray            *dataProvincesname;
@property (nonatomic, strong) NSMutableArray            *dataProvincescode;
@property (nonatomic, strong) NSMutableArray            *dataCityname;
@property (nonatomic, strong) NSMutableArray            *dataCitycode;
@property (nonatomic, strong) NSMutableArray            *dataAreaname;
@property (nonatomic, strong) NSMutableArray            *dataAreacode;


@property (strong,nonatomic)UIButton *leftBtn;//取消
@property (strong,nonatomic)UIButton *rightBtn;
@end
