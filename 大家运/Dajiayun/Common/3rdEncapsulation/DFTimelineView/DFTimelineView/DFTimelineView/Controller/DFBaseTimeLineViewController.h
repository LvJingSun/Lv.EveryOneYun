//
//  DFBaseTimeLineViewController.h
//  DFTimelineView
//
//  Created by Allen Zhong on 15/10/15.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//此文件夹被修改DFTime

#import "UIImageView+WebCache.h"
#import "MLLabel+Size.h"

#import "DFBaseViewController.h"


@interface DFBaseTimeLineViewController : DFBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSUInteger coverWidth;
@property (nonatomic, assign) NSUInteger coverHeight;
@property (nonatomic, assign) NSUInteger userAvatarSize;


@property (nonatomic, assign) NSUInteger Friendsloadmore;
//@property (nonatomic, assign) NSUInteger Usertimepageindex;


-(void) endLoadMore;

-(void) endRefresh;

-(void) onClickHeaderUserAvatar;


-(void) setCover:(NSString *) url;
-(void) setUserAvatar:(NSString *) url;
-(void) setUserNick:(NSString *)nick;
-(void) setUserSign:(NSString *)sign;


@end
