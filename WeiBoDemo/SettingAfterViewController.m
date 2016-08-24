//
//  SettingAfterViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/10.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "SettingAfterViewController.h"
#import "SettingViewController.h"
#import "AccManagerViewController.h"
#import "NoticeViewController.h"
#import "PrivacyViewController.h"
#import "CommonViewController.h"
#import "FeedbackViewController.h"
#import <WeiboSDK.h>
#import <MBProgressHUD.h>
#import "AppDelegate.h"

@interface SettingAfterViewController ()<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>
{
    NSArray *dataSource;
}
@end

@implementation SettingAfterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    self.title = @"设置";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    dataSource = @[@[@"账号管理",@"账号安全"],@[@"通知",@"隐私",@"通用设置"],@[@"清理缓存",@"意见返馈",@"关于微博"],@[@"退出当前账号"]];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = dataSource[section];
    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *array = dataSource[indexPath.section];
    if (indexPath.section >= 3) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                AccManagerViewController *ACCmanagerVC = [AccManagerViewController new];
                ACCmanagerVC.title = @"账号管理";
                [self.navigationController pushViewController:ACCmanagerVC animated:YES];
            }else if (indexPath.row == 1){
                
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                NoticeViewController *noticeVC = [NoticeViewController new];
                noticeVC.title = @"通知";
                [self.navigationController pushViewController:noticeVC animated:YES];
            }else if (indexPath.row == 1){
                PrivacyViewController *privacyVC = [PrivacyViewController new];
                privacyVC.title = @"隐私";
                [self.navigationController pushViewController:privacyVC animated:YES];
            }else if (indexPath.row == 2){
                CommonViewController *commonVC = [CommonViewController new];
                commonVC.title = @"通用设置";
                [self.navigationController pushViewController:commonVC animated:YES];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                FeedbackViewController *feedbackVC = [FeedbackViewController new];
                feedbackVC.type = IssueViewControllerTypeFeedback;
                [self.navigationController pushViewController:feedbackVC animated:YES];
            }else if (indexPath.row == 2){
                SettingViewController *settingVC = [SettingViewController new];
                settingVC.title = @"关于微博";
                settingVC.isAbout = YES;
                [self.navigationController pushViewController:settingVC animated:YES];
            }
        }
            break;
        case 3:{
            if (indexPath.row == 0) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *affirm = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"] url:@"https://api.weibo.com/oauth2/revokeoauth2" httpMethod:@"POST" params:nil delegate:self withTag:@"102"];
        
                }];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                
                [alertVC addAction:affirm];
                [alertVC addAction:cancel];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

-(void)loginReset{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [super didReceiveMemoryWarning];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"MyViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];
}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    [self loginReset];
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userID"];
}


-(void)viewWillAppear:(BOOL)animated{
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
