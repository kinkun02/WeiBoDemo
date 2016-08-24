//
//  MyViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/9.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "MyViewController.h"
#import <WeiboSDK.h>
#import <MBProgressHUD.h>
#import "SettingBeforeViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)setUI{
    self.title = @"我";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(pushSettingButton:)];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_WIDTH/2)];
    imageView.image = [UIImage imageNamed:@"my_background"];
    [self.view addSubview:imageView];
    
    UIView *guanzhuView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREEN_WIDTH, 44)];
    guanzhuView.backgroundColor = [UIColor whiteColor];
    UILabel *guanzhuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 44)];
    guanzhuLabel.text = @"关注";
    guanzhuLabel.font = [UIFont systemFontOfSize:20];
    [guanzhuView addSubview:guanzhuLabel];
    UILabel *checkoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(64, 0, 150, 44)];
    checkoutLabel.text = @"快看看大家都在关注谁";
    checkoutLabel.textColor = UICOLOR(166, 166, 166, 1);
    checkoutLabel.font = [UIFont systemFontOfSize:15];
    checkoutLabel.tintColor = [UIColor grayColor];
    [guanzhuView addSubview:checkoutLabel];
    [self.view addSubview:guanzhuView];
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 10, 24, 24)];
    rightImageView.image = [UIImage imageNamed:@"cut"];
    [guanzhuView addSubview:rightImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkoutGuanzhu:)];
    [guanzhuView addGestureRecognizer:tap];
    [self.view addSubview:guanzhuView];
    
    UILabel *jieshaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(guanzhuView.frame)+(SCREEN_HEIGHT-CGRectGetMaxY(guanzhuView.frame))/2-60, SCREEN_WIDTH-120, 60)];
    jieshaoLabel.text = @"登陆后,你的微博,相册,个人资料会显示在这里,展示给他人";
    jieshaoLabel.textColor = [UIColor grayColor];
    jieshaoLabel.numberOfLines = 0;
    jieshaoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jieshaoLabel];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(SCREEN_WIDTH/2-60, CGRectGetMaxY(guanzhuView.frame)+(SCREEN_HEIGHT-CGRectGetMaxY(guanzhuView.frame))/2, 120, 44);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.borderWidth = 1;
    loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:loginButton];
    
}

-(void)loginButtonAction:(UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [super didReceiveMemoryWarning];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"MyViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];
}

-(void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)checkoutGuanzhu:(UITapGestureRecognizer *)sender{
    NSLog(@"单击关注更多人");
}

-(void)pushSettingButton:(UIBarButtonItem *)sender{
    SettingBeforeViewController *settingBeforeVC = [SettingBeforeViewController new];
    [self.navigationController pushViewController:settingBeforeVC animated:YES];
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
