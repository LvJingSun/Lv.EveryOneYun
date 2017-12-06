//
//  Contact.h
//  DataBaseContact
//
//  Created by lunarboat on 15/9/7.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Contact : NSObject

//@property (nonatomic,assign) int contactID;
//@property (nonatomic,retain) NSString *name;
//@property (nonatomic,retain) NSString *number;
@property (nonatomic,assign) int memberId;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *photoMid;

@end
