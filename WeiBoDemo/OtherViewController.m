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
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_type) {
        case OtherViewControllerTypeForLocation:{
            return locatiaonData.count+1;
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
            
        default:
            break;
    }
    return nil;
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
