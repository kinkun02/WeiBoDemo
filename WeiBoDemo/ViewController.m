//
//  ViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/8.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "ViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"

@interface ViewController ()<WBHttpRequestDelegate>
@property (weak, nonatomic) IBOutlet UILabel *access_tokenLabel;
@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    AppDelegate *d = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [d addObserver:self forKeyPath:@"access_token" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"access_token"]) {
        self.access_tokenLabel.text = change[NSKeyValueChangeNewKey];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonAction:(UIButton *)sender {
    [super didReceiveMemoryWarning];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"ViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];
}
- (IBAction)sendMessageAction:(UIButton *)sender {
    //发送微博方法1:通过WBHttpRequest调用openAPI
    NSString *text = self.sendMessageTextField.text;
//    text = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    [WBHttpRequest requestWithAccessToken:self.access_tokenLabel.text url:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:@{@"status":text} delegate:self withTag:@"101"];
    
    
    //方法2:通过WBSendMessageToWeiboRequest向微博客户端发微博
//    WBAuthorizeRequest *authrequest = [WBAuthorizeRequest request];
//    authrequest.redirectURI = kAppRedirectURI;
//    authrequest.scope = @"all";
//    
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageObject] authInfo:authrequest  access_token:self.access_tokenLabel.text];
//    [WeiboSDK sendRequest:request];
}

-(WBMessageObject *)messageObject{
    WBMessageObject *message = [WBMessageObject message];
    message.text = self.sendMessageTextField.text;
    return message;
}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"收到微博的响应,response = %@",response);
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"错误信息,error = %@",error);
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"读取结果,result = %@",result);
}
-(void)dealloc{
    [(AppDelegate *)[UIApplication sharedApplication].delegate removeObserver:self forKeyPath:@"access_token"];
}

@end
