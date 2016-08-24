//
//  FeedbackViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/10.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "FeedbackViewController.h"
#import <UIImageView+YYWebImage.h>
#import "User.h"
#import "OtherViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate,UIScrollViewDelegate>
{
    User *user;
    NSArray *imageArray;
    UITextView *theTextView;
    UIView *toolView;
    UILabel *textViewPlaceholder;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(righrButtonAction:)];
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor orangeColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    user = [User shareUser];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 160, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 4, 160, 20)];
    switch (_type) {
        case IssueViewControllerTypeFeedback:
            titleLabel.text = @"发表反馈意见";
            break;
        case IssueViewControllerTypeWord:
            titleLabel.text = @"发微博";
            break;
        case IssueViewControllerTypeTop:
            titleLabel.text = @"";
            break;
        case IssueViewControllerTypeImage:
            titleLabel.text = @"";
            break;
        default:
            break;
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, 160, 20)];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = [UIFont systemFontOfSize:14];
    userNameLabel.textColor = [UIColor grayColor];
    userNameLabel.text = user.name;
    [titleView addSubview:userNameLabel];
    
    self.navigationItem.titleView = titleView;
    
    theTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-70)];
    theTextView.backgroundColor = [UIColor whiteColor];
    theTextView.delegate = self;
    theTextView.textColor = [UIColor grayColor];
//    theTextView.font = [UIFont systemFontOfSize:15];
    theTextView.scrollEnabled = YES;
    theTextView.text = @"  分享新鲜事...";
    [self.view addSubview:theTextView];
    
    toolView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 70)];
    [self.view addSubview:toolView];
    
    UIView *toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 26, SCREEN_WIDTH, 44)];
    toolBarView.backgroundColor = UICOLOR(242, 242, 242, 1);
    [toolView addSubview:toolBarView];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame = CGRectMake(10, 0, 90, 24);
    [locationButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [locationButton setTitle:@"显示位置" forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    locationButton.layer.backgroundColor = UICOLOR(242, 242, 242, 1).CGColor;
    locationButton.layer.cornerRadius = 12;
    locationButton.layer.masksToBounds = YES;
    locationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [locationButton addTarget:self action:@selector(locationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:locationButton];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(SCREEN_WIDTH-70, 0, 60, 24);
    [shareButton setImage:[UIImage imageNamed:@"global"] forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [shareButton setTitle:@"公开" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    shareButton.layer.backgroundColor = UICOLOR(242, 242, 242, 1).CGColor;
    shareButton.layer.cornerRadius = 12;
    shareButton.layer.masksToBounds = YES;
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:shareButton];
    
    
    imageArray = @[[UIImage imageNamed:@"picture"],[UIImage imageNamed:@"@"],[UIImage imageNamed:@"topic"],[UIImage imageNamed:@"emoji"],[UIImage imageNamed:@"add"]];

    for (int i=0; i<imageArray.count; i++) {
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake(SCREEN_WIDTH/11+(i*SCREEN_WIDTH/11*2), 10, 24, 24);
        [Button setImage:imageArray[i] forState:UIControlStateNormal];
        Button.tag = i+100;
        if (i == 0 || i == 1 || i == 2) {
            [Button addTarget:self action:@selector(toolBarSubviewAction:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 3){
            [Button addTarget:self action:@selector(toolBarEmojiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }else if(i == 4){
            [Button addTarget:self action:@selector(toolBarAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        [toolBarView addSubview:Button];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

-(void)leftButtonAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)righrButtonAction:(UIBarButtonItem *)sender{
    
}

-(void)toolBarSubviewAction:(UIButton *)sender{
    if (sender.tag == 100) {
        NSLog(@"1");
    }else if (sender.tag == 101){
        NSLog(@"2");
    }else if(sender.tag == 102){
        NSLog(@"3");
    }
}
-(void)toolBarEmojiButtonAction:(UIButton *)sender{
    NSLog(@"4");
}
-(void)toolBarAddButtonAction:(UIButton *)sender{
    NSLog(@"5");
}


-(void)locationButtonAction:(UIButton *)sender{
    OtherViewController *locationVC = [OtherViewController new];
    locationVC.type = OtherViewControllerTypeForLocation;
    [self.navigationController pushViewController:locationVC animated:YES];
}
-(void)shareButtonAction:(UIButton *)sender{
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    theTextView.text = @"";
    theTextView.textColor = [UIColor blackColor];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([theTextView.text isEqualToString:@""]) {
        theTextView.text = @"  分享新鲜事...";
        theTextView.textColor = [UIColor grayColor];
    }else{
        theTextView.textColor = [UIColor blackColor];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [theTextView resignFirstResponder];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)KeyboardWillShow:(NSNotification *)notification{
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    theTextView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-keyboardFrame.size.height-70);
    toolView.frame = CGRectMake(0, SCREEN_HEIGHT-keyboardFrame.size.height-70, SCREEN_WIDTH, 70);
}
-(void)keyboardWillHide:(NSNotification *)notification{
    theTextView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-70);
    toolView.frame = CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 70);
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
