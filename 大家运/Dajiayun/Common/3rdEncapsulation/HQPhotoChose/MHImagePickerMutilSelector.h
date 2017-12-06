//
//  MHMutilImagePickerViewController.h
//  doujiazi
//
//  Created by Shine.Yuan on 12-8-7.
//  Copyright (c) 2012年 mooho.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MHImagePickerMutilSelectorDelegate <NSObject>

@optional
-(void)imagePickerMutilSelectorDidGetImages:(NSArray*)imageArray;

@end

@interface MHImagePickerMutilSelector : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIView* selectedPan;
    UILabel* textlabel;
    UIImagePickerController*    imagePicker;
    NSMutableArray* pics;
    UITableView*    tbv;
    id<MHImagePickerMutilSelectorDelegate>  delegate;
}

@property (nonatomic,retain)UIImagePickerController*    imagePicker;
@property(nonatomic,retain)id<MHImagePickerMutilSelectorDelegate>   delegate;

+(id)standardSelector;


@property (nonatomic,strong) NSString *Allnum;//还能选择多少张；

@end
