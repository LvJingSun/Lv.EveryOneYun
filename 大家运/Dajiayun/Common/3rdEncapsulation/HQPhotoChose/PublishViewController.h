//
//  PublishViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-5-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HQBaseViewController.h"
#import "MHImagePickerMutilSelector.h"


@protocol Publishdelegate <NSObject>

- (void)Publishdelegate;//发表说说成功后返回需要刷新数据；
@end


@interface PublishViewController : HQBaseViewController<UITextViewDelegate,MHImagePickerMutilSelectorDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int pickerorphoto;
    
}


@property (nonatomic,strong) NSMutableDictionary    *ImageDic;

// 选择图片时候用于计算view的大小
@property (nonatomic, assign) BOOL                  isChoosePhoto;


@property (unsafe_unretained,nonatomic)id<Publishdelegate>publishdele;


@end
