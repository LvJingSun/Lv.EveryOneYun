//
//  DatePickerView.m
//  Friday
//
//  Created by mac-mini-ios on 15/7/23.
//  Copyright (c) 2015年 xtuone. All rights reserved.
//
#define LimitDay 30

#import "DatePickerView.h"
#import "UIColor+K1Util.h"
@interface DatePickerView ()
#pragma mark - IBActions
@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;/**< 时间picker*/

@end

@implementation DatePickerView
{
    NSArray *_amPmArray;/**< 上下午选择数组*/
    NSMutableArray *_monthAndDayArray;/**< 月份日期数组*/
    NSMutableArray *_yearAndMonthAndDayArr;/**< 年月日数组*/

    NSInteger dateindex;
    NSInteger amorpmindex;

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _monthAndDayArray = [[NSMutableArray alloc]initWithCapacity:0];

    [self getdateLimitDay];
}

#pragma mark - UIPickerViewDelegate
//已经选择了某个区地某一行(通常用来刷新界面时调用此方法)
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        dateindex = row;
    }else if (component==1){
    
    }else if (component==2){
        amorpmindex = row;

    }
    self.datePickerText = [NSString stringWithFormat:@"%@ %@",_monthAndDayArray[dateindex],_amPmArray[amorpmindex]];
}

#pragma mark - UIPickerViewDatasource
//返回picker每个区每一行的内容
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    // Custom View created for each component
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil)
    {
        CGRect frame = CGRectMake(0.0, 0.0, 110.0, 44.0);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor colorWithHexString:@"#666666"]];
        [pickerLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [pickerLabel setBackgroundColor:[UIColor colorWithHexString:@"#00000000"]];
    }
    if (component == 0)//第一行
    {
        pickerLabel.text = [_monthAndDayArray objectAtIndex:row];
    }
    else if (component == 2)//第三行
    {
        pickerLabel.text = [_amPmArray objectAtIndex:row];
    }
    else//第二行
    {
        pickerLabel.text = @"";
        pickerLabel.frame = CGRectMake(0.0, 0.0, 5.0, 44.0);
    }
    return pickerLabel;
}

//返回行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;//此处写三行,才能让picker上下滑动的字没有那么参差
}

// returns the # of rows in each component..
//每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)//第一行
    {
        return LimitDay;
    }
    else if(component == 1)//第二行,特殊处理
    {
        return 0;
    }
    else//第三行
    {
        return 2;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 1 )
    {
        return 0;//第二行的存在意义完全是为了调节另两行显示
    }
    else
    {
        return 110;
    }
}

-(void)getdateLimitDay{
    _amPmArray = @[@"上午",@"下午"];
    [_monthAndDayArray removeAllObjects];
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    for (int i=0; i<LimitDay; i++) {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*i ];
        NSString *datestring = GJCFDateToStringByFormat(theDate, kNSDateHelperFormatSQLDate);
        [_monthAndDayArray addObject:datestring];
    }
    self.datePickerText = [NSString stringWithFormat:@"%@%@",_monthAndDayArray[0],_amPmArray[0]];
}

@end
