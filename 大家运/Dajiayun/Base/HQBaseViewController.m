//
//  BaseViewController.m
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "HQBaseViewController.h"
#import "AppDelegate.h"

@interface HQBaseViewController (){


}

@end

@implementation HQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [[MMPopupWindow sharedWindow] cacheWindow];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [self setbackBarButtonItemtitle:@""];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

-(void)setbackBarButtonItemtitle:(NSString *)title {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = title;
    self.navigationItem.backBarButtonItem = backItem;
//    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

}

/**
 *  不自动Lyaout
 */
-(void)setedgesForExtendedLayoutNO{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  隐藏多余分栏线
 */
- (void)setExtraCellLineHidden:(UITableView *)tableView;
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/**
 *设置导航栏的【只有标题按钮】
 */
-(UIBarButtonItem *)SetnavigationBartitle:(NSString *)title andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 44, 44)];
    [addButton setTitle:title forState:UIControlStateNormal];
    [addButton.titleLabel setFont:[UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:16.0]];
    addButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

/**
 *  设置导航栏的【只有图标按钮】
 */
- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 44, 44)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

/**
 *设置导航栏的【标题图标混和】
 */
-(UIBarButtonItem *)SetnavigationBartitleandImage:(NSString *)title andaction:(SEL)Saction{
    MLEmojiLabel *Elabel = [[MLEmojiLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    Elabel.numberOfLines = 1;
    Elabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [Elabel setFont:[UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:14.0]];
    Elabel.backgroundColor = [UIColor clearColor];
    Elabel.textColor =[UIColor whiteColor];
    //下面是自定义表情正则和图像plist的例子
    Elabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    Elabel.customEmojiPlistName = @"customexpressionImage_custom";
    Elabel.text = title;
    Elabel.textAlignment = NSTextAlignmentCenter;

    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 80, 44)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    [Elabel addSubview:addButton];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:Elabel];
    return _addFriendItem;
}

-(id)initWithDictionary:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.PushDICParams = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return self;
    
}

/**
 *  进入下一个视图
 *
 *  @return 进入下视图所带参数集
 */
-(void)PUSHWithBlockView:(HQBaseViewController*)VC andblock:(NavigationControllerCompletionBlock)handBlock;
{
    [self.navigationController pushViewController:VC animated:YES];
    if (handBlock) {
        VC.CompletionBlock = handBlock;
    }
}

/**
 *  返回上一个视图
 *
 *  @return 返回上视图所带参数集
 */
