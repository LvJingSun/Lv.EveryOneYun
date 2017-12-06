//
//  DFTimeLineViewController.h
//  DFTimelineView
//
//  Created by Allen Zhong on 15/9/27.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseLineItem.h"

#import "DFLineLikeItem.h"
#import "DFLineCommentItem.h"

#import "DFBaseTimeLineViewController.h"
#import "CommentInputView.h"


@interface DFTimeLineViewController : DFBaseTimeLineViewController

-(void) addItem:(DFBaseLineItem *) item;

-(void) addLikeItem:(DFLineLikeItem *) likeItem itemId:(long long) itemId;

-(void) addCommentItem:(DFLineCommentItem *) commentItem itemId:(long long) itemId replyCommentId:(long long) replyCommentId;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableDictionary *itemDic;

@property (nonatomic, strong) NSMutableDictionary *commentDic;


@property (strong, nonatomic) CommentInputView *commentInputView;


@property (assign, nonatomic) long long currentItemId;

@end
