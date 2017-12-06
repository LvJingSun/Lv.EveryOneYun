//
//  PopupView.m
//  LewPopupViewController
//
//  Created by deng on 15/3/5.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import "PopupView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"

@implementation PopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = frame;
        self.bjView.layer.cornerRadius = 5;
        self.callBtn.layer.cornerRadius = 3;
        self.addFriendsBtn.layer.cornerRadius = 3;
        self.detailsBtn.layer.cornerRadius = 3;
        [self addSubview:_innerView];
    }
    return self;
}


+ (instancetype)defaultPopupView{
    return [[PopupView alloc]initWithFrame:CGRectMake(0, 0, 200, 250)];
}

//- (IBAction)dismissAction:(id)sender{
//    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
//}
//
//- (IBAction)dismissViewFadeAction:(id)sender{
//    NSLog(@"拨打电话2");
//    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
//}
//
//
//- (IBAction)dismissViewSpringAction:(id)sender{
//    NSLog(@"拨打电话3");
//    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
//}


@end
