//  DFTimelineView
//
//  Created by Allen Zhong on 15/9/27.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//
#warning DFTime修改过的地方
//DFLikeCommentToolbar
//DFTimelineView-Controller下三个类
//DFBaseLineCell
//DFTextImageUserLineItem

#import "FriendsTimeLineViewController.h"
#import "DFTextImageLineItem.h"
#import "DFLineLikeItem.h"
#import "DFLineCommentItem.h"
#import "UserTimelineViewController.h"
#import "PublishViewController.h"

@interface FriendsTimeLineViewController()<Publishdelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSInteger pageindex;
    UIButton *shareBtn;
    
    NSInteger pickerorphoto;
    UIButton *AddDynamicConfig;
    
    NSInteger delitem;
}

@property (nonatomic,strong)NSMutableArray *dataArr;
// 用于临时存储用户更换背景图片的字典
@property (nonatomic, strong) NSMutableDictionary   *m_imageDic;

@end

@implementation FriendsTimeLineViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
        self.m_imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流圈";
    [self rightBarButtonItem];
    [self rightAction];
    pageindex = 1;
    [self getDynamicPublish];
    [self setHeader:@""];
    [AddDynamicConfig sendToBack];
    [AddDynamicConfig bringOneLevelUp];

    [self setshareBtn];
}

-(void)setshareBtn{
    if (!shareBtn) {
    shareBtn = [UIButton buttonWithType:0];
    shareBtn.hidden = YES;
    shareBtn.frame = CGRectMake(20, 290*([UIScreen mainScreen].bounds.size.width / 375.0)+10 , Windows_WIDTH-40, 40);
    [shareBtn setTitle:@"发布动态" forState:0];
    shareBtn.backgroundColor = UIColorDJYThemecolorsRGB;
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius = 5.0;
    shareBtn.clipsToBounds = YES;
    [shareBtn addTarget:self action:@selector(onAddAlbumButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:shareBtn];
    }
}

- (void)rightAction {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 44, 44)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(onAddAlbumButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem =_addFriendItem;
}

-(void)onAddAlbumButtonClicked{
    PublishViewController *VC = [[PublishViewController alloc] initWithNibName:@"PublishViewController" bundle:nil];
    
    VC.publishdele = self;
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)Publishdelegate;
{
    [self refresh];
    
}

-(void) setHeader:(NSString *)frontCover
{
    AddDynamicConfig = [UIButton buttonWithType:UIButtonTypeCustom];
    [AddDynamicConfig setFrame:CGRectMake(0, 0, Windows_WIDTH, (290*([UIScreen mainScreen].bounds.size.width / 375.0))-(70*([UIScreen mainScreen].bounds.size.width / 375.0)))];
    AddDynamicConfig.backgroundColor = [UIColor clearColor];
    [AddDynamicConfig addTarget:self action:@selector(headimageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView.tableHeaderView addSubview:AddDynamicConfig];

    NSString *coverUrl = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_FrontCover];

    if (frontCover.length) {
        coverUrl = frontCover;
        [CachesDirectory addValue:frontCover andKey:CachesDirectory_MemberInfo_FrontCover];
    }
    [self setCover:coverUrl];
    
    [self setUserAvatar:[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_PhotoMid]];
    
    [self setUserNick:[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName]];
    
//    [self setUserSign:@"梦想还是要有的 万一实现了呢"];
    
}
//举报
-(void) onReport:(long long)itemId;
{
    MMPopupItemHandler block = ^(NSInteger index){
        [self requestJubaoSubmit];
    };
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finish){
    };
    NSArray *items =
    @[MMItemMake(@"广告信息", MMItemTypeNormal, block),
      MMItemMake(@"诈骗信息", MMItemTypeNormal, block),
      MMItemMake(@"造谣诽谤信息", MMItemTypeNormal, block),
      MMItemMake(@"色情暴力信息", MMItemTypeNormal, block)];
    [[[MMSheetView alloc] initWithTitle:@"我要举报"
                                  items:items] showWithBlock:completeBlock];
    
}

//评论
-(void)onCommentCreate:(long long)commentId text:(NSString *)text itemId:(long long) itemId
{
    [self requestonCommentCreate:[NSString stringWithFormat:@"%lld",itemId] toMemberId:[NSString stringWithFormat:@"%lld",commentId] contents:text];
}

