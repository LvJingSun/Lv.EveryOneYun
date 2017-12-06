//
//  MyDJYContactDetailViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/3/30.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "MyDJYContactDetailViewController.h"

@interface MyDJYContactDetailViewController ()
@property(nonatomic,strong)NSDictionary *dbsxDIC;

@end

@implementation MyDJYContactDetailViewController

- (instancetype)initXLtitle:(NSString *)Title anddic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.dbsxDIC = [[NSDictionary alloc]initWithDictionary:dic];
        self.title = Title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setTintColor:UIColorDJYThemecolorsRGB];
    
    [self initializeForm];
    
    if ([self.title isEqualToString:@"编辑联系人"]) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        DJYXIBTableViewCell9 *cell = (DJYXIBTableViewCell9 *)[nib objectAtIndex:9];
        [self setLayerBorder:cell.titlelabel andcornerRadius:3 andborderWidth:1 andborderColor:[UIColor redColor].CGColor];
        [cell.titlelabel addTarget:self action:@selector(DelLinkerAlertSure) forControlEvents:UIControlEventTouchUpInside];
        [cell.titlelabel setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
        [cell.titlelabel setTitle:@"删除"forState:UIControlStateNormal];
        cell.titlelabel.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = cell;
        self.navigationItem.rightBarButtonItem =  [self SetnavigationBartitle:@"保存" andaction:@selector(getXLFormValue)];

    }else{
        self.navigationItem.rightBarButtonItem = [self SetnavigationBartitle:@"保存" andaction:@selector(getXLFormValue)];
    
    }
 
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

-(void)setLayerBorder:(UIView*)View andcornerRadius:(CGFloat)cornerRadius andborderWidth:(CGFloat)borderWidth andborderColor:(CGColorRef)CGColorRef;
{
    View.layer.cornerRadius = cornerRadius;  // 将图层的边框设置为圆脚
    View.layer.masksToBounds = YES; // 隐藏边界
    View.layer.borderWidth = borderWidth;  // 给图层添加一个有色边框
    View.layer.borderColor = CGColorRef;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initializeForm
{
    
    BOOL Modify = [self.title isEqualToString:@"编辑联系人"]==YES?YES:NO;
    
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:self.title];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    section = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:section];

    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"name" rowType:XLFormRowDescriptorTypeText title:@"姓名"];
    row.required = YES;
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"姓名" forKey:@"textField.placeholder"];
    Modify == YES?(row.value=[self.dbsxDIC objectForKey:@"name"]):nil;
    [section addFormRow:row];
    
    // phone
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"phone" rowType:XLFormRowDescriptorTypePhone title:@"电话"];
    row.required = YES;
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"电话" forKey:@"textField.placeholder"];
    Modify == YES?(row.value=[self.dbsxDIC objectForKey:@"phone"]):nil;
    [section addFormRow:row];
    
    // sex
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"sex" rowType:XLFormRowDescriptorTypeSelectorPush title:@"性别"];
    if (Modify==YES) {
        if ([[self.dbsxDIC objectForKey:@"sex"] isEqualToString:@"男"]) {
            row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"男"];
        }else if ([[self.dbsxDIC objectForKey:@"sex"] isEqualToString:@"女"]){
            row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"女"];
        }
    }
    row.selectorTitle = @"性别";
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0)
                                                                displayText:@"男"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"女"]
                            ];
    row.required = YES;
    [section addFormRow:row];
    
    // address
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"address" rowType:XLFormRowDescriptorTypeText title:@"地址"];
    row.required = YES;
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"地址" forKey:@"textField.placeholder"];
    Modify == YES?(row.value=[self.dbsxDIC objectForKey:@"address"]):nil;
    [section addFormRow:row];
    
    // isDefault
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"isDefault" rowType:XLFormRowDescriptorTypeBooleanCheck title:@"是否设为默认联系人"];
    if (Modify==YES) {
        if ([[self.dbsxDIC objectForKey:@"isDefault"] isEqualToString:@"1"]) {
            row.value = @(YES);
        }else{
            row.value = @(NO);
        }
    }
    [section addFormRow:row];
    
    self.form = formDescriptor;

}

- (void)getXLFormValue{
    [self.view endEditing:YES];
    if ([self checkPressed]) {
        NSDictionary* result = self.form.formValues;
        NSString *name = @"";
        NSString *phone = @"";
        NSString *sex = @"";
        NSString *address = @"";
        NSString *isDefault = @"" ;
        name = [result objectForKey:@"name"];
        phone = [result objectForKey:@"phone"];
        XLFormOptionsObject *sexObj = [result objectForKey:@"sex"];
        sex = sexObj.formDisplayText;
        address=[result objectForKey:@"address"];
        
        if ([[[result objectForKey:@"isDefault"] valueData] isEqual:@(YES)]){
            isDefault = @"1";
        }else{
            isDefault = @"2";
        }
        
        NSDictionary *params = [[NSDictionary alloc]init];
        if ([self.title isEqualToString:@"编辑联系人"]) {
            NSString *linkMemberId=[self.dbsxDIC objectForKey:@"linkerMemberId"];
            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                                    [CachesDirectory getServerKey],@"key",
                                    isDefault,@"isDefault",
                                    address,@"address",
                                    name,@"name",
                                    phone,@"phone",
                                    sex,@"sex",
                                    linkMemberId,@"linkMemberId",
                                    nil];
            [self requestAddLinkerORModifyLinker:params andUrlStr:@"MemberInfoWebService.asmx/ModifyLinker"];

        }else if ([self.title isEqualToString:@"新增联系人"]){
            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                                    [CachesDirectory getServerKey],@"key",
                                    isDefault,@"isDefault",
                                    address,@"address",
                                    name,@"name",
                                    phone,@"phone",
                                    sex,@"sex",
                                    nil];
            [self requestAddLinkerORModifyLinker:params andUrlStr:@"MemberInfoWebService.asmx/AddLinker"];
        }


    }
}

- (void)DelLinkerAlertSure;
{
    MMPopupItemHandler block = ^(NSInteger index){
    if (index) {
        [self requestDeleteLinker];
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


-(void)requestDeleteLinker{
    NSString *linkMemberId=[self.dbsxDIC objectForKey:@"linkerMemberId"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
              [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
              [CachesDirectory getServerKey],@"key",
              linkMemberId,@"linkMemberId",
              nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/DeleteLinker" params:params networkBlock:^{
        [self.view makeToast:@"暂无网络"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.delegate) {
                    [self.delegate ActionSuccess];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
        [self.view makeToast:error.localizedDescription];
    }];
}


-(void)requestAddLinkerORModifyLinker:(NSDictionary *)params andUrlStr:(NSString *)UrlStr{
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:UrlStr params:params networkBlock:^{
        [self.view makeToast:@"暂无网络"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.delegate) {
                    [self.delegate ActionSuccess];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
        [self.view makeToast:error.localizedDescription];
    }];
}

@end
