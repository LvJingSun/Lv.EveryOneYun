//
//  BzwPicker.m
//  PickerView
//
//  Created by Bao on 15/12/14.
//  Copyright © 2015年 Microlink. All rights reserved.
//

#import "BzwPicker.h"

@implementation BzwPicker



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dataProvincesname = [[NSMutableArray alloc]initWithCapacity:0];
        self.dataProvincescode = [[NSMutableArray alloc]initWithCapacity:0];
        self.dataCityname = [[NSMutableArray alloc]initWithCapacity:0];
        self.dataCitycode = [[NSMutableArray alloc]initWithCapacity:0];
        self.dataAreaname = [[NSMutableArray alloc]initWithCapacity:0];
        self.dataAreacode = [[NSMutableArray alloc]initWithCapacity:0];
        [self makeui];
    }
    return self;
}
-(void)makeui
{
    dbhelp = [[DBHelper alloc]init];
    [self loadcityandadre];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 46, 40);
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:UIColorDJYThemecolorsRGB forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    self.leftBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;

    [view addSubview:self.leftBtn];
    
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(view.frame.size.width-46,0, 46, 40);
    [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:UIColorDJYThemecolorsRGB forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    self.rightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;

    [view addSubview:self.rightBtn];
    
    self.pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 150)];
    self.pick.delegate = self;
    self.pick.dataSource = self;
    self.pick.showsSelectionIndicator=YES;
    [self addSubview:self.pick];


    //省  市
    self.selectedArray = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",nil];
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.delegatee pickerViewtitle:[NSString stringWithFormat:@"%@,%@,%@",[self.dataProvincesname firstObject],[self.dataCityname firstObject],[self.dataAreaname firstObject]] ShengId:[self.dataProvincescode firstObject] ShiId:[self.dataCitycode firstObject] QuId:[self.dataAreacode firstObject]];
    });

    
}

#pragma 获取城市
- (void)loadcityandadre{
    [self loadProvinces];
    [self loadCity:0];
    [self loadArea:0];
}

-(void)loadProvinces
{
    NSArray *city = [dbhelp queryCityDJYParentId:@"0"];
    [self.dataProvincesname removeAllObjects];
    [self.dataProvincescode removeAllObjects];
    [city enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataProvincesname addObject:[obj objectForKey:@"name"]];
        [self.dataProvincescode addObject:[obj objectForKey:@"code"]];
    }];
}

-(void)loadCity:(NSInteger)Indexpath;
{
    if (self.dataProvincescode.count) {
        NSString *code = [self.dataProvincescode objectAtIndex:Indexpath];
        NSArray *Area = [dbhelp queryCityDJYParentId:code];
        [self.dataCityname removeAllObjects];
        [self.dataCitycode removeAllObjects];
        [self.dataAreaname removeAllObjects];
        [self.dataAreacode removeAllObjects];
        [Area enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataCityname addObject:[obj objectForKey:@"name"]];
            [self.dataCitycode addObject:[obj objectForKey:@"code"]];
        }];
    }
}

-(void)loadArea:(NSInteger)Indexpath;
{
    if (self.dataCitycode.count) {
        NSString *code = [self.dataCitycode objectAtIndex:Indexpath];
        NSArray *Area = [dbhelp queryCityDJYParentId:code];
        [self.dataAreaname removeAllObjects];
        [self.dataAreacode removeAllObjects];
        [Area enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataAreaname addObject:[obj objectForKey:@"name"]];
            [self.dataAreacode addObject:[obj objectForKey:@"code"]];
        }];
    }
    
}


//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.dataProvincesname.count;
    } else if (component == 1) {
        return self.dataCityname.count;
    } else {
        return self.dataAreaname.count;
    }

}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.dataProvincesname objectAtIndex:row];
    } else if (component == 1) {
        return [self.dataCityname objectAtIndex:row];
    } else {
        return [self.dataAreaname objectAtIndex:row];
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width/3;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0)
    {
        [self.selectedArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",(long)row]];
        [self.selectedArray replaceObjectAtIndex:1 withObject:@"0"];
        [self.selectedArray replaceObjectAtIndex:2 withObject:@"0"];
        [self loadCity:row];
        [self loadArea:0];
    }else if (component == 1)
    {
        [self.selectedArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",(long)row]];
        [self.selectedArray replaceObjectAtIndex:2 withObject:@"0"];
        [self loadArea:row];
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }else{
        [self.selectedArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",(long)row]];
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    [pickerView reloadComponent:2];
    
    NSString *pro = self.dataProvincesname.count?[self.dataProvincesname objectAtIndex:[[self.selectedArray objectAtIndex:0] integerValue]]:@"";
    NSString *cit = self.dataCityname.count?[self.dataCityname objectAtIndex:[[self.selectedArray objectAtIndex:1] integerValue]]:@"";
    NSString *are = self.dataAreaname.count?[self.dataAreaname objectAtIndex:[[self.selectedArray objectAtIndex:2] integerValue]]:@"";

    [self.delegatee didSelete:pro andCity:cit andTown:are];
    
    NSString *ShengId = self.dataProvincescode.count?[self.dataProvincescode objectAtIndex:[[self.selectedArray objectAtIndex:0] integerValue]]:@"";
    NSString *ShiId = self.dataCitycode.count?[self.dataCitycode objectAtIndex:[[self.selectedArray objectAtIndex:1] integerValue]]:@"";
    NSString *QuId = self.dataAreacode.count?[self.dataAreacode objectAtIndex:[[self.selectedArray objectAtIndex:2] integerValue]]:@"";
    
    [self.delegatee didSelete:ShengId ShiId:ShiId QuId:QuId];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