//点赞
-(void)onLike:(long long)itemId
{
    [self requestonLike:[NSString stringWithFormat:@"%lld",itemId]];
    
}

//点头像
-(void)onClickUser:(NSUInteger)userId
{
    //点击左边头像 或者 点击评论和赞的用户昵称
    UserTimelineViewController *controller = [[UserTimelineViewController alloc] initWithuserId:userId];
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)onClickHeaderUserAvatar
{
    [self onClickUser:[[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID] intValue]];
}

//删除某个动态
-(void) DelDFTextImageLineItem:(NSUInteger) itempath Row:(NSInteger )Row;
{
    MMPopupItemHandler block = ^(NSInteger index){

        if (index) {
            [self requestDelDFTextImageLine:[NSString stringWithFormat:@"%lu",(unsigned long)itempath] Row:Row];
        }
    };
    NSArray *items =
    @[MMItemMake(@"取消", MMItemTypeNormal, block),
      MMItemMake(@"删除", MMItemTypeNormal, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"确定删除？"
                                                         detail:nil
                                                          items:items];
    [alertView show];

}

- (void)requestDelDFTextImageLine:(NSString *)dynamicId Row:(NSInteger )Row{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID], @"memberId",
                            [CachesDirectory getServerKey],@"key",
                            dynamicId, @"dynamicId",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DynamicWebService.asmx/DeleteDynamic" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {

        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            delitem = Row;
            [self refresh];

        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
    }];
    
}


-(void) refresh
{
    //下来刷新
    //模拟网络请求
    pageindex=1;
    //加载更多
    [self getDynamicPublish];
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self endRefresh];
    });
}



-(void) loadMore
{
    //加载更多
    pageindex++;
    //加载更多
    [self getDynamicPublish];
}


//-(void)loadpage1{
//    pageindex=1;
//    //加载更多
//    [self getDynamicPublish];
//}
//
//-(void)loadpagejia{
//    pageindex++;
//    //加载更多
//    [self getDynamicPublish];
//}
//
//
//- (void)example01
//{
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadpage1)];
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    header.automaticallyChangeAlpha = YES;
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    // 马上进入刷新状态
//    [header beginRefreshing];
//    // 设置header
//    self.tableView.header = header;
//}
//
//#pragma mark UITableView + 上拉刷新 默认
//- (void)example11
//{
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadpagejia)];
//    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
//    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
//    // 隐藏刷新状态的文字
//    footer.refreshingTitleHidden = YES;
//    // 设置footer
//    self.tableView.footer = footer;
//}


-(void)stopload{
    //模拟网络请求
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self endRefresh];
        [self endLoadMore];
//        pageindex==1?[self endRefresh]:[self endLoadMore];
        delitem = 0;
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


//*获取物流圈好友动态*********************************************
- (void)getDynamicPublish{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            @"0",@"longitude",
                            @"0",@"latitude",
                            [NSString stringWithFormat:@"%ld",(long)pageindex],@"pageIndex",
                            @"10",@"pageSize",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DynamicWebService.asmx/DynamicList" params:params networkBlock:^{
        
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            NSArray *dynamicList = [responseObject valueForKey:@"dynamicList"];
            if ([dynamicList isKindOfClass:[NSArray class]]&&dynamicList.count!=0) {
                if (pageindex==1) {
                    [self.items removeAllObjects];
                    [self.dataArr removeAllObjects];
                    self.Friendsloadmore = 1;
                    NSString *frontCover = [responseObject valueForKey:@"frontCover"];
                    if (frontCover.length) {
                        [self setHeader:frontCover];
                    }
                }
                shareBtn.hidden = YES;
            }else if ([dynamicList isKindOfClass:[NSArray class]]&&dynamicList.count==0){
                if (pageindex==1) {
                    [self.items removeAllObjects];
                    [self.dataArr removeAllObjects];
                    shareBtn.hidden = NO;
                }
                if (pageindex!=1) {
                    pageindex--;
                }
                [self.tableView reloadData];
            }

            [self toDealwithdynamicList:dynamicList];
            [self stopload];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self stopload];
    }];
}

