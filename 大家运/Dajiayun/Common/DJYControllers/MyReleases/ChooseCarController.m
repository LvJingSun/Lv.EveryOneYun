//
//  ChooseCarController.m
//  Dajiayun
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "ChooseCarController.h"
#import "CarModel.h"
#import "BrandModel.h"
#import "GMDCircleLoader.h"
#import "SPCCar.h"

@interface ChooseCarController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource> {

    UITableView *leftTableView;
    
    UITableView *rightTableView;
    
    UITableView *searchTableView;
    
    NSString *IconImage;
    
}

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *searchlist;

@property (nonatomic, strong) NSMutableArray *carArr;

@property (nonatomic, strong) NSMutableArray *SPCBrand;

@property (nonatomic, strong) NSArray *CarDataArr;

@property (nonatomic, strong) NSMutableString *searchStr;

@property (nonatomic, strong) NSArray *allName;

@end

@implementation ChooseCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchStr = [NSMutableString stringWithString:@""];
    
    [self requestData];
    
    self.title = @"选择车辆";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    //状态栏和导航栏的高度
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, rectNav.size.height + rectStatus.size.height, self.view.bounds.size.width, 44)];
    
    self.searchBar = searchBar;
    
    searchBar.delegate = self;
    
    searchBar.placeholder = @"请输入车型名称/拼音字母首字";
    
    [self.view addSubview:searchBar];
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), self.view.bounds.size.width * 0.35, self.view.bounds.size.height - CGRectGetMaxY(searchBar.frame)) style:UITableViewStylePlain];
    
    leftTableView.backgroundColor = [UIColor whiteColor];
    
    leftTableView.delegate = self;
    
    leftTableView.dataSource = self;
    
    [self.view addSubview:leftTableView];
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.35 + 1, CGRectGetMaxY(searchBar.frame), self.view.bounds.size.width * 0.65 - 1, self.view.bounds.size.height - CGRectGetMaxY(searchBar.frame)) style:UITableViewStylePlain];
    
    rightTableView.backgroundColor = [UIColor whiteColor];
    
    rightTableView.delegate = self;
    
    rightTableView.dataSource = self;
    
    [self.view addSubview:rightTableView];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"数据加载中..." animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    if ([tableView isEqual:leftTableView]) {
        
        return self.SPCBrand.count;
        
    }else if ([tableView isEqual:rightTableView]) {
        
        return self.carArr.count;

    }else if ([tableView isEqual:searchTableView]) {
        
        return self.searchlist.count;
        
    }else {
    
        return 0;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [rightTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if ([tableView isEqual:leftTableView]) {
        
        static NSString *ID = @"ID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        cell.textLabel.text = ((SPCCar *)self.SPCBrand[indexPath.row]).Name;
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
        
    }else if ([tableView isEqual:rightTableView]) {
    
        static NSString *ID = @"ID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        cell.textLabel.text = ((SPCCar *)self.carArr[indexPath.row]).Name;
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
        
    }else if ([tableView isEqual:searchTableView]) {
    
        static NSString *ID = @"ID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        cell.textLabel.text = self.searchlist[indexPath.row];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
        
    }else {
    
        return nil;
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([tableView isEqual:leftTableView]) {

        NSString *brandName = ((SPCCar *)self.SPCBrand[indexPath.row]).CheID;
        
        NSMutableArray *tempCar = [NSMutableArray array];
        
        for (int i = 0; i < self.CarDataArr.count; i++) {
            
            if ([((SPCCar *)self.CarDataArr[i]).Levels isEqualToString:@"2"] && [((SPCCar *)self.CarDataArr[i]).ParentID isEqualToString:brandName]) {
                
                [tempCar addObject:self.CarDataArr[i]];
                
            }
            
        }
        
        self.carArr = tempCar;
        
        IconImage = ((SPCCar *)self.SPCBrand[indexPath.row]).ImageSrc;
        
        [rightTableView reloadData];
        
    }else if ([tableView isEqual:rightTableView]) {
        
        self.carName1(((SPCCar *)self.carArr[indexPath.row]).Name,IconImage);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([tableView isEqual:searchTableView]) {
        
        NSString *str = self.searchlist[indexPath.row];
        
        NSString *cheid;
        
        NSString *cheid2;
        
        for (int i = 0; i < self.CarDataArr.count; i ++) {
            
            if ([((SPCCar *)self.CarDataArr[i]).Name isEqualToString:str]) {
                
                cheid = ((SPCCar *)self.CarDataArr[i]).ParentID;
                
                cheid2 = ((SPCCar *)self.CarDataArr[i]).CheID;
                
            }
            
        }
        
        if ([cheid isEqualToString:@"0"]) {
            
            for (int i = 0; i < self.CarDataArr.count; i ++) {
                
                SPCCar *car = self.CarDataArr[i];
                
                if ([car.CheID isEqualToString:cheid2]) {
                    
                    IconImage = car.ImageSrc;
                    
                }
            }
            
        }else {
        
            for (int i = 0; i < self.CarDataArr.count; i ++) {
                
                SPCCar *car = self.CarDataArr[i];
                
                if ([car.Levels isEqualToString:@"1"] && [car.CheID isEqualToString:cheid]) {
                    
                    IconImage = car.ImageSrc;
                    
                }
            }
            
        }
    
        self.carName1(self.searchlist[indexPath.row],IconImage);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)returnCarName:(ReturnCarName)block {

    self.carName1 = block;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if ([self.searchBar.text isEqualToString:@""]) {
        
        _searchlist = nil;
        
        [searchTableView reloadData];
        
        if (![searchBar isExclusiveTouch]) {
            
            [searchBar resignFirstResponder];
            
        }
        
    }else {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",self.searchBar.text];
        
        _searchlist = [self.allName filteredArrayUsingPredicate:pred];
        
        [searchTableView reloadData];
        
    }
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

    searchBar.showsCancelButton = YES;
    
    searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(searchBar.frame)) style:UITableViewStylePlain];
    
    searchTableView.delegate = self;
    
    searchTableView.dataSource = self;
        
    [self.view addSubview:searchTableView];

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",self.searchBar.text];
    
    _searchlist = [self.allName filteredArrayUsingPredicate:pred];
    
    [searchTableView reloadData];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    if (![searchBar isExclusiveTouch]) {
        
        [searchBar resignFirstResponder];
        
    }
        
    [searchTableView removeFromSuperview];
    
    searchBar.showsCancelButton = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (![self.searchBar isExclusiveTouch]) {
        
        [self.searchBar resignFirstResponder];
        
    }
    
    self.searchBar.showsCancelButton = NO;
}

- (void)requestData {
    
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/GetCheList" params:nil networkBlock:^{
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
        [self.view makeToast:@"没有网络!"];
        
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {

        NSDictionary *dic = (NSDictionary *)responseObject;
        
        NSMutableArray *temp = [NSMutableArray array];
        
        NSMutableArray *temp2 = [NSMutableArray array];
        
        NSArray *array = dic[@"CheDetailModelList"];
        
        for (NSDictionary *dic in array) {
            
            SPCCar *spc = [[SPCCar alloc] init];
            
            [spc setValuesForKeysWithDictionary:dic];
            
            [temp addObject:spc];
            
            [temp2 addObject:spc.Name];
            
        }
        
        self.CarDataArr = temp;
        
        self.allName = temp2;
        
        NSMutableArray *tempBrand = [NSMutableArray array];
        
        for (int i = 0; i < self.CarDataArr.count; i++) {
            
            if ([((SPCCar *)self.CarDataArr[i]).Levels isEqualToString:@"1"]) {
                
                [tempBrand addObject:self.CarDataArr[i]];
                
            }
            
        }
        
        self.SPCBrand = tempBrand;
        
        [leftTableView reloadData];
        
        IconImage = ((SPCCar *)self.SPCBrand[0]).ImageSrc;

        if (!self.carArr) {
            
            NSString *brandName = ((SPCCar *)self.SPCBrand[0]).CheID;
            
            NSMutableArray *tempCar = [NSMutableArray array];
            
            for (int i = 0; i < self.CarDataArr.count; i++) {
                
                if ([((SPCCar *)self.CarDataArr[i]).Levels isEqualToString:@"2"] && [((SPCCar *)self.CarDataArr[i]).ParentID isEqualToString:brandName]) {
                    
                    [tempCar addObject:self.CarDataArr[i]];
                    
                }
                
            }
            
            self.carArr = tempCar;
            
            [rightTableView reloadData];
            
        }
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
        [self.view makeToast:@"请求失败!"];

    }];
        

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
