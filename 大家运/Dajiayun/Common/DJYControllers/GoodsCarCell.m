//
//  GoodsCarCell.m
//  Dajiayun
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "GoodsCarCell.h"
#import "GoodsCar.h"
#import "GoodsCarFrame.h"

@interface GoodsCarCell ()

@property (nonatomic, weak) UIImageView *picImage;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *priceLab;

@property (nonatomic, weak) UILabel *timeLab;

@end

@implementation GoodsCarCell

+ (instancetype)GoodsCarCellWithTableView:(UITableView *)tableView {

    static NSString *cellID = @"cellID";
    
    GoodsCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GoodsCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *picImage = [[UIImageView alloc] init];
        
        self.picImage = picImage;
        
        [self.contentView addSubview:picImage];
        
        UILabel *nameLab = [[UILabel alloc] init];
        
        self.nameLab = nameLab;
        
        [self.contentView addSubview:nameLab];
        
        UILabel *priceLab = [[UILabel alloc] init];
        
        self.priceLab = priceLab;
        
        [self.contentView addSubview:priceLab];
        
        UILabel *timeLab = [[UILabel alloc] init];
        
        self.timeLab = timeLab;
        
        [self.contentView addSubview:timeLab];
        
    }
    
    return self;
    
}

-(void)setCarFrame:(GoodsCarFrame *)carFrame {

    _carFrame = carFrame;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.picImage.frame = self.carFrame.picF;
    
    self.nameLab.frame = self.carFrame.nameF;
    
    self.priceLab.frame = self.carFrame.priceF;
    
    self.timeLab.frame = self.carFrame.timeF;
    
    [self.contentView addSubview:self.picImage];
    
    [self.contentView addSubview:self.nameLab];
    
    [self.contentView addSubview:self.priceLab];
    
    [self.contentView addSubview:self.timeLab];
    
}

- (void)setContent {

    GoodsCar *goodsCar = self.carFrame.goodsCar;
    
    CALayer *layer = self.picImage.layer;
    
    [layer setMasksToBounds:YES];
    
    [layer setCornerRadius:5.0];
    
    self.picImage.image = [UIImage imageNamed:goodsCar.pic];
    
    self.nameLab.text = goodsCar.name;
    
    self.nameLab.font = [UIFont systemFontOfSize:15];
    
    self.priceLab.text = [NSString stringWithFormat:@"车牌：%@",goodsCar.price];
    
    self.priceLab.font = [UIFont systemFontOfSize:11];
    
    self.priceLab.textColor = [UIColor orangeColor];
    
    self.timeLab.text = [NSString stringWithFormat:@"已使用：%@",goodsCar.time];
    
    self.timeLab.font = [UIFont systemFontOfSize:10];
    
    self.timeLab.textColor = [UIColor grayColor];
    
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
