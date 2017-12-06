//
//  XGConst.h
//  TaoBaoCopy
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 Dream. All rights reserved.
//

#ifndef XGConst_h
#define XGConst_h

#ifdef DEBUG
#define XGLog(...) NSLog(__VA_ARGS__)
#else
#define XGLog(...)
#endif

// 屏幕大小
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 导航条颜色
#define NAVCOlOR [UIColor colorWithRed:224/255. green:58/255.0 blue:27/255. alpha:1.f]

// 搜索框颜色
#define HOME_SEARCH_COLOR [UIColor colorWithRed:224/255. green:21/255.0 blue:27/255. alpha:0.8f]

// HomeHeard高度
#define HOME_HEARD_HIGHT SCREEN_HEIGHT * 0.15 + (((SCREEN_WIDTH - 60) * 0.2) * (129/183.) + 20) * 4 + 70

// 首页背景色
#define HOME_BACK_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]

// 搜索条字体
#define SEARCH_FONT [UIFont fontWithName:@"Helvetica" size:13]

// homeCelltitle字体
#define HOME_CELLTITLE_FONT [UIFont fontWithName:@"Helvetica" size:12]

// 更多字体
#define HOME_MORE_FONT [UIFont fontWithName:@"Helvetica" size:10]

// 登录URL username password keystr
#define LOGINURL @"http://10.0.9.123:8084/Phone_Service.asmx/userlogin"

#endif /* XGConst_h */
