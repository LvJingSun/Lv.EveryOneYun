//
//  NewFriendsAdressListViewController.m
//  Dajiayun
//
//  Created by fenghq on 16/3/28.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "NewFriendsAdressListViewController.h"
#import "XHJAddressBook.h"
#import  "PersonModel.h"
#import "PersonCell.h"

#import "AddFriendViewController.h"
#import "ChatViewController.h"

@interface NewFriendsAdressListViewController ()<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>
{
    BOOL IsNOfriend;
}
@property(nonatomic,strong)NSMutableArray *listContent;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@property (strong, nonatomic) PersonModel *people;

@property(nonatomic,strong)NSMutableArray *attentionInfo;

@end

@implementation NewFriendsAdressListViewController
{
    
    UITableView *_tableShow;
    XHJAddressBook *_addBook;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title=@"新朋友";
    _sectionTitles=[NSMutableArray new];
    _attentionInfo=[[NSMutableArray alloc]initWithCapacity:0];
    _tableShow=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Windows_WIDTH, Windows_HEIGHT)];
    _tableShow.delegate=self;
    _tableShow.dataSource=self;
    [self.view addSubview:_tableShow];
    [self setExtraCellLineHidden:_tableShow];
    _tableShow.sectionIndexBackgroundColor=[UIColor clearColor];
    _tableShow.sectionIndexColor = [UIColor blackColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self initData];

        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          [self setTitleList];
                          [_tableShow reloadData];
                      });
    });
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (IsNOfriend) {
        [self BaseHQAllertView:@"数据为空或通讯录权限拒绝访问，请到系统开启"];
    }
}



-(void)setTitleList
{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]];
    NSMutableArray * existTitles = [NSMutableArray array];
    for(int i=0;i<[_listContent count];i++)//过滤 就取存在的索引条标签
    {
        PersonModel *pm=_listContent[i][0];
        for(int j=0;j<_sectionTitles.count;j++)
        {
            if(pm.sectionNumber==j)
                [existTitles addObject:self.sectionTitles[j]];
        }
    }
    
    
    
    
    [self.sectionTitles removeAllObjects];
    self.sectionTitles =existTitles;
    
}


-(NSMutableArray*)listContent
{
    if(_listContent==nil)
    {
        _listContent=[NSMutableArray new];
    }
    return _listContent;
}
-(void)initData
{
    _addBook=[[XHJAddressBook alloc]init];
    self.listContent=[_addBook getAllPerson];
    if(_listContent==nil)
    {
        IsNOfriend = YES;
        NSLog(@"数据为空或通讯录权限拒绝访问，请到系统开启!");
        return;
    }
    NSLog(@"%@",_listContent);
    [self requestContactsList:[self toContactString]];

    
}

//几个  section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listContent count];
    
}
//对应的section有多少row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_listContent objectAtIndex:(section)] count];
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//section的高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(self.sectionTitles==nil||self.sectionTitles.count==0)
        return nil;
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"uitableviewbackground"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    NSString *sectionStr=[self.sectionTitles objectAtIndex:(section)];
    [label setText:sectionStr];
    [contentView addSubview:label];
    return contentView;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfer=@"addressCell";
    PersonCell *personcell=(PersonCell*)[tableView dequeueReusableCellWithIdentifier:cellIdenfer];
    if(personcell==nil)
    {
        personcell=[[PersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfer];
    }
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    _people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    [personcell setData:_people];
    
    __block NSInteger Index=0;
    [_listContent enumerateObjectsUsingBlock:^( NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx>=indexPath.section) {
            *stop=YES;
        }else{
        Index = Index+obj.count;
        }
    }];
    Index = Index+indexPath.row;
    if (Index<self.attentionInfo.count) {
        NSDictionary *Contact = self.attentionInfo[Index];
        [personcell setactionBtn:Contact];
        personcell.actonBtn.tag = Index;
        [personcell.actonBtn addTarget:self action:@selector(actionBtnFromType:) forControlEvents:UIControlEventTouchUpInside];
    }

    
    return personcell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


//开启右侧索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//新朋友【通讯录搜索】
- (void)requestContactsList:(NSString *)contacts{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID],@"memberId",
                            [CachesDirectory getServerKey],@"key",
                            contacts, @"contacts",
                            nil];
    [AFCustomClient requestSameWithHttpMethod:HttpMethodPost URLStr:@"MemberInfoWebService.asmx/ContactsList_1" params:params networkBlock:^{
    } successBlock:^(AFCustomClient *request, NSJSONSerialization *responseObject) {
        if ([self isSuccess:responseObject showSucces:NO showError:YES]) {
            _attentionInfo = [responseObject valueForKey:@"attentionInfo"];
            [_tableShow reloadData];
        }
    } failedBlock:^(AFCustomClient *request, NSError *error) {
        [self.view makeToast:error.localizedDescription];
    }];
}


- (NSString *)toContactString{
    NSString *ContactString = @"";
    NSMutableArray *ContactArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<_listContent.count; i++) {
        NSArray *Contact = _listContent[i];
        for (int j=0; j<Contact.count; j++) {
           PersonModel *pm = Contact[j];
            NSString *P = [NSString stringWithFormat:@"%@,%@",pm.phonename,pm.tel];
            [ContactArr addObject:P];
        }
    }
    if (ContactArr.count) {
        ContactString = [ContactArr componentsJoinedByString:@"|"];
        ContactString = [NSString stringWithFormat:@"【%@】",ContactString];
    }
    return ContactString;
}

- (void)actionBtnFromType:(UIButton *)Sender{
    
    NSInteger Index = Sender.tag;
    if (Index<self.attentionInfo.count) {
        NSDictionary *Contact = self.attentionInfo[Index];
        if ([Contact[@"Type"] isEqualToString:@"1"]) {
            AddFriendViewController *addController = [[AddFriendViewController alloc] initWithStyle:UITableViewStylePlain];
            addController.ScanAddFriendPhone = Contact[@"Phone"];
            [self.navigationController pushViewController:addController animated:YES];
        }else if ([Contact[@"Type"] isEqualToString:@"2"]){
            NSString *MemberId = [NSString stringWithFormat:@"%@",[Contact objectForKey:@"OtmemId"]];
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:MemberId conversationType:eConversationTypeChat];
            chatController.title = MemberId;
            [self.navigationController pushViewController:chatController animated:YES];
        }else if ([Contact[@"Type"] isEqualToString:@"3"]){
            [self showMessageView:[NSString stringWithFormat:@"%@",[Contact objectForKey:@"Phone"]] title:[NSString stringWithFormat:@"邀请%@",[Contact objectForKey:@"NickName"]] body:@"推荐你使用【大家运】一款专门做汽车物流的APP，为广大物流车司机、商品车车主和物流公司提供一个便捷的信息交流平台。https://itunes.apple.com/us/app/da-jia-yun/id1077964360?l=zh&ls=1&mt=8"];
        }
    }
    
}

-(void)showMessageView:(NSString *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = @[phones];
        controller.navigationBar.tintColor = [UIColor whiteColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            break;
        default:
            break;
    }
}

@end

