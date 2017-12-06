//
//  ConversationListController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//圈子

@interface ConversationListController : EaseConversationListViewController

- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;

-(void)selectTabbar:(UINavigationItem *)Item;

@property (strong, nonatomic) UIButton *FriendBtn;

@end
