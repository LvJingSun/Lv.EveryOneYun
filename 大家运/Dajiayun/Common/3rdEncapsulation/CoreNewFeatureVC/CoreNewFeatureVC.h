//
//  CoreNewFeatureVC.h
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//
// 启动画面（引导页）

#import <UIKit/UIKit.h>
#import "NewFeatureModel.h"


@interface CoreNewFeatureVC : UIViewController

@property (nonatomic,strong) NSArray *images;



/*
 *  初始化
 */
+(instancetype)newFeatureVCWithModels:(NSArray *)models enterBlock:(void(^)())enterBlock;



/*
 *  是否应该显示版本新特性界面
 */
+(BOOL)canShowNewFeature;




@end
