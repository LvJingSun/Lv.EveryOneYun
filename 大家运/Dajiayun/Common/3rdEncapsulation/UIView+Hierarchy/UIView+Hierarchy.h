//
//  UIView+Hierarchy.h
//  MOT
//
//  Created by fenghq on 15/10/10.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//两个View之间切换Z轴

#import <Foundation/Foundation.h>

@interface UIView (Hierarchy)

-(int)getSubviewIndex;

-(void)bringToFront;
-(void)sendToBack;

-(void)bringOneLevelUp;
-(void)sendOneLevelDown;

-(BOOL)isInFront;
-(BOOL)isAtBack;

-(void)swapDepthsWithView:(UIView*)swapView;

@end
