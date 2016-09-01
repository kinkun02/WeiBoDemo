//
//  OtherViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/22.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "OtherViewController.h"
#import <WeiboSDK.h>
#import "OtherPageModel.h"
#import <MBProgressHUD.h>

@interface OtherViewController ()<WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *locatiaonData;
    UITableView *locationTableView;
    NSArray *sharePageData;
    UITableView *sharePageTableView;
    UIImageView *selectedImage;
    
}
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (_type) {
        case OtherViewControllerTypeForLocation:{
            locatiaonData =[NSMutableArray array];
            [self setLocationPage];
            locationTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
            locationTableView.delegate = self;
            locationTableView.dataSource = self;
            [self.view addSubview:locationTableView];
            locationTableView.backgroundColor = [UIColor clearColor];
        }
            break;
        case OtherViewControllerTypeForSharePage:{
            sharePageData = @[@[@"公开",@"好友圈",@"仅自己可见"],@[@"选择好友"]];
            [self setSharePage];
            sharePageTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
            sharePageTableView.delegate = self;
            sharePageTableView.dataSource = self;
            sharePageTableView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:sharePageTableView];
        }
            break;
        case OtherViewControllerTypeForMenition:{
            
        }
            break;
        default:
            break;
    }
}

-(void)setLocationPage{
    self.title = @"我在这里";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    
    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
    NSLog(@"%@",access_token);
    [WBHttpRequest requestWithAccessToken:access_token url:@"https://api.weibo.com/2/place/nearby/pois.json" httpMethod:@"GET" params:@{@"lat":[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"],@"long":[[NSUserDefaults standardUserDefaults]objectForKey:@"long"]} delegate:self withTag:@"2000"];
    
}
-(void)setSharePage{
    self.title = @"选择分享范围";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    switch (_type) {
        case OtherViewControllerTypeForLocation:{
            //数据读取
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array = dic[@"pois"];
            for (NSDictionary *D in array) {
                OtherPageModel *localModel = [OtherPageModel new];
                localModel.localTitle = D[@"title"];
                localModel.localCheckingNum = D[@"checkin_user_num"];
                NSString *str1 = D[@"poi_street_address"];
                NSString *str2 = D[@"address"];
                localModel.localAddress = [NSString stringWithFormat:@"%@(%@)",str1,str2];
                [locatiaonData addObject:localModel];
            }
            [locationTableView reloadData];
        }
            break;
            //        case <#constant#>:
            //            <#statements#>
            //            break;
            //        case <#constant#>:
            //            <#statements#>
            //            break;
            //        case <#constant#>:
            //            <#statements#>
            //            break;
            //        case <#constant#>:
            //            <#statements#>
            //            break;
            
        default:
            break;
    }
}


#pragma mark tableView Setting
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (_type) {
        case OtherViewControllerTypeForLocation:{
            return 1;
        }
            break;
        case OtherViewControllerTypeForSharePage:{
            return sharePageData.count;
        }
            
        default:
            break;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_type) {
        case OtherViewControllerTypeForLocation:{
            return locatiaonData.count+1;
        }
            break;
        case OtherViewControllerTypeForSharePage:{
            NSArray *array = sharePageData[section];
            return array.count;
        }
            break;
            
        default:
            break;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_type) {
        case OtherViewControllerTypeForLocation:{
            if (indexPath.row == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
                }
                UISearchBar *searchBar = [UISearchBar new];
                searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
                searchBar.placeholder = @"搜索附近位置";
                [cell addSubview:searchBar];
                locationTableView.rowHeight = 40;
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
                }
                OtherPageModel *localM = locatiaonData[indexPath.row-1];
                cell.textLabel.text = localM.localTitle;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@人来过 位于:%@",localM.localCheckingNum,localM.localAddress];
                locationTableView.rowHeight = 60;
                return cell;
            }
            
        }
            break;
        case OtherViewControllerTypeForSharePage:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
            }
            selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
            selectedImage.layer.cornerRadius = 10;
            selectedImage.layer.masksToBounds = YES;
            selectedImage.layer.borderWidth = 1;
            selectedImage.layer.borderColor = [UIColor grayColor].CGColor;
            
            NSArray *array = sharePageData[indexPath.section];
            cell.textLabel.text = array[indexPath.row];
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = @"所有人可见";
                }else if (indexPath.row == 1){
                    cell.detailTextLabel.text = @"相互关注好友可见";
                }
            }else if (indexPath.section){
                selectedImage.image = [UIImage imageNamed:@"add"];
            }
            cell.accessoryView = selectedImage;
            sharePageTableView.rowHeight = 50;
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_type) {
        case OtherViewControllerTypeForLocation:{
            
        }
            break;
        case OtherViewControllerTypeForSharePage:{
            selectedImage.image = [UIImage imageNamed:@"V"];
        }
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)leftButtonAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
