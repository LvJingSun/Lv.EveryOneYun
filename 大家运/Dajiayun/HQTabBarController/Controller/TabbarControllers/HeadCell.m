//
//  HeadCell.m
//  Dajiayun
//
//  Created by mac on 16/6/15.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "HeadCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation HeadCell

+ (instancetype)HeadCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"cellID";
    
    HeadCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat lineX = Size.width * 0.03;
        
        CGFloat lineY = 7;
        
        CGFloat lineW = 2;
        
        CGFloat lineH = 11;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        
        self.line = line;
        
        [self addSubview:line];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame) + 5, lineY, Size.width * 0.3, lineH)];
        
        self.title = title;
        
        title.textColor = [UIColor lightGrayColor];
        
        title.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:title];
        
        UIButton *more = [[UIButton alloc] initWithFrame:CGRectMake(Size.width * 0.75, lineY, Size.width * 0.2, lineH)];
        
        [more setTitleColor:[UIColor colorWithRed:71/255. green:169/255. blue:102/255. alpha:1.] forState:UIControlStateNormal];
        
        [more setTitle:@"查看更多" forState:UIControlStateNormal];
        
        more.titleLabel.font = [UIFont systemFontOfSize:13];
        
        self.moreBtn = more;
        
        [self addSubview:more];
        
        self.height = 25;

    }
    
    return self;
    
}

@end
