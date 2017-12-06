//
//  WZLBadgeImport.h
//  WZLBadgeDemo
//
//  Created by zilin_weng on 15/8/10.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//


//  Only import this header file for your project is enough.
//  WZLBadge now supports badge for UIView, all subclasses of UIView and UIBarButtonItem Class.
/**
 *  
 小红点
 红底白字“new”
 红底白字数字
 为了让小红点显示后更加醒目，在这个版本中我又实现了三种不同的状态动画(status animation)：
 心脏跳动效果(WBadgeAnimTypeScale)
 呼吸灯效果(WBadgeAnimTypeBreathe)
 横向抖动(WBadgeAnimTypeShake)
 静止状态(WBadgeAnimTypeNone, 默认)
 还有以下优点：
 支持横竖屏
 支持iOS5+
 允许高度定制化，包括“红点”的背景颜色，文字(字体大小、颜色)，位置等
 */
#ifndef WZLBadgeDemo_WZLBadgeImport_h
#define WZLBadgeDemo_WZLBadgeImport_h

#import "UIView+WZLBadge.h"
#import "UIBarButtonItem+WZLBadge.h"
#import "UITabBarItem+WZLBadge.h"

#endif
