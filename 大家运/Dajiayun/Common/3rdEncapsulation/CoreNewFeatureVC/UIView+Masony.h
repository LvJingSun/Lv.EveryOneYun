//
//  UIView+Masony.h
//  Carpenter

#import <UIKit/UIKit.h>

@interface UIView (Masony)



/**
 *  视图添加约束，使之和父控件一样大
 *
 *  @param insets insets
 */
-(void)masViewAddConstraintMakeEqualSuperViewWithInsets:(UIEdgeInsets)insets;




@end
