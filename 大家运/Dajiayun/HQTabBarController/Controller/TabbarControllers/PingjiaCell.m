//
//  PingjiaCell.m
//  Dajiayun
//
//  Created by mac on 16/6/15.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "PingjiaCell.h"
#import "StarsView.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation PingjiaCell

+ (instancetype)PingjiaCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"cellID";
    
    PingjiaCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[PingjiaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(lineX, CGRectGetMaxY(line.frame) + 5, 30, 30)];
        
        [self setLayer:icon];
        
        self.icon = icon;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 5, icon.frame.origin.y, Size.width * 0.5, icon.frame.size.height * 0.5)];
        
        name.textColor = [UIColor darkGrayColor];
        
        name.text = @"张三";
        
        name.font = [UIFont systemFontOfSize:13];
        
        self.name = name;
        
        [self addSubview:name];
        
        StarsView *star = [[StarsView alloc] initWithStarSize:CGSizeMake(10, 10) space:1.5 numberOfStar:5];
        
        star.score = 4.0;
        
        star.frame = CGRectMake(name.frame.origin.x, CGRectGetMaxY(name.frame) + 3, star.frame.size.width, star.frame.size.height);
        
        self.star = star;
        
        [self addSubview:star];
        
        UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(star.frame) + 5, CGRectGetMaxY(name.frame) + 3, Size.width * 0.1, icon.frame.size.height * 0.5)];
        
        score.text = @"4.5分";
        
        score.font = [UIFont systemFontOfSize:12];
        
        score.textColor = [UIColor colorWithRed:237/255. green:150/255. blue:124/255. alpha:1.];
        
        score.textAlignment = NSTextAlignmentCenter;
        
        self.score = score;
        
        [self addSubview:score];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(score.frame) + 5, CGRectGetMaxY(name.frame) + 3, Size.width * 0.3, icon.frame.size.height * 0.5)];
        
        time.textAlignment = NSTextAlignmentLeft;
        
        time.textColor = [UIColor lightGrayColor];
        
        time.font = [UIFont systemFontOfSize:12];
        
        time.text = @"2016-03-02";
        
        self.time = time;
        
        [self addSubview:time];
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(icon.frame.origin.x, CGRectGetMaxY(icon.frame) + 10, lineW, 20)];
        
        desc.textColor = [UIColor darkGrayColor];
        
        desc.font = [UIFont systemFontOfSize:14];
        
        desc.text = @"服务很好，价格很合理！";
        
        self.describe = desc;
        
        [self addSubview:desc];
        
        self.height = CGRectGetMaxY(desc.frame) + 5;
    }
    
    return self;
    
}

//设置头像圆形
-(void)setLayer:(UIView *)View {
    View.layer.masksToBounds = YES;
    View.layer.cornerRadius = View.frame.size.width/2; //圆角（圆形)
    //防止掉帧（列表不卡了）
    View.layer.shouldRasterize = YES;
    View.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