- (void)toDealwithdynamicList:(NSArray *)dynamicList{
    [self.dataArr addObjectsFromArray:dynamicList];
    [dynamicList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *picList = [obj objectForKey:@"picList"];
        
        DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
        textImageItem.itemId = [[obj objectForKey:@"dynamicId"] integerValue];
        textImageItem.itemType = LineItemTypeTextImage;
        textImageItem.userId = [[obj objectForKey:@"memberId"] integerValue];
        textImageItem.userAvatar = [obj objectForKey:@"photoBig"];
        textImageItem.userNick = [obj objectForKey:@"nickName"];
        textImageItem.text = [obj objectForKey:@"contents"];
        textImageItem.IndexPathRow = idx;
        
        Contact* Member = [[Contact alloc]init];
        Member.nickName = textImageItem.userNick;
        Member.photoMid = textImageItem.userAvatar;
        [self updatamemberIndb:Member];
        
        NSMutableArray *Mpic = [[NSMutableArray alloc]initWithArray:[self toDealwithpicList:picList]];
        textImageItem.srcImages = Mpic;
        textImageItem.thumbImages = Mpic;
        if (Mpic.count==1) {
            textImageItem.width = 640;
            textImageItem.height = 360;
        }
        
        // textImageItem.location = @"地址:中国 • 广州";
        NSTimeInterval xietime =currentTimeWithDateString(GJCFDateFromStringByFormat([obj objectForKey:@"createDate"], kNSDateHelperFormatSQLDateWithTimeXie));
        textImageItem.ts =xietime*1000;
        
        //赞
        NSArray *zanList = [obj objectForKey:@"zanList"];
        if (zanList.count&&[zanList isKindOfClass:[NSArray class]]) {
            [zanList enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull zanListobj, NSUInteger idx, BOOL * _Nonnull stop) {
                DFLineLikeItem *likeItem = [[DFLineLikeItem alloc] init];
                likeItem.userId = [[zanListobj objectForKey:@"memberId"] integerValue];
                likeItem.userNick = [zanListobj objectForKey:@"nickName"];
                [textImageItem.likes addObject:likeItem];
            }];

        }
        //显示评论/回复
        NSArray *huifuList = [obj objectForKey:@"huifuList"];
        if (huifuList.count&&[huifuList isKindOfClass:[NSArray class]]) {
            [huifuList enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull huifuListobj, NSUInteger idx, BOOL * _Nonnull stop) {
                DFLineCommentItem *commentItem = [[DFLineCommentItem alloc] init];
                //评论
                if ([[NSString stringWithFormat:@"%@",[huifuListobj objectForKey:@"nickName2"]] isEqualToString:@"(null)"]) {
                    commentItem.commentId = [[huifuListobj objectForKey:@"memberId"] integerValue];
                    commentItem.userId = [[huifuListobj objectForKey:@"memberId"] integerValue];
                    commentItem.userNick = [huifuListobj objectForKey:@"nickName"];
                    commentItem.text = [huifuListobj objectForKey:@"contents"];
                }else{
                    //回复
                    commentItem.commentId = [[huifuListobj objectForKey:@"memberId"] integerValue];
                    commentItem.userId = [[huifuListobj objectForKey:@"memberId"] integerValue];
                    commentItem.userNick = [huifuListobj objectForKey:@"nickName"];
                    commentItem.text = [huifuListobj objectForKey:@"contents"];
                    commentItem.replyUserId = [[huifuListobj objectForKey:@"toMemberId"] integerValue];
                    commentItem.replyUserNick = [huifuListobj objectForKey:@"nickName2"];
                }

                [textImageItem.comments addObject:commentItem];

            }];
        }

        [self addItem:textImageItem];
        
    }];
    
    if (delitem != 0) {
            NSIndexPath*scrollIndexPath = [NSIndexPath indexPathForRow:delitem<self.items.count?delitem:self.items.count-1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        delitem = 0;
    }
    
}

- (void)updatamemberIndb:(Contact *)MemberInfo{
    if ([ContactsDao queryDataISMember:MemberInfo.memberId]) {
        [ContactsDao updateData:MemberInfo];
    }else{
        [ContactsDao insertData:MemberInfo];
    }
}

-(NSArray *)toDealwithpicList:(NSArray *)picList{
    NSMutableArray *picListArr = [[NSMutableArray alloc]initWithCapacity:0];
    [picList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [picListArr addObject:[obj objectForKey:@"pic"]];
    }];
    return picListArr;
}

/**
 *  是否请求成功
 */
