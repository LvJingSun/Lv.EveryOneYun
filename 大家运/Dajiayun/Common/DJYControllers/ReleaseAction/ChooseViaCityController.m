//
//  ChooseViaCityController.h
//  Dajiayun
//
//  Created by CityAndCity on 16/1/31.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ChooseViaCityController.h"
#import "ViaCityCollectionCell.h"
@interface ChooseViaCityController ()<ZXCollectionCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,Bzwdelegate>
{
    UIView *PickBackgroundView;
    BzwPicker *pick;
    
    //当前修改的途经城市
    NSInteger IndexPathRow;
    NSString *IndexPatAddress;
    NSString *IndexPatCityids;
    
    NSString *BaseAddress;
    NSString *BaseCityids;

}
@property(nonatomic,strong)NSMutableArray * viaCityArr;

@end

@implementation ChooseViaCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viaCityArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.title = @"添加途经城市";
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self drawUI];
    [self collectFootView];
    [self allocAdressPick];

}

-(void)drawUI{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Windows_WIDTH, Windows_HEIGHT-58) collectionViewLayout:flowLayout];
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[ViaCityCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
}

-(void)allocAdressPick{
    
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

- (void)collectFootView{
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DJYXIBTableViewCell" owner:self options:nil];
    DJYXIBTableViewCell9 *cell = (DJYXIBTableViewCell9 *)[nib objectAtIndex:9];
    [self setLayerBorder:cell.titlelabel andcornerRadius:3 andborderWidth:0 andborderColor:UIColorDJYThemecolorsRGB.CGColor];
    [cell.titlelabel addTarget:self action:@selector(saveAdressBack) forControlEvents:UIControlEventTouchUpInside];
    [cell.titlelabel setTitle:@"确定" forState:UIControlStateNormal];
    cell.frame = CGRectMake(0, Windows_HEIGHT-48-5, Windows_WIDTH, 48);
    [self.view addSubview:cell];

}

-(void)rightItemAction:(UIBarButtonItem *)item{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"address",@"",@"cityids", nil];
    [self.viaCityArr addObject:dictionary];
    [self.collectionView reloadData];

}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _viaCityArr.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ViaCityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {

    }
    NSMutableDictionary *citydic = [self.viaCityArr objectAtIndex:indexPath.row];
    cell.tuJingChengShiUITextField.text =citydic[@"address"];
    cell.delegate = self;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((Windows_WIDTH-20)/2, 64);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //        UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //        cell.backgroundColor = [UIColor redColor];
    IndexPathRow = indexPath.row;
    [self btnDown:nil];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)moveImageBtnClick:(ViaCityCollectionCell *)aCell{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:aCell];
    [_viaCityArr removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    IndexPathRow = -1;
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
//取消
-(void)cacleBtn
{
    IndexPathRow = -1;
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
//暂时没做其他操作   仅仅是取消
-(void)okBtn
{
    if (IndexPathRow>=0) {
        NSMutableDictionary *citydic = [self.viaCityArr objectAtIndex:IndexPathRow];
        NSString *Adress = @"";
        NSString *Cityid = @"";
        if (IndexPatAddress.length==0||IndexPatCityids==0) {
            Adress =BaseAddress;
            Cityid =BaseCityids;
        }else{
            Adress =IndexPatAddress;
            Cityid =IndexPatCityids;
        }
        [citydic setObject:Adress forKey:@"address"];
        [citydic setObject:Cityid forKey:@"cityids"];
        [self.viaCityArr replaceObjectAtIndex:IndexPathRow withObject:citydic];
        [self.collectionView reloadData];
    }
    [UIView animateWithDuration:.3f animations:^{
        PickBackgroundView.alpha = 0;
        [pick setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190)];
    }];
}
-(void)didSelete:(NSString *)pro andCity:(NSString *)city andTown:(NSString *)town
{
    IndexPatAddress = [NSString stringWithFormat:@"%@,%@,%@",pro,city,town];

}

-(void)didSelete:(NSString *)ShengId ShiId:(NSString *)city QuId:(NSString *)town;{
    IndexPatCityids = [NSString stringWithFormat:@"%@|%@|%@",ShengId,city,town];
}


-(void)pickerViewtitle:(NSString *)title ShengId:(NSString *)ShengId ShiId:(NSString *)ShiId QuId:(NSString *)QuId;{

    BaseAddress = title;
    BaseCityids = [NSString stringWithFormat:@"%@|%@|%@",ShengId,ShiId,QuId];

}

- (void)saveAdressBack{
    __block NSMutableArray *viacity = [[NSMutableArray alloc]initWithCapacity:0];
    [self.viaCityArr enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj[@"address"] isEqualToString:@""]&&![obj[@"cityids"] isEqualToString:@""]) {
            [viacity addObject:obj];
        }
    }];
    [self POPViewControllerForDictionary:@{@"city":viacity}];
}

@end
