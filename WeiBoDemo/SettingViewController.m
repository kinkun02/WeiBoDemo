//
//  SettingViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/9.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
{
    UIView *showView;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setUI];
}

-(void)setUI{
    
    showView = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:showView];
    
    if (self.isAbout == NO) {
        [self settingForGeneral];
    }else if(self.isAbout == YES){
        [self setAboutPage];
    }
    
    
    
}

-(void)settingForGeneral{
    UIView *soundView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, 44)];
    soundView.backgroundColor = UICOLOR(255, 255, 255, 1);
    UILabel *soundLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 160, 44)];
    soundLabel.font = [UIFont systemFontOfSize:16];
    soundLabel.text = @"声音";
    UISwitch *soundSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-64, 8, 60, 44)];
    [soundView addSubview:soundLabel];
    [soundView addSubview:soundSwitch];
    [showView addSubview:soundView];
    
    UIView *languageView = [[UIView alloc]initWithFrame:CGRectMake(0, 148, SCREEN_WIDTH, 44)];
    languageView.backgroundColor = UICOLOR(255, 255, 255, 1);
    UILabel *languageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 160, 44)];
    languageLabel.font = [UIFont systemFontOfSize:16];
    languageLabel.text = @"多语言环境";
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, 15, 15, 15)];
    imageView.image = [UIImage imageNamed:@"cut"];
    UILabel *languageTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-135, 0, 100, 44)];
    languageTextLabel.font = [UIFont systemFontOfSize:12];
    [languageView addSubview:languageLabel];
    [languageView addSubview:languageTextLabel];
    [languageView addSubview:imageView];
    [showView addSubview:languageView];
    
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 212, SCREEN_WIDTH, 44)];
    videoView.backgroundColor = UICOLOR(255, 255, 255, 1);
    UILabel *videoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 160, 44)];
    videoLabel.font = [UIFont systemFontOfSize:16];
    videoLabel.text = @"视频自动播放";
    UILabel *videoTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-135, 0, 100, 44)];
    videoTextLabel.font = [UIFont systemFontOfSize:12];
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, 15, 15, 15)];
    imageView1.image = [UIImage imageNamed:@"cut"];
    [videoView addSubview:videoLabel];
    [videoView addSubview:videoTextLabel];
    [videoView addSubview:imageView1];
    [showView addSubview:videoView];
}

-(void)setAboutPage{
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-(SCREEN_WIDTH/14), SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+80)), SCREEN_WIDTH/7, SCREEN_WIDTH/7)];
    logoImageView.image = [UIImage imageNamed:@"Icon-Spotlight-40"];
    
    UILabel *weiboLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+(SCREEN_WIDTH/7+85))), 80, 40)];
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    weiboLabel.font = [UIFont boldSystemFontOfSize:26];
//    weiboLabel.font = [UIFont italicSystemFontOfSize:20];
    weiboLabel.text = @"微博";
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+(SCREEN_WIDTH/7+125))), 80, 20)];
    versionLabel.font = [UIFont systemFontOfSize:14];
    versionLabel.textColor = [UIColor redColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text = @"V 6.8.0";
    
    [showView addSubview:logoImageView];
    [showView addSubview:weiboLabel];
    [showView addSubview:versionLabel];
    
    UIView *gradeView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+(SCREEN_WIDTH/7+150))), SCREEN_WIDTH, 44)];
    gradeView.backgroundColor = UICOLOR(255, 255, 255, 1);
    gradeView.layer.borderWidth = 1;
    gradeView.layer.borderColor = UICOLOR(180, 180, 180, 0.7).CGColor;
    UILabel *gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 160, 44)];
    gradeLabel.textAlignment = NSTextAlignmentLeft;
    gradeLabel.font = [UIFont systemFontOfSize:16];
    gradeLabel.text = @"给我们评分";
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, 15, 15, 15)];
    imageView2.image = [UIImage imageNamed:@"cut"];
    [gradeView addSubview:gradeLabel];
    [gradeView addSubview:imageView2];
    [showView addSubview:gradeView];
    
    UIView *officialView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+(SCREEN_WIDTH/7+194))), SCREEN_WIDTH, 44)];
    officialView.backgroundColor = UICOLOR(255, 255, 255, 1);
//    officialView.layer.borderWidth = 1;
    UILabel *officialLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 160, 44)];
    officialLabel.textAlignment = NSTextAlignmentLeft;
    officialLabel.font = [UIFont systemFontOfSize:16];
    officialLabel.text = @"官方微博";
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, 15, 15, 15)];
    imageView3.image = [UIImage imageNamed:@"cut"];
    [officialView addSubview:officialLabel];
    [officialView addSubview:imageView3];
    [showView addSubview:officialView];
    
    UIView *changjianView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+(SCREEN_WIDTH/7+238))), SCREEN_WIDTH, 44)];
    changjianView.backgroundColor = UICOLOR(255, 255, 255, 1);
    changjianView.layer.borderWidth = 1;
    changjianView.layer.borderColor = UICOLOR(180, 180, 180, 0.7).CGColor;
    UILabel *changjianLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 160, 44)];
    changjianLabel.textAlignment = NSTextAlignmentLeft;
    changjianLabel.font = [UIFont systemFontOfSize:16];
    changjianLabel.text = @"常见问题";
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, 15, 15, 15)];
    imageView4.image = [UIImage imageNamed:@"cut"];
    [changjianView addSubview:changjianLabel];
    [changjianView addSubview:imageView4];
    [showView addSubview:changjianView];
    
    UIImageView *underImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+(SCREEN_WIDTH/7+310))), SCREEN_WIDTH, SCREEN_HEIGHT-(SCREEN_HEIGHT-(SCREEN_HEIGHT-((SCREEN_WIDTH/14)+(SCREEN_WIDTH/7+282)))))];
    underImage.image = [UIImage imageNamed:@"connect"];
    [showView addSubview:underImage];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
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
