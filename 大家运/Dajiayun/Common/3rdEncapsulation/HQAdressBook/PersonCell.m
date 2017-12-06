//
//  PersonCell.m
//  BM
//
//  Created by yuhuajun on 15/7/13.
//  Copyright (c) 2015年 yuhuajun. All rights reserved.
//

#import "PersonCell.h"
#import "CDFInitialsAvatar.h"
@implementation PersonCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellviewbackground"]];
        
        _tximg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 40,40)];
        [self.contentView addSubview:_tximg];
        
        CDFInitialsAvatar *topAvatar = [[CDFInitialsAvatar alloc] initWithRect:_tximg.bounds fullName:@"家运"];
        topAvatar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tx_five"]];
        topAvatar.initialsFont=[UIFont fontWithName:@"STHeitiTC-Light" size:14];
        CALayer *mask = [CALayer layer]; // this will become a mask for UIImageView
        UIImage *maskImage = [UIImage imageNamed:@"AvatarMask"]; // circle, in this case
        mask.contents = (id)[maskImage CGImage];
        mask.frame = _tximg.bounds;
        _tximg.layer.mask = mask;
        //_tximg.layer.cornerRadius = YES;
        _tximg.image = topAvatar.imageRepresentation;
        _topAvatar=topAvatar;
        
        
        _txtName=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 160, 25)];
        _txtName.font=[UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_txtName];
        
        _phoneNum=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, 160, 25)];
        _phoneNum.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14];
        [self.contentView addSubview:_phoneNum];
        
        _actonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actonBtn.frame = CGRectMake(Windows_WIDTH-100, 12, 80, 35);
        [self.contentView addSubview:_actonBtn];
 
    }
    return self;
}

-(void)setTxcolorAndTitle:(NSString*)title:(NSString*)fid
{
    NSArray *tximgLis=@[@"tx_one",@"tx_two",@"tx_three",@"tx_four",@"tx_five"];
    NSString *strImg;
    if(fid.length!=0)//利用号码不同来随机颜色
    {
       NSString *strCarc= fid.length<7? [fid substringToIndex:fid.length]:[fid substringToIndex:7];
       int allnum=[strCarc intValue];
       strImg=tximgLis[allnum%5];
    }else
    {
      strImg=tximgLis[0];
    }
    if(title.length!=0)
    {
       title= title.length<2? [title substringToIndex:title.length]:[title substringToIndex:2];
    }else
    {
       title=@"家运";
    }
    
    CDFInitialsAvatar *topAvatar = [[CDFInitialsAvatar alloc] initWithRect:_tximg.bounds fullName:title];
    
    topAvatar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:strImg]];
    
    topAvatar.initialsFont=[UIFont fontWithName:@"STHeitiTC-Light" size:14];
    CALayer *mask = [CALayer layer]; // this will become a mask for UIImageView
    UIImage *maskImage = [UIImage imageNamed:@"AvatarMask"]; // circle, in this case
    mask.contents = (id)[maskImage CGImage];
    mask.frame = _tximg.bounds;
    _tximg.layer.mask = mask;
    _tximg.layer.cornerRadius = YES;
    _tximg.image = topAvatar.imageRepresentation;
    _topAvatar=topAvatar;
    
}
-(void)setData:(PersonModel*)personDel;
{
    _txtName.text=personDel.phonename;
    _phoneNum.text=personDel.tel;
    [self setTxcolorAndTitle:personDel.phonename:personDel.tel];

}

- (void)setactionBtn:(NSDictionary *)Contact{
//    1，是会员，不是好友，去添加 2，是会员，是好友，点击直接聊天3，不是会员，去邀请
    if ([Contact[@"Type"] isEqualToString:@"1"]) {
        _actonBtn.layer.borderColor = RGBColor(18, 146, 186).CGColor;
        [_actonBtn setTitleColor:RGBColor(18, 146, 186)forState:UIControlStateNormal];
        [_actonBtn setTitle:@"添加" forState:UIControlStateNormal];
    }else if ([Contact[@"Type"] isEqualToString:@"2"]){
        _actonBtn.layer.borderColor = UIColorDJYThemecolorsRGB.CGColor;
        [_actonBtn setTitleColor:UIColorDJYThemecolorsRGB forState:UIControlStateNormal];
        [_actonBtn setTitle:@"聊天" forState:UIControlStateNormal];
    }else if ([Contact[@"Type"] isEqualToString:@"3"]){
        _actonBtn.layer.borderColor = RGBColor(236, 193, 31).CGColor;
        [_actonBtn setTitleColor:RGBColor(236, 193, 31) forState:UIControlStateNormal];
        [_actonBtn setTitle:@"邀请" forState:UIControlStateNormal];
    }
    _actonBtn.layer.cornerRadius = 2;  // 将图层的边框设置为圆脚
    _actonBtn.layer.masksToBounds = YES; // 隐藏边界
    _actonBtn.layer.borderWidth = 1;  // 给图层添加一个有色边框
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
