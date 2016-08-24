//
//  CommonViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/10.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
}
@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    dataArray = @[@[@"阅读模式",@"字体大小",@"显示备注"],@[@"图片浏览设置",@"视频自动播放"],@[@"声音"],@[@"多语言环境"]];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = dataArray[section];
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *array = dataArray[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            cell.accessoryView = [UISwitch new];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.accessoryView = [UISwitch new];
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
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
