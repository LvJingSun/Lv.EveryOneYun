//
//  TXrecordCell.m
//  Dajiayun
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "TXrecordCell.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation TXrecordCell

+ (instancetype)TXrecordCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"cellID";
    
    TXrecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[TXrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat nameX = size.width * 0.05;
        
        CGFloat nameY = 10;
        
        CGFloat nameW = size.width * 0.25;
        
        CGFloat nameH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
//        nameLab.backgroundColor = [UIColor grayColor];
        
        self.RealNameLabel = nameLab;
        
        [self addSubview:nameLab];
        
        CGFloat statusX = nameX;
        
        CGFloat statusY = CGRectGetMaxY(nameLab.frame) + 10;
        
        CGFloat statusW = nameW;
        
        CGFloat statusH = nameH;
        
        UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(statusX, statusY, statusW, statusH)];
        
//        statusLab.backgroundColor = [UIColor grayColor];
        
        self.StatusDesLabel = statusLab;
        
        [self addSubview:statusLab];
        
        CGFloat imageX = size.width * 0.35;
        
        CGFloat imageY = nameY;
        
        CGFloat imageW = size.width * 0.15;
        
        CGFloat imageH = 50;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
//        image.backgroundColor = [UIColor grayColor];
        
        self.TiXianTypeDesImageView = image;
        
        [self addSubview:image];
        
        CGFloat amountX = size.width * 0.7;
        
        CGFloat amountY = 20;
        
        CGFloat amountW = size.width * 0.25;
        
        CGFloat amountH = 30;
        
        UILabel *amountLab = [[UILabel alloc] initWithFrame:CGRectMake(amountX, amountY, amountW, amountH)];
        
//        amountLab.backgroundColor = [UIColor grayColor];
        
        self.AmountLabel = amountLab;
        
        [self addSubview:amountLab];
        
        self.height = 70;
        
    }
    
    return self;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
