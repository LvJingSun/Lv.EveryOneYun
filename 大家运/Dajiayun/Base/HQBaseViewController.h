//
//  BaseViewController.h
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQBaseViewController : UIViewController

@property (nonatomic, strong) IANActivityIndicatorButton *LogBtn;

/**
 *  是否需要索引排序
 */
@property (nonatomic, assign) BOOL Issortingindex;
/**
 *  是否已经区分（历史事件、已完成）
 */
@property (nonatomic, assign) BOOL Distinguish;
/**
 *  此类中唯一的请求是否请求结束（不管是否请求成功）
 */
@property (nonatomic, assign) BOOL IsCompletionOver;
/**
 *  请求结束，隐藏加载条
 */
- (void)setCompletionOver;
/**
 *  重新加载
 */
@property (nonatomic, strong) XHFriendlyLoadingView *friendlyLoadingView;
/**
 *  显示LoadingAgainView
 */
- (void)showReloadViewWithArray:(NSMutableArray *)dataArr WithMsg:(NSString *)msg Withtableview:(UITableView *)tableview;
/**
 *  A->B,传入值
 */
@property (nonatomic,strong) NSDictionary *PushDICParams;
/**
 *  B->A,回调值
 *
 *  @param BlockDIC B返回A，回调参数
 */
typedef void (^NavigationControllerCompletionBlock)(NSDictionary *BlockDIC);

@property (nonatomic, copy) NavigationControllerCompletionBlock CompletionBlock;

/**
 *  初始化
 */
-(id)initWithDictionary:(NSDictionary *)dic;
/**
 *  隐藏多余分栏线
 */
- (void)setExtraCellLineHidden:(UITableView *)tableView;
/**
 *设置导航栏的【只有标题按钮】
 */
-(UIBarButtonItem *)SetnavigationBartitle:(NSString *)title andaction:(SEL)Saction;
/**
 *  设置导航栏的【只有图标按钮】
 */
- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction;
/**
 *设置导航栏的【标题图标混和】
 */
-(UIBarButtonItem *)SetnavigationBartitleandImage:(NSString *)title andaction:(SEL)Saction;
/**
 *  导航push下一个视图
 *  带回调值
 */
-(void)PUSHWithBlockView:(UIViewController*)VC andblock:(NavigationControllerCompletionBlock)handBlock;
/**
 *  导航pop上一个视图
 *  回调值
 */
- (void)POPViewControllerForDictionary:(NSDictionary *)handBlockdic;

/**
 *  传值返回给上一个界面，更新界面数据
 *
 *  @return 返回上视图所带参数集
 */
- (void)CompletionBlockBack:(NSDictionary *)handBlockdic;

/**
 *  设置视图的圆角边框
 */
-(void)setLayerBorder:(UIView*)View andcornerRadius:(CGFloat)cornerRadius andborderWidth:(CGFloat)borderWidth andborderColor:(CGColorRef)CGColorRef;

/**
 *  设置圆角
 *
 *  @param View 对像
 */
-(void)setLayer:(UIView *)View andcornerRadius:(CGFloat)cornerRadius;

/**
 *  根据文本输出高度
 *  @return 文本高度
 */
-(CGFloat)heightForLabelWithText:(NSString *)object andTextWidth:(CGFloat)Width andTextSize:(CGFloat)Sizee;

/**
 *  设置MLlabel基础属性
 *
 *  @param label MLlabel;
 */
-(void)setMLEmojiLabelBase:(MLEmojiLabel *)label;

/**
 *  颜色转换图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
- (UIImage*) createImageWithColor: (UIColor*) color;
/**
 *  不自动Lyaout
 */
-(void)setedgesForExtendedLayoutNO;
/**
 *  赋值
 */
- (id)setServerValue:(id)Value;
/**
 *  是否请求成功
 */
- (BOOL)isSuccess:(NSJSONSerialization *)result showSucces:(BOOL)showSucces showError:(BOOL)showError;

/**
 *  索引分区的lable
 */
- (UILabel *)allocSectionTitleLabel:(NSString *)title;
/**
 *  判断是否有上一个区的数据
 */
- (NSString *)lastSectionDataFromArr:(NSMutableArray *)dataArr valueForKey:(NSString *)Key;
/**
 *  索引排序
 */
- (NSArray *)EnumeratorArraysortedArray:(NSArray *)data andkey:(NSString *)key;
/**
 *  返回所有索引为了分区
 */
- (NSMutableArray *)setIndexKeyWithDataFormArr:(NSMutableArray *)dataArr valueForKey:(NSString *)Key;

/**
 * 存储数据
 */
- (void)CachesDirectoryDatadocumentsPath:(NSString *)fileName data:(NSArray *)array;
/**
 * 获取数据
 */
- (NSArray *)GetCachesDirectoryDatadocumentsPath:(NSString *)fileName;

/**
 * 存储数据
 */
- (void)CachesDirectoryImagePath:(NSString *)fileName data:(UIImage *)image;
/**
 * 获取数据
 */
- (UIImage *)GetCachesDirectoryImagePath:(NSString *)fileName;

/**
 * 通用弹出层
 */
- (void)BaseHQAllertView:(NSString *)string;

/**
 *  保存登录信息，再进行即时消息登录
 */
- (void)saveLoginMemberInfo:(NSDictionary *)MemberInfo username:(NSString *)username password:(NSString *)password;
/**
 *  json字符串转数组或字典；
 *
 *  @param jsonString
 *
 *  @return
 */
- (id)toArrayOrNSDictionary:(NSString *)jsonString;
/**
 *  获取途径城市
 *
 *  @param tujingArr
 *
 *  @return
 */
- (NSString *)GETtujingCityName:(NSArray *)tujingArr;

@end
