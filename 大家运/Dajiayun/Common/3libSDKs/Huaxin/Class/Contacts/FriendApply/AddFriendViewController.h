/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>

@interface AddFriendViewController : UITableViewController

//来自扫一扫，直接传入手机账号
@property (copy, nonatomic) NSString *ScanAddFriendPhone;

@property (copy, nonatomic) NSString *sendAddPhone;

@end
