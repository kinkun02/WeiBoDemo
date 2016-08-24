//
//  SettingBeforeViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/9.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "SettingBeforeViewController.h"
#import "SettingViewController.h"

@interface SettingBeforeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
    
}
@end

@implementation SettingBeforeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    self.title = @"设置";
    
    self.tabBarController.tabBar.hidden = YES;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = UICOLOR(242, 242, 242, 1);
    [self.view addSubview:tableView];
    
    dataArray = @[@"通用设置",@"关于微博"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataArray[indexPath.section];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingViewController *settingVC = [SettingViewController new];
    settingVC.title = dataArray[indexPath.section];
    if ([dataArray[indexPath.section] isEqualToString:[NSString stringWithFormat:@"%@",dataArray[0]]]) {
        settingVC.isAbout = NO;
    }else{
        settingVC.isAbout = YES;
    }
    [self.navigationController pushViewController:settingVC animated:YES];
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
