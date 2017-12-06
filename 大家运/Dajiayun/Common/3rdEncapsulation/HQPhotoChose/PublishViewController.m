//
//  PublishViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-5-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.


#import "PublishViewController.h"

#import "SVProgressHUD.h"

#import "sys/sysctl.h"

#import "UIImage+fixOrientation.h"

@interface PublishViewController ()

@property (weak, nonatomic) IBOutlet UITextView     *m_contentView;

@property (weak, nonatomic) IBOutlet UILabel        *m_tiShiLabel;

@property (weak, nonatomic) IBOutlet UIButton       *m_shareBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;//滚动图片scrollview;

@property (weak, nonatomic) IBOutlet UIView *Explainview;//说明view.最多9张

@property(nonatomic,strong)NSMutableArray *photoarray;



- (IBAction)shareContent:(id)sender;

@end

@implementation PublishViewController

@synthesize ImageDic;

@synthesize isChoosePhoto;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.photoarray = [[NSMutableArray alloc]initWithCapacity:0];
        
        ImageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isChoosePhoto = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setedgesForExtendedLayoutNO];
    self.m_contentView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    if ( self.m_contentView.text.length == 0 ) {
        
        self.m_tiShiLabel.hidden = NO;
    }
    [self setLayerBorder:self.m_shareBtn andcornerRadius:3 andborderWidth:0 andborderColor:UIColorDJYThemecolorsRGB.CGColor];
    [self.m_shareBtn setBackgroundImage:[self createImageWithColor:UIColorFromRGB(StateHighlightedWhiteButton)] forState:UIControlStateHighlighted];
    [self.m_shareBtn setTitleColor:UIColorDJYThemecolorsRGB forState:UIControlStateHighlighted];
    [self setTitle:@"分享新鲜事"];
    
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editover)]];
    
}

-(void)editover
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.isChoosePhoto = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.m_tiShiLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ( self.m_contentView.text.length == 0 ) {
        
        self.m_tiShiLabel.hidden = NO;
        
    }else{
        
        self.m_tiShiLabel.hidden = YES;
        
    }
}

- (IBAction)shareContent:(id)sender {
    
    [sender setUserInteractionEnabled:NO];
    
    [self.view endEditing:YES];
    if ( self.m_contentView.text.length == 0 ) {
        TTAlertNoTitle(@"请输入要分享的内容");
        return;
    }
    
    if ( self.ImageDic.count == 0 ) {
        [self ImageFromArrayToDic];
    }
    
    // 请求分享内容的接口
    [self Publish:self.m_contentView.text];
    
}

-(IBAction)choseimageBtn:(id)sender
{
    [self.view endEditing:YES];
    
    
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选择", nil];
    
    sheet.tag = 100;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.6f);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte
//拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        //相册
        
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        image = [image fixOrientation];
        
        NSData *imageData = UIImageJPEGRepresentation(image,0.6f);
        
        [self.photoarray addObject:[UIImage imageWithData:imageData]];
        
        [self SetimageToBtn];
        
        [self TidyBtnImage];
        
    }
    
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 0.6f);
}

//循环加到字典中
- (void)ImageFromArrayToDic
{
    
    for (int i = 0; i < self.photoarray.count; i++) {
        
        UIImageView *imgV = [[UIImageView alloc]init];
        
        imgV.image = [self.photoarray objectAtIndex:i];
        
        [self.ImageDic setValue:[self getImageData:imgV] forKey:[NSString stringWithFormat:@"picUrl%d",i]];
        
    }
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==100)
    {
        //打开照相
        if (buttonIndex==0)
        {
            self.isChoosePhoto = YES;
            
            pickerorphoto=1;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                
                self.isChoosePhoto = NO;
                
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            
            self.isChoosePhoto = YES;
            
            pickerorphoto=0;
            
            MHImagePickerMutilSelector* imagePickerMutilSelector=[MHImagePickerMutilSelector standardSelector];//自动释放
            imagePickerMutilSelector.Allnum = [NSString stringWithFormat:@"%lu",(unsigned long)self.photoarray.count];
            
            imagePickerMutilSelector.delegate=self;//设置代理
            
            UIImagePickerController* picker=[[UIImagePickerController alloc] init];
            picker.delegate=imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
            [picker setAllowsEditing:NO];
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            picker.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
            picker.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
            imagePickerMutilSelector.imagePicker=picker;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。
            [self presentModalViewController:picker animated:YES];
            
        }
    }
}

//相册
#pragma mark - Assets Picker Delegate
- (void)imagePickerMutilSelectorDidGetImages:(NSArray *)imageArray
{
    
    NSArray *importItems=[[NSArray alloc] initWithArray:imageArray copyItems:YES];
    
    [self.photoarray addObjectsFromArray:importItems];
        
    [self SetimageToBtn];
    
    [self TidyBtnImage];
    
}

