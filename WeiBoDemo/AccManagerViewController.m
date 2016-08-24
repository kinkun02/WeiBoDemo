//
//  AccManagerViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/10.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "AccManagerViewController.h"
#import <UIImageView+YYWebImage.h>
#import "User.h"

@interface AccManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    User *user;
}
@end

@implementation AccManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)setUI{
    dataSource = [NSMutableArray array];
    user = [User shareUser];
    NSString *accName = user.name;
    NSString *defaultName = @"添加账号";
    [dataSource addObject:accName];
    [dataSource addObject:defaultName];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-10)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    cell.imageView.layer.cornerRadius = 22;
    cell.imageView.layer.masksToBounds = YES;
    if (indexPath.row == 0) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholder:[UIImage imageNamed:@"head"]];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"add"];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    
    return cell;
}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
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
