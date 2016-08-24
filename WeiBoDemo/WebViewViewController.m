//
//  WebViewViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/11.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIWebView  MKWebView   应用内部加载网页
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    
    [webView loadRequest:[NSURLRequest requestWithURL:_url]];
    [self.view addSubview:webView];
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
