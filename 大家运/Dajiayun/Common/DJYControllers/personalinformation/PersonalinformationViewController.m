//
//  PersonalinformationViewController.m
//  Dajiayun
//
//  Created by CityAndCity on 16/2/21.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "PersonalinformationViewController.h"
#import "ChangeNicknameViewController.h"
#import "MyQRViewController.h"

@interface PersonalinformationViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,Bzwdelegate>
{
    UITableView *M_tableview;
    DJYXIBTableViewCell10 *headcell;
    NSInteger pickerorphoto;
    
    BzwPicker *pick;
    UIView *PickBackgroundView;
    NSString *CAdress;
    NSString *CShengId;
    NSString *CShiId;
    NSString *CQuId;

}

// 用于临时存储用户更换背景图片的字典
@property (nonatomic, strong) NSMutableDictionary   *m_imageDic;

@end

@implementation PersonalinformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.m_imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [self setedgesForExtendedLayoutNO];
    M_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    [self allocPick];
    [self allocheadInfoView];
    // Do any additional setup after loading the view.
}

- (void)allocPick{

    pick = [[BzwPicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    pick.delegatee = self;
    pick.backgroundColor = [UIColor whiteColor];
    PickBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    PickBackgroundView.backgroundColor = [UIColor lightGrayColor];
    PickBackgroundView.alpha = 0;
    [self.view addSubview:PickBackgroundView];
    [self.view addSubview:pick];
    
    [pick.leftBtn addTarget:self action:@selector(cacleBtn) forControlEvents:UIControlEventTouchUpInside];
    [pick.rightBtn addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    headcell.nickName.text = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
    [M_tableview reloadData];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    M_tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


- (void)allocheadInfoView {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
    headcell = (DJYXIBTableViewCell10 *)[nib objectAtIndex:10];
    headcell.frame = CGRectMake(0, 0, Windows_WIDTH, 150);
    [self setLayer:headcell.headIMG andcornerRadius:90];
    headcell.nickName.text = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
    [headcell.headIMG sd_setImageWithURL:[NSURL URLWithString:[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_PhotoBig]] placeholderImage:[UIImage imageNamed:@"14"]];
    [headcell.headimageview addTarget:self action:@selector(headimageAction) forControlEvents:UIControlEventTouchUpInside];
    M_tableview.tableHeaderView = headcell;
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"DJYXIBTableViewCell2";
    DJYXIBTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
        cell = (DJYXIBTableViewCell2 *)[nib objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell.headimageview setFrame:CGRectMake(cell.headimageview.frame.origin.x, cell.frame.size.height/2-15, 25, 25)];
    cell.headimageview.center = CGPointMake(30, cell.titlelabel.center.y);
    cell.detaillabel.textColor = [UIColor lightGrayColor];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.headimageview.image = [UIImage imageNamed:@"iconfont-m-loginNickname"];
            cell.titlelabel.text = @"昵称";
            cell.detaillabel.text = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
        }else if (indexPath.row==1){
            cell.headimageview.image = [UIImage imageNamed:@"iconfont-iconfontdiquguanli"];
            cell.titlelabel.text = @"地区";
            cell.detaillabel.text = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_DiQu];
        }else if (indexPath.row==2){
            cell.headimageview.image = [UIImage imageNamed:@"iconfont-dianhua"];
            cell.titlelabel.text = @"账号";
            NSString *originTel = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_ACCOUNT];
            NSString *tel = [originTel stringByReplacingCharactersInRange:NSMakeRange(3, originTel.length-3-4) withString:@"****"];
            cell.detaillabel.text = tel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            cell.headimageview.image = [UIImage imageNamed:@"iconfont-erweima"];
            cell.titlelabel.text = @"我的二维码";
           
        }
    }


    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return HeightForRowInSection;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section  {
    return 0.00001f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return HeightForHeaderInSection;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            ChangeNicknameViewController *VC = [[ChangeNicknameViewController alloc]init];
            [self PUSHWithBlockView:VC andblock:nil];
        }else if (indexPath.row==1){
            [self btnDown:nil];
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            MyQRViewController *VC = [[MyQRViewController alloc]init];
            [self PUSHWithBlockView:VC andblock:nil];
        }
    }

}


- (void)headimageAction
{
    MMPopupItemHandler block = ^(NSInteger index){
        if (index==0) {
            [self openxiangji];
        }else if (index==1){
            [self openxiangche];
        }
    };
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finish){
        NSLog(@"animation complete");
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
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
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
    [self.m_imageDic setValue:UIImageJPEGRepresentation(image, 1) forKey:[NSString stringWithFormat:@"photo"]];
    
    
    [self ChangePhoto];
    
}

- (void)ChangePhoto{
    
    if (self.m_imageDic.count==0) {
        [self.view makeToast:@"请选择一张图片"];
        return;
    }
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            nil];
    [AFCustomClient requestUploadWithHttpPostWithURLStr:@"MemberInfoWebService.asmx/ChangePhoto" params:params files:self.m_imageDic networkBlock:^{
        [self.view makeToast:@"暂无网络"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        BOOL success = [[responseObject valueForKey:@"Status"] boolValue];
        if (success) {
            [headcell.headIMG sd_setImageWithURL:[NSURL URLWithString:[responseObject valueForKey:@"PhotoBig"]]];
            [CachesDirectory addValue:[responseObject valueForKey:@"PhotoMid"] andKey:CachesDirectory_MemberInfo_PhotoMid];
            [CachesDirectory addValue:[responseObject valueForKey:@"PhotoBig"] andKey:CachesDirectory_MemberInfo_PhotoBig];

        }else
        {
            [self.view makeToast:[responseObject valueForKey:@"Msg"]];
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
    }];
}


-(void)btnDown:(UIButton *)btn;
{
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0.3;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height-190, self.view.frame.size.width, 190)];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
//取消
-(void)cacleBtn
{
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
//暂时没做其他操作   仅仅是取消
-(void)okBtn
{
    [self ChangeModifyDiQu];
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
-(void)didSelete:(NSString *)pro andCity:(NSString *)city andTown:(NSString *)town
{
    CAdress = [NSString stringWithFormat:@"%@,%@,%@",pro,city,town];
}

-(void)didSelete:(NSString *)ShengId ShiId:(NSString *)city QuId:(NSString *)town;
{
    CShengId = ShengId;
    CShiId = city;
    CQuId = town;
}


-(void)pickerViewtitle:(NSString *)title ShengId:(NSString *)ShengId ShiId:(NSString *)ShiId QuId:(NSString *)QuId;{
    CAdress = title;
    CShengId = ShengId;
    CShiId = ShiId;
    CQuId = QuId;
    
}


- (void)ChangeModifyDiQu{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            [NSString stringWithFormat:@"%@|%@|%@",CShengId,CShengId,CQuId],@"diQu",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/ModifyDiQu" params:params networkBlock:^{
        [self.view makeToast:@"没有网络!"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            [CachesDirectory addValue:CAdress andKey:CachesDirectory_MemberInfo_DiQu];
            [M_tableview reloadData];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
    }];
}

@end
