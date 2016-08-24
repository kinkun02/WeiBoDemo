//
//  AddFriendsViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/19.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "AddFriendTableViewCell.h"

@interface AddFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imageArray;
    NSArray *titleArray;
    NSArray *scTitleArray;
    UISearchBar *searchBar;
}
@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    self.title = @"添加好友";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"AddFriendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([AddFriendTableViewCell class])];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    
    imageArray = @[[UIImage imageNamed:@"sweep"],[UIImage imageNamed:@"addressbook"]];
    titleArray = @[@"扫一扫",@"通讯录好友"];
    scTitleArray = @[@"扫描二维码名片",@"添加或邀请通讯录中的好友"];
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    searchBar.placeholder = @"搜索好友";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imageArray.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        }
        [cell addSubview:searchBar];
        tableView.rowHeight = 50;
        return cell;
    }else{
        AddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddFriendTableViewCell class])];
        cell.headImageView.image = imageArray[indexPath.row-1];
        cell.titleLabel.text = titleArray[indexPath.row-1];
        cell.scTitleLabel.text = scTitleArray[indexPath.row-1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        tableView.rowHeight = 80;
        return cell;
    }
}


-(void)rightButtonAction:(UIButton *)sender{
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
