//
//  LoginViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/9.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "LoginViewController.h"
#import <WeiboSDK.h>
#import "User.h"
#import "MyTableViewCell.h"
#import "SettingAfterViewController.h"
#import <NSObject+YYModel.h>
#import <UIImageView+YYWebImage.h>
#import "WebViewViewController.h"
#import "AddFriendsViewController.h"

@interface LoginViewController ()<WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *imageArray;
    UITableView *tableView;
    User *user;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self initData];
}

-(void)initData{
    dataSource = @[@[@"新的好友",@"微博等级"],@[@"我的相册",@"我的点评",@"我的赞"],@[@"微博支付",@"微博运动"],@[@"粉丝头条",@"粉丝服务"],@[@"草稿箱"],@[@"更多"]];
    
    imageArray = @[
                   @[[UIImage imageNamed:@"new_friend"],[UIImage imageNamed:@"weibo_level"]],
                   @[[UIImage imageNamed:@"my_photo"],[UIImage imageNamed:@"my_comment"],[UIImage imageNamed:@"my_zan"]],
                   @[[UIImage imageNamed:@"weibo_pay"],[UIImage imageNamed:@"weibo_exercise"]],
                   @[[UIImage imageNamed:@"fans_topline"],[UIImage imageNamed:@"fans_serve"]],
                   @[[UIImage imageNamed:@"draft"]],
                   @[[UIImage imageNamed:@"more"]]];
    
    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    NSLog(@"access_token = %@",access_token);
    [WBHttpRequest requestWithAccessToken:access_token url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"uid":uid} delegate:self withTag:@"100"];
}

-(void)setUI{
    self.title = @"我";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStyleDone target:self action:@selector(leftButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    NSArray *array = dataSource[section-1];
    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >= 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        }
        cell.textLabel.text = dataSource[indexPath.section-1][indexPath.row];
        cell.imageView.image = imageArray[indexPath.section-1][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyTableViewCell class])];
        
        [cell.headImage setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholder:[UIImage imageNamed:@"head"]];
        cell.headImage.layer.cornerRadius = 30;
        cell.headImage.layer.masksToBounds = YES;
        cell.nameLabel.text = user.name;
        if ([user.userDescription isEqualToString:@""]) {
            cell.introduceLabel.text = @"简介:暂无介绍";
        }else{
            cell.introduceLabel.text = [NSString stringWithFormat:@"简介:%@",user.userDescription];
        }
        [cell.weiboButton setTitle:[NSString stringWithFormat:@"%@\n微博",user.statuses_count] forState:UIControlStateNormal];
        [cell.attentionButton setTitle:[NSString stringWithFormat:@"%@\n关注",user.friends_count] forState:UIControlStateNormal];
        [cell.fangButton setTitle:[NSString stringWithFormat:@"%@\n粉丝",user.followers_count] forState:UIControlStateNormal];
        [cell.weiboButton addTarget:self action:@selector(weiboButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.attentionButton addTarget:self action:@selector(attentionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fangButton addTarget:self action:@selector(fansButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/u/%@",user.uid];
                WebViewViewController *webView = [WebViewViewController new];
                webView.url = [NSURL URLWithString:url];
                [self.navigationController pushViewController:webView animated:YES];
            }
            
            break;
        case 1:
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                
            }else if (indexPath.row == 2){
                
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                
            }
            break;
        case 4:
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                
            }
            break;
        case 5:
            if (indexPath.row == 0) {
                
            }
            break;
        case 6:
            if (indexPath.row == 0) {
                
            }
        default:
            break;
    }
}

-(void)weiboButtonAction:(UIButton *)sender{
    
}
-(void)attentionButtonAction:(UIButton *)sender{
    
}
-(void)fansButtonAction:(UIButton *)sender{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else{
        return 44;
    }
}


#pragma mark WBHttpRequest
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"results = %@",result);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }else{
        user = [User shareUser];
        [user modelSetWithJSON:dic];
        [tableView reloadData];
    }
}

-(void)leftButtonAction:(UIBarButtonItem *)sender{
    AddFriendsViewController *addFriendVC = [AddFriendsViewController new];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}
-(void)rightButtonAction:(UIBarButtonItem *)sender{
    SettingAfterViewController *settingAfterLoginVC = [SettingAfterViewController new];
    [self.navigationController pushViewController:settingAfterLoginVC animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
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
