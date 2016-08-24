//
//  NoticeViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/10.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
    UISwitch *switchButton;
}
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI{
    dataArray = @[@[@"接收推送通知"],@[@"@我的",@"评论",@"赞",@"消息",@"群通知",@"未关注人消息",@"新粉丝"],@[@"好友圈微博",@"特别关注微博",@"群微博",@"微博热点"],@[@"免打扰模式",@"截取新信息"]];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    switchButton = [UISwitch new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = dataArray[section];
    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    NSArray *array = dataArray[indexPath.section];
    if (indexPath.section == 1) {
        if (indexPath.row == 3 || indexPath.row == 4) {
            cell.accessoryView = [UISwitch new];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3) {
            cell.accessoryView = [UISwitch new];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = array[indexPath.row];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return @"要开始或关闭微博的推送通知,请在iPhone的\"设置\"-\"通知\"中找到\"微博\"进行设置";
    }else{
        return nil;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"新消息通知";
    }else if (section == 2){
        return @"新微博推送通知";
    }else{
        return nil;
    }
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
