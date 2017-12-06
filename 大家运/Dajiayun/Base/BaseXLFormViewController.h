//
//  BaseXLFormViewController.h
//  MOT
//
//  Created by fenghq on 15/10/21.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "XLFormViewController.h"

@interface BaseXLFormViewController : XLFormViewController
//此类中唯一的请求是否请求结束（不管是否请求成功）
@property (nonatomic, assign) BOOL IsCompletionOver;
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
 *  设置视图的圆角边框
 */
-(void)setLayerBorder:(UIView*)View andcornerRadius:(CGFloat)cornerRadius andborderWidth:(CGFloat)borderWidth andborderColor:(CGColorRef)CGColorRef;

/**
 *  初始化Section
 *XLFormRowDescriptorTypeText
 *  @param row      row
 *  @param section  section
 *  @param array    array
 *  @param disabled disabled
 */
- (void)allocTypeTextFormRow:(XLFormRowDescriptor*)row andsection:(XLFormSectionDescriptor*)section andinfo:(NSArray*)array anddisabled:(id)disabled andRequired:(BOOL)required;
/**
 *  初始化Section
 *XLFormRowDescriptorTypeSelectorPush
 *  @param row     row
 *  @param section section
 *  @param array   array
 */
- (void)allocTypeSelectorPushFormRow:(XLFormRowDescriptor*)row andsection:(XLFormSectionDescriptor*)section andinfo:(NSArray*)array andRequired:(BOOL)required;
/**
 *  赋值
 */
- (id)setServerValue:(id)Value;
/**
 *  转换null
 */
- (NSString *)setServerValuenull:(NSString *)Value;
/**
 *  是否是null（BOOL）
 */
- (BOOL)IsValuenull:(NSString *)Value;
/**
 *  是否请求成功
 */
- (BOOL)isSuccess:(NSJSONSerialization *)result showSucces:(BOOL)showSucces showError:(BOOL)showError;
/**
 *  获取数据字典
 *
 *  @param optionsName 数据字典名称
 *
 *  @return 装有数据字典的数组
 */
- (NSMutableArray *)getDICTplistName:(NSString*)optionsName;
/**
 *  数据字典 根据key获取value
 */
- (NSString *)getDCICValueFromKey:(NSString *)key andplistName:(NSString *)optionsName;
/**
 *  数据字典 根据value获取key
 */
- (NSString *)getDCICKeyFromValue:(NSString *)Value andplistName:(NSString *)optionsName;
/**
 *  判断网络不好
 *
 *  @return TURE有网络
 */
- (BOOL)isConnectionAvailable;

/**
 *  根据plist 设置row选项options
 */
- (NSMutableArray *) setOptionsWithFormRow:(XLFormRowDescriptor*)row plistName:(NSString*)optionsName;
/**
 *  根据plist 根据row值设置默认第N个选项
 */
- (NSInteger )setOptionsBaseWithFormRowText:(NSString*)rowtext plistName:(NSString*)optionsName;
/**
 *  检测是否合法
 *
 *  @return 
 */
-(BOOL)checkPressed;

@end
