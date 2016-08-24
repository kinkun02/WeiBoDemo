//
//  IssueViewController.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/9.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "IssueViewController.h"
#import "AppDelegate.h"
#import "FeedbackViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface IssueViewController ()<CLLocationManagerDelegate>
{
    int index;
    NSArray *dataArray;
    NSArray *imageArray;
    NSString *locationString;
    NSMutableArray *dataSource;
    UILabel *weatherLabel;
    UILabel *dayLabel;
    UILabel *mAndyLabel;
    UILabel *weekLabel;
}
@property (nonatomic,strong)CLLocationManager *lManager;
@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocation];
    [self setUI];
    
}

-(void)setUI{
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    dataArray = @[@"文字",@"照片/视频",@"头条文章",@"签到",@"直播",@"更多"];
    imageArray = @[[UIImage imageNamed:@"word"],[UIImage imageNamed:@"image"],[UIImage imageNamed:@"topline"],[UIImage imageNamed:@"checkin"],[UIImage imageNamed:@"video"],[UIImage imageNamed:@"issue_more"]];
    index = 0;
    float wPadding = SCREEN_WIDTH/5*2/4;
    float hPadding = SCREEN_HEIGHT/12;
    float buttonSize = SCREEN_WIDTH/5;
    
    for (int i= 0; i<2; i++) {
        for (int j=0; j<3; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(wPadding+(j*(buttonSize+wPadding)), (SCREEN_HEIGHT/9*4)+i*(buttonSize+hPadding), buttonSize, buttonSize);
            [button setImage:imageArray[index] forState:UIControlStateNormal];
            button.layer.cornerRadius = buttonSize/2;
            button.layer.masksToBounds = YES;
            button.tag = 200+index;
            [button addTarget:self action:@selector(issueButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(wPadding+(j*(buttonSize+wPadding)), buttonSize+(SCREEN_HEIGHT/9*4)+i*(buttonSize+hPadding), buttonSize, 21)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:15];
            label.text = dataArray[index];
            [self.view addSubview:button];
            [self.view addSubview:label];
            index++;
        }
    }
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44);
    [backButton setImage:[[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backButton];
    
    
    UIImageView *adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-160, hPadding, 140, 115)];
    adImageView.image = [UIImage imageNamed:@"issue_AD"];
    [self.view addSubview:adImageView];
    
    weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, hPadding*2+10, 160, 20)];
    weatherLabel.font = [UIFont systemFontOfSize:15];
    weatherLabel.textColor = [UIColor grayColor];
    [self.view addSubview:weatherLabel];
    
    dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, hPadding-2, hPadding*1.1, hPadding*1.1)];
    dayLabel.font = [UIFont systemFontOfSize:hPadding-8];
    dayLabel.textColor = [UIColor grayColor];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dayLabel];
    
    weekLabel =[[UILabel alloc]initWithFrame:CGRectMake(30+hPadding, hPadding+8, 50, 20)];
    weekLabel.font = [UIFont systemFontOfSize:15];
    weekLabel.textColor = [UIColor grayColor];
    [self.view addSubview:weekLabel];
    
    mAndyLabel = [[UILabel alloc]initWithFrame:CGRectMake(30+hPadding, hPadding*2-25, 80, 20)];
    mAndyLabel.font = [UIFont systemFontOfSize:15];
    mAndyLabel.textColor = [UIColor grayColor];
    [self.view addSubview:mAndyLabel];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分ss秒"];
    NSDate *date11 = [NSDate date];
    NSString *date11String = [formatter stringFromDate:date11];
    NSRange range1 = NSMakeRange(5, 2);
    NSRange range2 = NSMakeRange(8, 2);
    NSString *year = [date11String substringToIndex:4];
    NSString *month = [date11String substringWithRange:range1];
    mAndyLabel.text = [NSString stringWithFormat:@"%@/%@",month,year];
    dayLabel.text = [date11String substringWithRange:range2];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    weekLabel.text=[[[dateFormatter stringFromDate:[NSDate date]] componentsSeparatedByString:@" "] lastObject];
}

-(void)issueButtonAction:(UIButton *)sender{
    if (sender.tag == 200) {
        FeedbackViewController *wordVC = [FeedbackViewController new];
        wordVC.type = IssueViewControllerTypeWord;
        [self.navigationController pushViewController:wordVC animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.lManager stopUpdatingLocation];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backButtonAction:(UIButton *)sender{
    AppDelegate *d = (AppDelegate *)[UIApplication sharedApplication].delegate;
    d.tabBarVC.selectedIndex = 0;
}


-(CLLocationManager *)lManager{
    if (!_lManager) {
        _lManager = [CLLocationManager new];
        _lManager.delegate = self;
        _lManager.distanceFilter = kCLDistanceFilterNone;
        _lManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return _lManager;
}
-(void)startLocation{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.lManager requestWhenInUseAuthorization];
    }
    [self.lManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    dataSource = [NSMutableArray array];
    CLLocation *location = locations.lastObject;
    NSString *longitudeString = [NSString stringWithFormat:@"%.2f",location.coordinate.longitude];
    NSString *latitudeString = [NSString stringWithFormat:@"%.2f",location.coordinate.latitude];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:latitudeString forKey:@"lat"];
    [userDefaults setObject:longitudeString forKey:@"long"];
    [userDefaults synchronize];
    NSLog(@"%@,%@",latitudeString,longitudeString);
    NSString *string = [latitudeString stringByAppendingString:@":"];
    locationString = [string stringByAppendingString:longitudeString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"https://api.thinkpage.cn/v3/weather/now.json?key=km4j022b72libhmm&location=%@&language=zh-Hans&unit=c",locationString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"results"];
        NSDictionary *dictionary = array[0];
        _cityName = dictionary[@"location"][@"name"];
        _weatherText = dictionary[@"now"][@"text"];
        _temperature = dictionary[@"now"][@"temperature"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self setData];
        });
    }];
    [dataTask resume];
}
-(void)setData{
    weatherLabel.text = [NSString stringWithFormat:@"%@:%@ %@℃",_cityName,_weatherText,_temperature];
    
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
