//
//  BaseXLFormViewController.m
//  MOT
//
//  Created by fenghq on 15/10/21.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "BaseXLFormViewController.h"
#import "AppDelegate.h"

@interface BaseXLFormViewController ()

@end

@implementation BaseXLFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setbackBarButtonItemtitle:@"返回"];
    [self.view setTintColor:UIColorDJYThemecolorsRGB];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

-(void)setbackBarButtonItemtitle:(NSString *)title {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = title;
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithDictionary:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.PushDICParams = dic;
    }
    return self;
    
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
    [addButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setTitleColor:RGBColor(10, 10, 10) forState:UIControlStateNormal];
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
    MLEmojiLabel *Elabel = [[MLEmojiLabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    Elabel.numberOfLines = 1;
    Elabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [Elabel setFont:[UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:14.0]];
    Elabel.backgroundColor = [UIColor clearColor];
    Elabel.textColor =RGBColor(10, 10, 10);
    //下面是自定义表情正则和图像plist的例子
    Elabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    Elabel.customEmojiPlistName = @"customexpressionImage_custom";
    Elabel.text = title;
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 80, 44)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    [Elabel addSubview:addButton];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:Elabel];
    return _addFriendItem;
}

/**
 *  进入下一个视图
 *
 *  @return 进入下视图所带参数集
 */
-(void)PUSHWithBlockView:(BaseXLFormViewController*)VC andblock:(NavigationControllerCompletionBlock)handBlock;
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

-(void)setLayerBorder:(UIView*)View andcornerRadius:(CGFloat)cornerRadius andborderWidth:(CGFloat)borderWidth andborderColor:(CGColorRef)CGColorRef;
{
    View.layer.cornerRadius = cornerRadius;  // 将图层的边框设置为圆脚
    View.layer.masksToBounds = YES; // 隐藏边界
    View.layer.borderWidth = borderWidth;  // 给图层添加一个有色边框
    View.layer.borderColor = CGColorRef;
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
 *  转换null
 */
- (NSString *)setServerValuenull:(NSString *)Value{
    if ([Value isEqualToString:@"<null>"]) {
        return @"";
    }
    return Value;
}

/**
 *  是否是null（BOOL）
 */
- (BOOL)IsValuenull:(NSString *)Value{
    if ([Value isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
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


/**
 *  初始化Section
 *XLFormRowDescriptorTypeText
 *  @param row      row
 *  @param section  section
 *  @param array    array
 *  @param disabled disabled
 */
- (void)allocTypeTextFormRow:(XLFormRowDescriptor*)row andsection:(XLFormSectionDescriptor*)section andinfo:(NSArray*)array anddisabled:(id)disabled andRequired:(BOOL)required{
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        NSString *title = [dic objectForKey:@"title"];
        NSString *value = [dic objectForKey:@"value"];
        row = [XLFormRowDescriptor formRowDescriptorWithTag:title rowType:XLFormRowDescriptorTypeText title:title];
        [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
        [row.cellConfigAtConfigure setObject:title forKey:@"textField.placeholder"];
//        [row.cellConfig setObject:[UIColor redColor] forKey:@"textField.textColor"];
        row.value = value;
        row.disabled = disabled;
        row.required = required;
        [section addFormRow:row];
    }
}
/**
 *  初始化Section
 *XLFormRowDescriptorTypeSelectorPush
 *  @param row     row
 *  @param section section
 *  @param array   array
 */
- (void)allocTypeSelectorPushFormRow:(XLFormRowDescriptor*)row andsection:(XLFormSectionDescriptor*)section andinfo:(NSArray*)array andRequired:(BOOL)required{
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        NSString *title = [ParserUtil getString:dic forKey:@"title"];
        id value = [dic objectForKey:@"value"];
        row = [XLFormRowDescriptor formRowDescriptorWithTag:title rowType:XLFormRowDescriptorTypeSelectorPush title:title];
        row.selectorTitle = title;
        row.selectorOptions = value;
        NSString *oldValue = [dic objectForKey:@"oldvalue"];
        row.value =oldValue==nil?value[0]:oldValue;
        row.required = required;//必选
        [section addFormRow:row];
    }
}


-(BOOL)checkPressed
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self.view makeToast:[[validationErrors firstObject] localizedDescription]];
        return NO;
    }
    return YES;
}




@end
