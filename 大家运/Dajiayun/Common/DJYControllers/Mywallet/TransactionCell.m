//
//  TransactionCell.m
//  Dajiayun
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "TransactionCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface TransactionCell ()



@end

@implementation TransactionCell

+ (instancetype)TransactionCellWithTableView:(UITableView *)tableView {

    static NSString *cellID = @"cellID";
    
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[TransactionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        UILabel *dateLab = [[UILabel alloc] init];
        
        dateLab.textAlignment = NSTextAlignmentCenter;
        
        self.dateLab = dateLab;
        
        CGFloat dateX = 0;
        
        CGFloat dateY = 20;
        
        CGFloat dateW = SCREEN_WIDTH * 0.2;
        
        CGFloat dateH = 20;
        
        dateLab.frame = CGRectMake(dateX, dateY, dateW, dateH);
        
        dateLab.font = [UIFont systemFontOfSize:13];
        
        dateLab.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:dateLab];
        
        
        UILabel *timeLab = [[UILabel alloc] init];
        
        timeLab.textAlignment = NSTextAlignmentCenter;
        
        timeLab.textColor = [UIColor grayColor];
        
        self.timeLab = timeLab;
        
        CGFloat timeX = 0;
        
        CGFloat timeY = 50;
        
        CGFloat timeW = SCREEN_WIDTH * 0.2;
        
        CGFloat timeH = dateH;
        
        timeLab.frame = CGRectMake(timeX, timeY, timeW, timeH);
        
        [self.contentView addSubview:timeLab];
        
        
        UIImageView *imgImage = [[UIImageView alloc] init];
        
        self.imgImage = imgImage;
        
        CGFloat imgX = CGRectGetMaxX(self.dateLab.frame) + 20;
        
        CGFloat imgY = 20;
        
        CGFloat imgW = 50;
        
        CGFloat imgH = 50;
        
        imgImage.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        [self.contentView addSubview:imgImage];
        
        
        UILabel *countLab = [[UILabel alloc] init];
        
        countLab.textAlignment = NSTextAlignmentLeft;
        
        self.countLab = countLab;
        
        CGFloat countX = CGRectGetMaxX(self.imgImage.frame) + 30;
        
        CGFloat countY = 20;
        
        CGFloat countW = SCREEN_WIDTH - countX;
        
        CGFloat countH = 20;
        
        countLab.frame = CGRectMake(countX, countY, countW, countH);
        
        [self.contentView addSubview:countLab];
        
        
        UILabel *sourceLab = [[UILabel alloc] init];
        
        sourceLab.textAlignment = NSTextAlignmentLeft;
        
        self.sourceLab = sourceLab;
        
        CGFloat sourceX = countX;
        
        CGFloat sourceY = 50;
        
        CGFloat sourceW = countW;
        
        CGFloat sourceH = countH;
        
        sourceLab.frame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
        
        sourceLab.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:sourceLab];
        
        self.height = CGRectGetMaxY(self.timeLab.frame) + 20;
        
    }
    
    return self;
    
}

//-(void)setFrameModel:(TransactionFrame *)frameModel {
//
//    _frameModel = frameModel;
//    
//    [self setRect];
//    
//    [self setContent];
//    
//}

//- (void)setRect{
//    
//    self.dateLab.frame = self.frameModel.dateF;
//    
//    self.timeLab.frame = self.frameModel.timeF;
//    
//    self.imgImage.frame = self.frameModel.imgF;
//    
//    self.countLab.frame = self.frameModel.countF;
//    
//    self.sourceLab.frame = self.frameModel.sourceF;
//    
//    [self.contentView addSubview:self.dateLab];
//    
//    [self.contentView addSubview:self.timeLab];
//    
//    [self.contentView addSubview:self.imgImage];
//    
//    [self.contentView addSubview:self.countLab];
//    
//    [self.contentView addSubview:self.sourceLab];
//
//    
//}
//
//- (void)setContent {
//    
//    Transaction *transaction = self.frameModel.transaction;
//    
//    self.dateLab.text = transaction.date;
//    
//    self.dateLab.textColor = [UIColor grayColor];
//    
//    self.timeLab.text = transaction.time;
//    
//    self.timeLab.textColor = [UIColor grayColor];
//    
//    self.imgImage.image = [UIImage imageNamed:transaction.img];
//    
//    self.countLab.text = transaction.count;
//    
//    if ([transaction.count intValue] > 0) {
//        
//        self.countLab.textColor = [UIColor colorWithRed:15./255 green:116./255 blue:29./255 alpha:1.];
//        
//    }else {
//    
//        self.countLab.textColor = [UIColor redColor];
//        
//    }
//    
//    self.sourceLab.text = transaction.source;
//    
//    self.sourceLab.textColor = [UIColor grayColor];
//
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