- (void)TidyBtnImage
{
    UIButton * AddBtn  = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 80, 80)];
    AddBtn.center = CGPointMake(55+(95*self.photoarray.count), 55);
    [AddBtn setBackgroundImage:[UIImage imageNamed:@"addicon.png"] forState:UIControlStateNormal];
    [AddBtn addTarget:self action:@selector(choseimageBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *Numlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    Numlabel.center = CGPointMake(35, 10);
    Numlabel.textColor = [UIColor lightGrayColor];
    Numlabel.textAlignment = UITextAlignmentRight;
    [Numlabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [AddBtn addSubview:Numlabel];
    [self.imageScrollView addSubview:AddBtn];
    
    
    if (self.photoarray.count>0&&self.photoarray.count<9) {
        
        self.Explainview.hidden = YES;
        Numlabel.hidden = NO;
        AddBtn.hidden = NO;
        
        Numlabel.text = [NSString stringWithFormat:@"%d/9",self.photoarray.count];
        
        if (self.photoarray.count>=3)
        {
            
            if (self.imageScrollView.contentSize.width == (self.photoarray.count+1)*100) {
                return;
            }
            [self.imageScrollView setContentOffset:CGPointMake((self.photoarray.count+1)*100, 0) animated:NO];
            
            self.imageScrollView.contentSize = CGSizeMake((self.photoarray.count+1)*100, 0);
            
            
        }else
        {
            
            if (self.imageScrollView.contentSize.width == 300) {
                return;
            }
            [self.imageScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            self.imageScrollView.contentSize = CGSizeMake(300,0);
            
        }
        
    }
    else if(self.photoarray.count==9)
    {
        
        AddBtn.hidden = YES;
        self.Explainview.hidden = YES;
        Numlabel.hidden = YES;
        
        if (self.imageScrollView.contentSize.width == self.photoarray.count*100) {
            return;
        }
        
        [self.imageScrollView setContentOffset:CGPointMake(self.photoarray.count*100, 0) animated:NO];
        self.imageScrollView.contentSize = CGSizeMake(self.photoarray.count*100, 0);
        
        
        
    }
    else if(self.photoarray.count==0)
    {
        
        self.Explainview.hidden = NO;
        Numlabel.hidden = YES;
        AddBtn.hidden = NO;
        
        if (self.imageScrollView.contentSize.width == 300) {
            
            return;
        }
        
        [self.imageScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        self.imageScrollView.contentSize = CGSizeMake(300,0);
        
        
    }
    
    
}

- (void) SetimageToBtn
{
    
    for (int i=0; i<self.photoarray.count; i++) {
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((95*(i+1))-80, 15, 80, 80)];
        [btn setBackgroundImage:[self.photoarray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTag:i];
        [self.imageScrollView addSubview:btn];
        
        UIButton *btn_delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_delete setFrame:CGRectMake(0, 0, 25, 25)];
        [btn_delete setImage:[UIImage imageNamed:@"Remove.png"] forState:UIControlStateNormal];
        [btn_delete setCenter:CGPointMake(70, 10)];
        [btn_delete addTarget:self action:@selector(deletePicHandler:) forControlEvents:UIControlEventTouchUpInside];
        [btn_delete setTag:i];
        [btn addSubview:btn_delete];
        
    }
    
    
}

- (void)deletePicHandler:(UIButton*)btn
{
    [self.view endEditing:YES];
    
    for(UIButton * tmpView in self.imageScrollView.subviews)
    {
        if (tmpView.tag !=250) {
            [tmpView removeFromSuperview];
        }
    }
    
    [self.photoarray removeObjectAtIndex:btn.tag];
    [self SetimageToBtn];
    [self TidyBtnImage];
    
}


//发表动态
- (void)Publish:(NSString *)contents{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            @"Source_2",@"source",
                            contents,@"contents",
                            [NSString stringWithFormat:@"%lu",(unsigned long)self.ImageDic.count],@"picCount",
                            @"0",@"longitude",
                            @"0",@"latitude",
                            nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [AFCustomClient requestUploadWithHttpPostWithURLStr:@"DynamicWebService.asmx/DynamicPublish" params:params files:self.ImageDic networkBlock:^{
        [SVProgressHUD dismiss];
        [self.view makeToast:@"暂无网络"];
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        [SVProgressHUD dismiss];
        if ([self isSuccess:responseObject showSucces:YES showError:YES]) {
            if (self.publishdele != nil && [self.publishdele respondsToSelector:@selector(Publishdelegate)]) {
                [self.publishdele Publishdelegate];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
                [self.m_shareBtn setUserInteractionEnabled:YES];
                
            });
        }
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [SVProgressHUD dismiss];
        [self.m_shareBtn setUserInteractionEnabled:YES];
    }];
}

-(void)goBackhalfseconds{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
