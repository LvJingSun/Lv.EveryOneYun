//
//  HQBaseTableViewCell.h
//  Dajiayun
//
//  Created by fenghq on 16/1/29.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQBaseTableViewCell : UITableViewCell{

    Contact *Member;

}

/**
 *  设置视图的圆角边框
 */
-(void)setLayerBorder:(UIView*)View andcornerRadius:(CGFloat)cornerRadius andborderWidth:(CGFloat)borderWidth andborderColor:(CGColorRef)CGColorRef;

/**
 *  设置圆角
 *
 *  @param View 对像
 */
-(void)setLayer:(UIView *)View andcornerRadius:(CGFloat)cornerRadius;

/**
 *  设置MLlabel基础属性
 *
 *  @param label MLlabel;
 */
-(void)setMLEmojiLabelBase:(MLEmojiLabel *)label;

/**
 *  颜色转换图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
- (UIImage*)createImageWithColor: (UIColor*) color;

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

/**
 * 更新本地好友信息
  */
- (void)updatamemberIndb:(Contact *)MemberInfo;

/**
 * 存储数据
 */
- (void)CachesDirectoryImagePath:(NSString *)fileName data:(UIImage *)image;
/**
 * 获取数据
 */
- (UIImage *)GetCachesDirectoryImagePath:(NSString *)fileName;

@end
