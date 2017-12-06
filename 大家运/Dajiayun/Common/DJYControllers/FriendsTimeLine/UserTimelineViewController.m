//
//  UserTimelineViewController.m
//  DFTimelineView
//
//  Created by Allen Zhong on 15/10/15.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "UserTimelineViewController.h"
#import "DFTextImageUserLineItem.h"

@implementation UserTimelineViewController{
    
    NSInteger pageindex;
    NSString *UserfrontCover;
    Contact *Timelinemember;
    NSInteger TimelineUseId;

}

- (instancetype)initWithuserId:(NSUInteger)userId;
{
    self = [super init];
    if (self) {
        TimelineUseId = userId;
        Timelinemember = [ContactsDao queryDataMember:(int)userId];
        if (userId ==[[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID] intValue]) {
            self.title = @"相册";
        }else{
            self.title = Timelinemember.nickName;
        }
        
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    pageindex = 1;
    
    [self getMyDynamicListPublish];
    
//    [self setHeader];
    
}




-(void) setHeader
{

    [self setCover:UserfrontCover];
    
    NSString *picUrl = [NSString stringWithFormat:@"http://www.dajiayun.club%@",Timelinemember.photoMid];

    [self setUserAvatar:picUrl];
    
    [self setUserNick:Timelinemember.nickName];
    
//    [self setUserSign:@"梦想还是要有的 万一实现了呢"];
    
}


-(NSString *) getCoverUrl:(CGFloat) width height:(CGFloat) height
{
    return UserfrontCover;
}


-(NSString *) getAvatarUrl:(CGFloat) width height:(CGFloat) height
{
    return Timelinemember.photoMid;
}



-(NSString *) getUserNick
{
    return Timelinemember.nickName;
}


-(void) refresh
{
    pageindex = 1;
    [self getMyDynamicListPublish];

}


-(void) loadMore
{
    pageindex ++;
    [self getMyDynamicListPublish];

}

-(void) startRefresh
{
 
}

-(void) startloadMore
{
    
}

-(void)onClickItem:(DFBaseUserLineItem *)item
{
    NSLog(@"click item: %lld", item.itemId);
}


//*获取某好友动态*********************************************
- (void)getMyDynamicListPublish{
    NSDictionary *params = nil;
    if ([self.title isEqualToString:@"相册"]) {
        params= [NSDictionary dictionaryWithObjectsAndKeys:
                 [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                 [CachesDirectory getServerKey],@"key",
                 [NSString stringWithFormat:@"%ld",(long)pageindex],@"pageIndex",
                 @"10",@"pageSize",
                 nil];
    }else{
        params= [NSDictionary dictionaryWithObjectsAndKeys:
                 [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                 [CachesDirectory getServerKey],@"key",
                 [NSString stringWithFormat:@"%ld",(long)TimelineUseId],@"toMemberId",
                 [NSString stringWithFormat:@"%ld",(long)pageindex],@"pageIndex",
                 @"10",@"pageSize",
                 nil];
    }

    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:[self.title isEqualToString:@"相册"]==YES?
     @"DynamicWebService.asmx/MyDynamicList":@"DynamicWebService.asmx/OtherDynamicList" params:params networkBlock:^{
        [self stopload];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSArray *dynamicList = [responseObject valueForKey:@"dynamicList"];
            if ([dynamicList isKindOfClass:[NSArray class]]&&dynamicList.count!=0) {
                if (pageindex==1) {
                    [self.items removeAllObjects];
                    self.Friendsloadmore = 1;
                    NSString *frontCover = [responseObject valueForKey:@"frontCover"];
                    if (frontCover.length) {
                        UserfrontCover = frontCover;
                        Timelinemember.photoMid = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"photoBig"]];
                        [self getCoverUrl:0 height:0];
                        [self getAvatarUrl:0 height:0];
                        [self setHeader];
                    }
                }
            }else if ([dynamicList isKindOfClass:[NSArray class]]&&dynamicList.count==0){
                if (pageindex==1) {
                    [self.items removeAllObjects];
                }
                if (pageindex!=1) {
                    pageindex--;
                }
                [self.tableView reloadData];
            }
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                // 耗时的操作
                [self toDealwithdynamicList:dynamicList];
//            });
            [self stopload];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self stopload];
    }];
}


-(void)stopload{
    //模拟网络请求
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self endRefresh];
        [self endLoadMore];
    });
}


- (void)toDealwithdynamicList:(NSArray *)dynamicList{
    
    [dynamicList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull objdic, NSUInteger idx, BOOL * _Nonnull stop) {
        DFTextImageUserLineItem *item = [[DFTextImageUserLineItem alloc] init];
        item.itemId = [[NSString stringWithFormat:@"%@",objdic[@"dynamicId"]] longLongValue];
        NSString *time = [NSString stringWithFormat:@"%@",objdic[@"createDate"]];
        NSTimeInterval createDate =currentTimeWithDateString(GJCFDateFromStringByFormat(time, kNSDateHelperFormatSQLDateWithTimeXie));
        item.ts =createDate*1000;
        NSArray *picList =objdic[@"picList"];
        if ([picList isKindOfClass:[NSArray class]]&&picList.count!=0) {
            item.photoCount = picList.count;
            NSDictionary *picdic = [picList firstObject];
            item.cover = [NSString stringWithFormat:@"%@",picdic[@"pic"]];
        }
        item.text = [NSString stringWithFormat:@"%@",objdic[@"contents"]];
        [self addItem:item];
        
    }];
    
}


@end
