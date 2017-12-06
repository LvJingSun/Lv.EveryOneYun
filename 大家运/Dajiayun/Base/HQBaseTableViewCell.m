//
//  HQBaseTableViewCell.m
//  Dajiayun
//
//  Created by fenghq on 16/1/29.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "HQBaseTableViewCell.h"

@implementation HQBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updatamemberIndb:(Contact *)MemberInfo{
    if ([ContactsDao queryDataISMember:MemberInfo.memberId]) {
        [ContactsDao updateData:MemberInfo];
    }else{
        [ContactsDao insertData:MemberInfo];
    }
}
/**
 *  设置圆形
 *
 *  @param View 对像
 */
-(void)setLayerBorder:(UIView*)View andcornerRadius:(CGFloat)cornerRadius andborderWidth:(CGFloat)borderWidth andborderColor:(CGColorRef)CGColorRef;
{
    View.layer.cornerRadius = cornerRadius;  // 将图层的边框设置为圆脚
    View.layer.masksToBounds = YES; // 隐藏边界
    View.layer.borderWidth = borderWidth;  // 给图层添加一个有色边框
    View.layer.borderColor = CGColorRef;
}


/**
 *  设置圆形
 *
 *  @param View 对像
 */
-(void)setLayer:(UIView *)View andcornerRadius:(CGFloat)cornerRadius;{
    View.layer.masksToBounds = YES;
    View.layer.cornerRadius = cornerRadius; //圆角（圆形)
    //防止掉帧（列表不卡了）
    View.layer.shouldRasterize = YES;
    View.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

/**
 *  设置MLlabel基础属性
 *
 *  @param label MLlabel;
 */
-(void)setMLEmojiLabelBase:(MLEmojiLabel *)label {
    
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.backgroundColor = [UIColor clearColor];
    //下面是自定义表情正则和图像plist的例子
    label.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    label.customEmojiPlistName = @"customexpressionImage_custom";
    
}

/**
 *  颜色转换图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  根据文本输出高度
 *
 *  @param object 文本内容
 *  @param Width  文本显示的固定宽度
 *  @param Size   文本显示字体大小
 *
 *  @return 文本高度
 */
-(CGFloat)heightForLabelWithText:(NSString *)object andTextWidth:(CGFloat)Width andTextSize:(CGFloat)Sizee;
{
    CGSize textBlockMinSize = {Width, CGFLOAT_MAX};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    if (systemVersion >= 7.0) {
        size = [object boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Sizee]} context:nil].size;
    }else{
        size = [object sizeWithFont:[UIFont systemFontOfSize:Sizee] constrainedToSize:textBlockMinSize lineBreakMode:[self textLabelLineBreakModel]];
    }
    return  size.height;
}

-(NSLineBreakMode)textLabelLineBreakModel
{
    return NSLineBreakByCharWrapping;
}


/**
 * 存储数据
 */
- (void)CachesDirectoryImagePath:(NSString *)fileName data:(UIImage *)image;{
    NSData* imageData = UIImagePNGRepresentation(image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [imageData writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName] atomically:YES];
}
/**
 * 获取数据
 */
- (UIImage *)GetCachesDirectoryImagePath:(NSString *)fileName;{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *userinfo = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:userinfo];
    return image;
}

@end
