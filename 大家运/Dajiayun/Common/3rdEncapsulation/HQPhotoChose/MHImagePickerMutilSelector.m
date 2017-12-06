//
//  MHMutilImagePickerViewController.m
//  doujiazi
//
//  Created by Shine.Yuan on 12-8-7.
//  Copyright (c) 2012年 mooho.inc. All rights reserved.
//

#import "MHImagePickerMutilSelector.h"
#import <QuartzCore/QuartzCore.h>

@interface MHImagePickerMutilSelector ()

@end

@implementation MHImagePickerMutilSelector

@synthesize imagePicker;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        pics=[[NSMutableArray alloc] init];
        [self.view setBackgroundColor:[UIColor redColor]];

    }
    return self;
}


+(id)standardSelector
{
    return [[MHImagePickerMutilSelector alloc] init];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count>=2) {
        for (UIView* ii in viewController.view.subviews) {
        }
        [[viewController.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, Windows_WIDTH, 480-131)];
        
        selectedPan=[[UIView alloc] initWithFrame:CGRectMake(0, 480-131, Windows_WIDTH, 131)];
        UIImageView* imv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Windows_WIDTH, 131)];
        [imv setImage:[UIImage imageNamed:@"img_imagepicker_mutilselectbg"]];
        [selectedPan addSubview:imv];
        [imv release];
        
        textlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 13, 300, 14)];
        [textlabel setBackgroundColor:[UIColor clearColor]];
        [textlabel setFont:[UIFont systemFontOfSize:14.0f]];
        [textlabel setTextColor:[UIColor lightGrayColor]];
        [textlabel setText:@"当前选中0张(最多10张)"];
        
        if ([[NSString stringWithFormat:@"%@",self.Allnum] isEqualToString:@"(null)"]) {
        }else{
            int num = [self.Allnum intValue];
            [textlabel setText:[NSString stringWithFormat:@"当前选中0张(最多还可选择%i张)",9-num]];
        }
        [selectedPan addSubview:textlabel];
        [textlabel release];
        
        
        
        UIButton *Btn_out = [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn_out setFrame:CGRectMake(530/2, 5, 47, 31)];

        [Btn_out setBackgroundImage:[UIImage imageNamed:@"button_m"] forState:UIControlStateNormal];
        Btn_out.tintColor=[UIColor whiteColor];
        [Btn_out setTitle:@"完成" forState:UIControlStateNormal];
        [Btn_out addTarget:self action:@selector(doneHandler) forControlEvents:UIControlEventTouchUpInside];
        [selectedPan addSubview:Btn_out];            
        
        tbv=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 90, Windows_WIDTH) style:UITableViewStylePlain];
        
        tbv.transform=CGAffineTransformMakeRotation(M_PI * -90 / 180);
        tbv.center=CGPointMake(160, 131-90/2);
        [tbv setRowHeight:100];
        [tbv setShowsVerticalScrollIndicator:NO];
        [tbv setPagingEnabled:YES];
        
        tbv.dataSource=self;
        tbv.delegate=self;
        
        [tbv setBackgroundColor:[UIColor clearColor]];
        
        
        [tbv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [selectedPan addSubview:tbv];
        [tbv release];
        
        [viewController.view addSubview:selectedPan];
        [selectedPan release];
    }else{
        [pics removeAllObjects];
        
        
    }
}

-(void)doneHandler
{
    if (delegate && [delegate respondsToSelector:@selector(imagePickerMutilSelectorDidGetImages:)]) {
        [delegate performSelector:@selector(imagePickerMutilSelectorDidGetImages:) withObject:pics];
    }
    [self close];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pics.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger row=indexPath.row;
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithFrame:CGRectZero];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIView* rotateView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80 , 80)];
        [rotateView setBackgroundColor:[UIColor blueColor]];
        rotateView.transform=CGAffineTransformMakeRotation(M_PI * 90 / 180);
        rotateView.center=CGPointMake(45, 45);
        [cell.contentView addSubview:rotateView];
        [rotateView release];
        
        UIImageView* imv=[[UIImageView alloc] initWithImage:[pics objectAtIndex:row]];
        [imv setFrame:CGRectMake(0, 0, 80, 80)];
        [imv setClipsToBounds:YES];
        [imv setContentMode:UIViewContentModeScaleAspectFill];
        
        [imv.layer setBorderColor:[UIColor whiteColor].CGColor];
        [imv.layer setBorderWidth:2.0f];
        
        [rotateView addSubview:imv];
        [imv release];
        
        UIButton*   btn_delete=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn_delete setFrame:CGRectMake(0, 0, 22, 22)];/*btn_myjiazi_griditem_delete*/
        [btn_delete setImage:[UIImage imageNamed:@"red_wrong"] forState:UIControlStateNormal];
        [btn_delete setCenter:CGPointMake(70, 10)];
        [btn_delete addTarget:self action:@selector(deletePicHandler:) forControlEvents:UIControlEventTouchUpInside];
        [btn_delete setTag:row];
        
        [rotateView addSubview:btn_delete];
    }
    
    return cell;
}

-(void)deletePicHandler:(UIButton*)btn
{
    [pics removeObjectAtIndex:btn.tag];
    [self updateTableView];
}

-(void)updateTableView
{
    textlabel.text=[NSString stringWithFormat:@"当前选中%lu张(最多10张)",(unsigned long)pics.count];
    
    if ([[NSString stringWithFormat:@"%@",self.Allnum] isEqualToString:@"(null)"]) {
    }else{
        int num = [self.Allnum intValue];
        textlabel.text= [NSString stringWithFormat:@"当前选中%lu张(还可以选%lu张)",(unsigned long)pics.count,9-num-pics.count];
    }
    
    [tbv reloadData];
    
    if (pics.count>3) {
        CGFloat offsetY=tbv.contentSize.height-tbv.frame.size.height-(Windows_WIDTH-90);
        [tbv setContentOffset:CGPointMake(0, offsetY) animated:YES];
    }else{
        [tbv setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

    if ([[NSString stringWithFormat:@"%@",self.Allnum] isEqualToString:@"(null)"]) {
    }
    else{
        
        int num = [self.Allnum intValue];
        
        if (pics.count>=9-num) {
            return;
        }
        
    }
    if (pics.count>=10) {
        return;
    }
    
    [pics addObject:image];
    [self updateTableView];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self close];
}

-(void)close
{
    [imagePicker dismissModalViewControllerAnimated:YES];
    [self release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc
{
    [delegate release],delegate=nil;
    [pics release];
    [imagePicker release],imagePicker=nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