- (void)POPViewControllerForDictionary:(NSDictionary *)handBlockdic;
{
    if (self.CompletionBlock) {
        self.CompletionBlock(handBlockdic);
        self.CompletionBlock = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  传值返回给上一个界面，更新界面数据
 *
 *  @return 返回上视图所带参数集
 */
- (void)CompletionBlockBack:(NSDictionary *)handBlockdic;{
    if (self.CompletionBlock) {
        self.CompletionBlock(handBlockdic);
        self.CompletionBlock = nil;
    }
}


/**
 *  设置边框加圆角
 *
 *  @param View         对像
 *  @param cornerRadius 圆角度
 *  @param borderWidth  边框度
 *  @param CGColorRef   颜色
 */
-(void)setLayerBorder:(UIView*)View andcornerRadius:(CGFloat)cornerRadius andborderWidth:(CGFloat)borderWidth andborderColor:(CGColorRef)CGColorRef;
{
    View.layer.cornerRadius = cornerRadius;  // 将图层的边框设置为圆脚
    View.layer.masksToBounds = YES; // 隐藏边界
    View.layer.borderWidth = borderWidth;  // 给图层添加一个有色边框
    View.layer.borderColor = CGColorRef;
}

/**
 *  设置圆角
 *
 *  @param View 对像
 */
-(void)setLayer:(UIView *)View andcornerRadius:(CGFloat)cornerRadius;{
    View.layer.masksToBounds = YES;
    View.layer.cornerRadius = View.frame.size.width/2; //圆角（圆形)
    //防止掉帧（列表不卡了）
    View.layer.shouldRasterize = YES;
    View.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

/**
 *  根据文本输出高度
 *
 *  @param object 文本内容
 *  @param Width  文本显示的固定宽度
 *  @param Size   文本显示字体大小
 *
 *  @return 文本高度
 */
-(CGFloat)heightForLabelWithText:(NSString *)object andTextWidth:(CGFloat)Width andTextSize:(CGFloat)Sizee;
{
    CGSize textBlockMinSize = {Width, CGFLOAT_MAX};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    if (systemVersion >= 7.0) {
        size = [object boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Sizee]} context:nil].size;
    }else{
        size = [object sizeWithFont:[UIFont systemFontOfSize:Sizee] constrainedToSize:textBlockMinSize lineBreakMode:[self textLabelLineBreakModel]];
    }
    return  size.height;
}

-(NSLineBreakMode)textLabelLineBreakModel
{
    return NSLineBreakByCharWrapping;
}
/**
 *  常设属性初始化MLE
 *
 *  @param label MLEmojiLabel
 */
-(void)setMLEmojiLabelBase:(MLEmojiLabel *)label {
    
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.backgroundColor = [UIColor clearColor];
    //下面是自定义表情正则和图像plist的例子
    label.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    label.customEmojiPlistName = @"customexpressionImage_custom";
    
}
/**
 *  颜色转换图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  赋值
 */
- (id)setServerValue:(id)Value{
    if (Value==nil||[Value isEqualToString:@"(null)"]) {
        return @"";
    }
    return Value;
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


- (void)allocLoadingAgainViewWith:(UITableView *)tableview{
    if (!self.friendlyLoadingView) {
        self.friendlyLoadingView = [[XHFriendlyLoadingView alloc] initWithFrame:self.view.bounds];
        [tableview addSubview:self.friendlyLoadingView];
        __weak typeof(self) weakSelf = self;
        self.friendlyLoadingView.reloadButtonClickedCompleted = ^(UIButton *sender) {
            // 这里可以做网络重新加载的地方
            [weakSelf.friendlyLoadingView showFriendlyLoadingViewWithText:SVShowWithStatusStringType1 loadingAnimated:YES];
            [tableview.header beginRefreshing];
        };
    }
}
/**
 *  显示LoadingAgainView
 */
- (void)showReloadViewWithArray:(NSMutableArray *)dataArr WithMsg:(NSString *)msg Withtableview:(UITableView *)tableview{
    if (dataArr.count==0) {
        [self allocLoadingAgainViewWith:tableview];
        [self.friendlyLoadingView showReloadViewWithText:msg];
    }else{
        [self.friendlyLoadingView hideLoadingView];
    }
}
/**
 *  请求结束，隐藏加载条
 */
- (void)setCompletionOver {
    self.IsCompletionOver = YES;
    [SVProgressHUD dismiss];
}
/**
 *  索引分区的lable
 */
- (UILabel *)allocSectionTitleLabel:(NSString *)title {
    UILabel * sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Windows_WIDTH, 30)];
    sectionTitleLabel.text = title;
    sectionTitleLabel.textColor=[UIColor darkGrayColor];
    sectionTitleLabel.textAlignment = NSTextAlignmentLeft;
    sectionTitleLabel.font = [UIFont systemFontOfSize:15.0];
    sectionTitleLabel.backgroundColor = [UIColor clearColor];
    return sectionTitleLabel;
}
/**
 *  判断是否有上一个区的数据：返回lastObjectNSString
 */
- (NSString *)lastSectionDataFromArr:(NSMutableArray *)dataArr valueForKey:(NSString *)Key{
    NSMutableArray *dailyDate = [dataArr valueForKey:Key];
    NSSet *set = [NSSet setWithArray:dailyDate];
    NSArray *Allset = [set allObjects];
    NSArray *sortedArray = [Allset sortedArrayUsingSelector:@selector(compare:)];
    return [[[sortedArray reverseObjectEnumerator] allObjects] lastObject];
}
/**
 *  索引排序：返回所有数据
 */
- (NSArray *)EnumeratorArraysortedArray:(NSArray *)data andkey:(NSString *)key{
    NSArray *dailyDate = [data valueForKey:key];
    NSSet *set = [NSSet setWithArray:dailyDate];
    NSArray *Allset = [set allObjects];
    NSArray *sortedArray = [Allset sortedArrayUsingSelector:@selector(compare:)];
    return [[sortedArray reverseObjectEnumerator] allObjects];
}
/**
 *  返回所有索引为了分区
 */
- (NSMutableArray *)setIndexKeyWithDataFormArr:(NSMutableArray *)dataArr valueForKey:(NSString *)Key{
    NSMutableArray *dailyDate = [dataArr valueForKey:Key];
    NSSet *set = [NSSet setWithArray:dailyDate];
    NSArray *Allset = [set allObjects];
    NSArray *sortedArray = [Allset sortedArrayUsingSelector:@selector(compare:)];
    return [[[sortedArray reverseObjectEnumerator] allObjects] mutableCopy];
}

/**
 * 存储数据
 */
- (void)CachesDirectoryDatadocumentsPath:(NSString *)fileName data:(NSArray *)array{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [array writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName] atomically:YES];
}

/**
 * 获取数据
 */
- (NSArray *)GetCachesDirectoryDatadocumentsPath:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSArray *userinfo = [NSArray arrayWithContentsOfFile:filePath];
    return userinfo;
}

/**
 * 存储数据
 */