- (BOOL)isSuccess:(NSJSONSerialization *)result showSucces:(BOOL)showSucces showError:(BOOL)showError{
    BOOL success = [[result valueForKey:@"Status"] boolValue];
    NSString *msg = [result valueForKey:@"Msg"];
    if (success) {
        if (showSucces) {
            [self.view makeToast:msg];
        }
        return YES;
    }
    if (showError) {
        [self.view makeToast:msg];
    }
    return NO;
}

//点赞
- (void)requestonLike:(NSString *)dynamicId{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID], @"memberId",
                            [CachesDirectory getServerKey],@"key",
                            dynamicId, @"dynamicId",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DynamicWebService.asmx/DynamicPraise" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            //点赞
            DFLineLikeItem *likeItem = [[DFLineLikeItem alloc] init];
            likeItem.userId = [[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID] intValue];
            likeItem.userNick = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
            [self addLikeItem:likeItem itemId:[dynamicId integerValue]];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
    }];
    
}
////取消赞
//- (void)requestTimeSubmit{
//    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DynamicWebService.asmx/DynamicPraiseCancel" params:nil networkBlock:^{
//        [self.view makeToast:@"没有网络!"];
//    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
//        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
//        if (success) {
//            self.dataArr = [responseObject valueForKey:@"timeList"];
//        }else{
//        }
//    } failedBlock:^(AFCustomClient *request, NSError *error) {
//        
//    }];
//    
//}

//评论/回复
- (void)requestonCommentCreate:(NSString *)dynamicId toMemberId:(NSString *)toMemberId contents:(NSString *)contents{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID], @"memberId",
                            dynamicId, @"dynamicId",
                            [toMemberId integerValue]==0?@"":toMemberId, @"toMemberId",
                            contents, @"contents",
                            [CachesDirectory getServerKey],@"key",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"DynamicWebService.asmx/DynamicComments" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            DFLineCommentItem *commentItem = [[DFLineCommentItem alloc] init];
            commentItem.commentId = [[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID] integerValue];
            commentItem.userId = [[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID] intValue];
            commentItem.userNick = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
            commentItem.text = contents;
            [self addCommentItem:commentItem itemId:[dynamicId integerValue] replyCommentId:[toMemberId integerValue]];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
    }];
    
}


- (void)headimageAction
{
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    MMPopupItemHandler block = ^(NSInteger index){
        if (index==0) {
            [self openxiangji];
        }else if (index==1){
            [self openxiangche];
        }
    };
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finish){

    };
    NSArray *items =
    @[MMItemMake(@"拍照", MMItemTypeNormal, block),
      MMItemMake(@"从手机相册选择", MMItemTypeNormal, block)
      ];
    
    [[[MMSheetView alloc] initWithTitle:nil
                                  items:items] showWithBlock:completeBlock];
    
}


- (void)openxiangji{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        pickerorphoto = 1;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    else{
        
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)openxiangche{
    pickerorphoto = 0;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:^{
    }];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
        
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self saveImage:image withName:@"currentImage.png"];
    }
    
    // 保存图片到字典用于请求数据
    [self.m_imageDic setValue:UIImageJPEGRepresentation(image, 1) forKey:[NSString stringWithFormat:@"frontCover"]];
    
    
    [self ChangePhoto];
    
}



- (void)ChangePhoto{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID], @"memberId",
                            [CachesDirectory getServerKey],@"key",
                            nil];
    [SVProgressHUD showWithStatus:@"正在上传封面..."];
    [AFCustomClient requestUploadWithHttpPostWithURLStr:@"DynamicWebService.asmx/AddDynamicConfig" params:params files:self.m_imageDic networkBlock:^{
        [SVProgressHUD dismiss];
        [self.view makeToast:@"暂无网络"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            [CachesDirectory addValue:[responseObject valueForKey:@"FrontCover"] andKey:CachesDirectory_MemberInfo_FrontCover];
            [self setHeader:[responseObject valueForKey:@"FrontCover"]];
        }
        [SVProgressHUD dismiss];
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

#warning HQWaring此处仿举报接口，后面要加此接口
- (void)requestJubaoSubmit{
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"WLCWebService.asmx/WLCTimeList" params:nil networkBlock:^{} successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {} failedBlock:^(AFCustomClient *request, NSError *error) {}];

}

@end