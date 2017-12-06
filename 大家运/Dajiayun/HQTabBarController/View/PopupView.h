//
//  PopupView.h
//  LewPopupViewController
//
//  Created by deng on 15/3/5.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol PoPUPViewDelegate <NSObject>
//
//- (void)CallBtnClick;
//
//@end

@interface PopupView : UIView
@property (nonatomic, strong)IBOutlet UIView *innerView;
@property (nonatomic, weak)UIViewController *parentVC;
//@property (nonatomic, assign) id<PoPUPViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *addFriendsBtn;
@property (weak, nonatomic) IBOutlet UIView *bjView;


+ (instancetype)defaultPopupView;
@end