- (void)CachesDirectoryImagePath:(NSString *)fileName data:(UIImage *)image;{
    NSData* imageData = UIImagePNGRepresentation(image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [imageData writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName] atomically:YES];
}
/**
 * 获取数据
 */
- (UIImage *)GetCachesDirectoryImagePath:(NSString *)fileName;{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *userinfo = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:userinfo];
    return image;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/**
 * 通用弹出层
 */
- (void)BaseHQAllertView:(NSString *)string{
    MMPopupItemHandler block = ^(NSInteger index){};
    NSArray *items =@[MMItemMake(@"好的", MMItemTypeNormal, block)];
    MMAlertView *alertView = [[MMAlertView alloc]initWithTitle:
                              string
                                                        detail:nil
                                                         items:items];
    alertView.attachedView = [MMPopupWindow sharedWindow];
    [alertView show];
}

/**
 *  保存登录信息，再进行即时消息登录
 *
 *  @param MemberInfo
 *  @param username
 *  @param password
 */
- (void)saveLoginMemberInfo:(NSDictionary *)MemberInfo username:(NSString *)username password:(NSString *)password{
    [MOTUserDataManager savePassWord:password andusername:username anduserid:@"" anduserrole:@""];
    NSDate *date = [NSDate date];
    NSTimeInterval timeDiff = [date timeIntervalSince1970];//毫秒数要乘以1000
    [CachesDirectory addValue:[NSString stringWithFormat:@"%.0f", timeDiff] andKey:SERVER_TIME_DIFF];
    [CachesDirectory addValue:username andKey:CachesDirectory_MemberInfo_ACCOUNT];
    [CachesDirectory addValue:[MemberInfo objectForKey:@"MemberID"] andKey:CachesDirectory_MemberInfo_MemberID];
    [CachesDirectory addValue:[MemberInfo objectForKey:@"NickName"] andKey:CachesDirectory_MemberInfo_NickName];
    [CachesDirectory addValue:[MemberInfo objectForKey:@"PhotoMid"] andKey:CachesDirectory_MemberInfo_PhotoMid];
    [CachesDirectory addValue:[MemberInfo objectForKey:@"PhotoBig"] andKey:CachesDirectory_MemberInfo_PhotoBig];
    [CachesDirectory addValue:[MemberInfo objectForKey:@"Phone"] andKey:CachesDirectory_MemberInfo_Phone];
    [CachesDirectory addValue:[MemberInfo objectForKey:@"MemberCode"] andKey:CachesDirectory_MemberInfo_MemberCode];
    [CachesDirectory addValue:[MemberInfo objectForKey:@"DiQu"] andKey:CachesDirectory_MemberInfo_DiQu];
    
    [self loginWithUsername:[MemberInfo objectForKey:@"MemberID"]
                   password:@"888888"];
    
}


- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    
    //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         [SVProgressHUD dismiss];
         if (loginInfo && !error) {

             //设置推送的昵称
             [[EaseMob sharedInstance].chatManager setApnsNickname:[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName]];
             
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             
             // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
             [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             //获取数据库中数据
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             //获取群组列表
             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             //发送自动登陆状态通知
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             
             //保存最近一次登录用户名
             [self saveLastLoginUsername];
             
         }
         else
         {
             
//             //设置推送的昵称
//             [[EaseMob sharedInstance].chatManager setApnsNickname:[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName]];
//             
//             //设置是否自动登录
//             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//             
//             // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
//             [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
//             //获取数据库中数据
//             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
//             
//             //获取群组列表
//             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
//             
//             //发送自动登陆状态通知
//             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
//             
//             //保存最近一次登录用户名
//             [self saveLastLoginUsername];
             
             switch (error.errorCode)
             {
                 case EMErrorNotFound:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorNetworkNotConnected:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                     break;
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                     break;
                 default:
                     TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                     break;
             }
             [self.LogBtn endButtonActivityIndicatorView];
             self.view.userInteractionEnabled = YES;
         }
     } onQueue:nil];
}

- (void)saveLastLoginUsername
{
    NSString *username = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
        [ud synchronize];
    }
}

- (id)toArrayOrNSDictionary:(NSString *)jsonString{
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    
    if (!error){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

/**
 *  获取途径城市
 *
 *  @param tujingArr
 *
 *  @return
 */
- (NSString *)GETtujingCityName:(NSArray *)tujingArr{
    __block NSString *tujingCity=@"";
    [tujingArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *CityDic = [tujingArr objectAtIndex:idx];
        NSString *address = [CityDic objectForKey:@"address"];
        NSArray *addrArr = [address componentsSeparatedByString:@","];
        if (addrArr.count) {
            if (addrArr.count>1) {
                tujingCity = [addrArr objectAtIndex:1];
            }else{
                tujingCity = [addrArr firstObject];
            }
        }
        
    }];
    return tujingCity;
}



@end
