//
//  ThirdViewController.m
//  MOT
//
//  Created by fenghq on 15/9/28.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import "ThirdViewController.h"
#import "MyReleasesViewControllers.h"
#import "DJYsettingViewController.h"
#import "WilltodoViewController.h"
#import "MywalletViewController.h"
#import "PersonalinformationViewController.h"
#import "MyDJYContactViewController.h"
#import "MyCarController.h"

@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITableView *M_tableview;
    
    DJYXIBTableViewCell1 *headcell;
    
    NSInteger pickerorphoto;

    UIImageView *navBarHairlineImageView;
 
}
@property (nonatomic, strong) NSMutableArray            *dataArrCelltext;

@property (nonatomic, strong) NSMutableArray            *dataArr;

// 用于临时存储用户更换背景图片的字典
@property (nonatomic, strong) NSMutableDictionary   *m_imageDic;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setedgesForExtendedLayoutNO];
    self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.m_imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    self.dataArrCelltext = [[NSMutableArray alloc]initWithObjects:@[@{@"i":@"11",@"t":@"我的钱包"},@{@"i":@"12",@"t":@"待办事项"},@{@"i":@"13",@"t":@"我的发布"}],@[@{@"i":@"15",@"t":@"我的联系人"},@{@"i":@"16",@"t":@"我的评价"}], nil];
    //,@{@"i":@"14",@"t":@"我的车辆"}
    M_tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    M_tableview.delegate = self;
    M_tableview.dataSource = self;
    [self.view addSubview:M_tableview];
    
    [self allocheadInfoView];
    
}



- (void)viewWillAppear:(BOOL)animated
{   
    [headcell.headIMG sd_setImageWithURL:[NSURL URLWithString:[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_PhotoMid]] placeholderImage:[UIImage imageNamed:@"14"]];
    headcell.nickName.text = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    M_tableview.frame = CGRectMake(0, headcell.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - headcell.frame.size.height);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectTabbar:(UINavigationItem *)Item{
    Item.rightBarButtonItem = nil;
    UIButton *SetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    SetBtn.frame=CGRectMake(0, 0, 40, 40) ;
    SetBtn.backgroundColor=[UIColor clearColor];
    [SetBtn setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    [SetBtn addTarget:self action:@selector(rightActionDJYset) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barSetBtn=[[UIBarButtonItem alloc]initWithCustomView:SetBtn];
    NSArray *rightBtns=[NSArray arrayWithObjects:barSetBtn, nil];
    Item.rightBarButtonItems=rightBtns;
    
}

-(void)rightActionDJYset{

    DJYsettingViewController *VC = [[DJYsettingViewController alloc] init];
    [self.navigationController pushViewController:VC
                                         animated:YES];


}



- (void)allocheadInfoView {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
    headcell = (DJYXIBTableViewCell1 *)[nib objectAtIndex:1];
    headcell.frame = CGRectMake(0, 0, Windows_WIDTH, 150);
    [self setLayer:headcell.headIMG andcornerRadius:60];
    headcell.nickName.text = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_NickName];
    [headcell.headIMG sd_setImageWithURL:[NSURL URLWithString:[CachesDirectory getValueByKey:CachesDirectory_MemberInfo_PhotoMid]] placeholderImage:[UIImage imageNamed:@"14"]];
//    [headcell.headimageview addTarget:self action:@selector(headimageAction) forControlEvents:UIControlEventTouchUpInside];
    [headcell.headimageview addTarget:self action:@selector(PersonalinformationViewController) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:headcell];
}



#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSArray *data = [self.dataArrCelltext objectAtIndex:section];
    return data.count;
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
    
    NSArray *data = [self.dataArrCelltext objectAtIndex:indexPath.section];
    NSDictionary *dic = [data objectAtIndex:indexPath.row];
    cell.headimageview.image = [UIImage imageNamed:[dic objectForKey:@"i"]];
    cell.titlelabel.text = [dic objectForKey:@"t"];

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return HeightForRowInSection;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return MINFOLATInSection;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section  {
    return HeightForHeaderInSection;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [self MywalletViewController];
        }else if (indexPath.row==1){
            [self WilltodoViewController];
        }else if (indexPath.row==2){
            [self PublistViewController];
        }else if (indexPath.row==3){
//            [self BaseHQAllertView:SVShowWithBaseHQAllertViewString];
//            [self MyCarController];
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            [self MyContactViewController];
        }else if (indexPath.row==1){
//            [self BaseHQAllertView:SVShowWithBaseHQAllertViewString];
            [self PingJia];
        }
    }
    
}

- (void)MyCarController {

    MyCarController *vc = [[MyCarController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)PingJia {

    NSString *evaluateString = [NSString stringWithFormat:@"https://appsto.re/cn/i5gqab.i"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:evaluateString]];
    
}

-(void)MywalletViewController{
    MywalletViewController *VC = [[MywalletViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)PublistViewController{
    MyReleasesViewControllers *VC = [[MyReleasesViewControllers alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)WilltodoViewController{
    WilltodoViewController *VC = [[WilltodoViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)PersonalinformationViewController{
    PersonalinformationViewController *VC = [[PersonalinformationViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)MyContactViewController{
    MyDJYContactViewController *VC = [[MyDJYContactViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
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
            [headcell.headIMG sd_setImageWithURL:[NSURL URLWithString:[responseObject valueForKey:@"PhotoMid"]]];
        }else
        {
            [self.view makeToast:[responseObject valueForKey:@"Msg"]];
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
    }];
}

@end
