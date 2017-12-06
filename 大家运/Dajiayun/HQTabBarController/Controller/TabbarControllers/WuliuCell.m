//
//  WuliuCell.m
//  Dajiayun
//
//  Created by mac on 16/6/15.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "WuliuCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation WuliuCell

+ (instancetype)WuliuCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"cellID";
    
    WuliuCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[WuliuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat lineX = Size.width * 0.03;
        
        CGFloat lineY = 0;
        
        CGFloat lineW = Size.width * 0.94;
        
        CGFloat lineH = 1;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        
        line.backgroundColor = [UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.];
        
        [self addSubview:line];
        
        UIImageView *cheIcon = [[UIImageView alloc] initWithFrame:CGRectMake(lineX, CGRectGetMaxY(line.frame) + 15, 40, 30)];
        
        self.cheIcon = cheIcon;
        
        cheIcon.image = [UIImage imageNamed:@"de_car.png"];
        
        [self addSubview:cheIcon];
        
        UILabel *from = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cheIcon.frame) + 5, CGRectGetMaxY(line.frame) + 4, (Size.width - 105) * 0.3, 15)];
        
        from.text = @"出发地";
        
        from.textColor = [UIColor lightGrayColor];
        
        from.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:from];
        
        UILabel *tujing = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(from.frame), CGRectGetMaxY(line.frame) + 4, (Size.width - 105) * 0.4, 15)];
        
        tujing.text = @"途径地";
        
        tujing.textColor = [UIColor lightGrayColor];
        
        tujing.font = from.font;
        
        tujing.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:tujing];
        
        UILabel *to = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tujing.frame), CGRectGetMaxY(line.frame) + 4, (Size.width - 105) * 0.3, 15)];
        
        to.text = @"目的地";
        
        to.textColor = [UIColor lightGrayColor];
        
        to.font = from.font;
        
        to.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:to];
        
        UILabel *toPlace = [[UILabel alloc] initWithFrame:CGRectMake(to.frame.origin.x, CGRectGetMaxY(to.frame) + 4, to.frame.size.width, 15)];
        
        toPlace.textColor = [UIColor colorWithRed:71/255. green:169/255. blue:102/255. alpha:1.];
        
        toPlace.text = @"上海";
        
        toPlace.textAlignment = NSTextAlignmentRight;
        
        toPlace.font = [UIFont systemFontOfSize:13];
        
        self.toPlace = toPlace;
        
        [self addSubview:toPlace];
        
        UILabel *citys = [[UILabel alloc] initWithFrame:CGRectMake(tujing.frame.origin.x, CGRectGetMaxY(tujing.frame) + 4, tujing.frame.size.width, 15)];
        
        citys.textAlignment = NSTextAlignmentCenter;
        
        citys.textColor = [UIColor darkGrayColor];
        
        citys.text = @"南昌-湖南-上海";
        
        citys.font = [UIFont systemFontOfSize:12];
        
        self.citys = citys;
        
        [self addSubview:citys];
        
        UILabel *fromPlace = [[UILabel alloc] initWithFrame:CGRectMake(from.frame.origin.x, CGRectGetMaxY(from.frame) + 4, from.frame.size.width, 15)];
        
        fromPlace.textColor = [UIColor colorWithRed:71/255. green:169/255. blue:102/255. alpha:1.];
        
        fromPlace.text = @"天津";
        
        fromPlace.font = [UIFont systemFontOfSize:13];
        
        self.fromPlace = fromPlace;
        
        [self addSubview:fromPlace];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cheIcon.frame) + 5, CGRectGetMaxY(fromPlace.frame) + 4, Size.width - 105, 15)];
        
        time.text = @"发车时间：2016-06-12 9:00";
        
        time.textColor = [UIColor lightGrayColor];
        
        time.font = [UIFont systemFontOfSize:11];
        
        self.time = time;
        
        [self addSubview:time];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(toPlace.frame) + 5, 15, 1, 30)];
        
        line2.backgroundColor = line.backgroundColor;
        
        [self addSubview:line2];
        
        UIImageView *phone = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame), line2.frame.origin.y, 30, 30)];
        
        phone.image = [UIImage imageNamed:@"de_phone.png"];
        
        [self addSubview:phone];
        
        UIButton *phoneBtn = [[UIButton alloc] initWithFrame:phone.frame];
        
        self.phoneBtn = phoneBtn;
        
        [self addSubview:phoneBtn];
        
        self.height = CGRectGetMaxY(cheIcon.frame) + 15;
        
        
    }
    
    return self;
    
}

@end
