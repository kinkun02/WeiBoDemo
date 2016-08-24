//
//  AppDelegate.m
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/8.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK.h>
#import "MainNavigationViewController.h"
#import "MainTabBarViewController.h"
#import "MyViewController.h"
#import "HomeViewController.h"
#import "IssueViewController.h"
#import "LoginViewController.h"
#import <MBProgressHUD.h>


@interface AppDelegate ()<WeiboSDKDelegate>
{
    
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    _tabBarVC = [MainTabBarViewController new];
    _issueVC = [[MainNavigationViewController alloc]initWithRootViewController:[IssueViewController new]];
    _homeVC = [[MainNavigationViewController alloc]initWithRootViewController:[HomeViewController new]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
        _loginVC = [[MainNavigationViewController alloc]initWithRootViewController:[LoginViewController new]];
        _tabBarVC.viewControllers = @[_homeVC,_issueVC,_loginVC];
    }else{
        _myVC = [[MainNavigationViewController alloc]initWithRootViewController:[MyViewController new]];
        _tabBarVC.viewControllers = @[_homeVC,_issueVC,_myVC];
    }
    
    
    NSArray *names = @[@"首页",@"发布",@"我"];
    NSArray *images = @[[UIImage imageNamed:@"home"],[[UIImage imageNamed:@"arrow-up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"user"]];
    
    for (int i=0; i<_tabBarVC.viewControllers.count; i++) {
        _tabBarVC.viewControllers[i].tabBarItem.title = names[i];
        _tabBarVC.viewControllers[i].tabBarItem.image = images[i];
        if (i == 1) {
            _tabBarVC.viewControllers[i].tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6, 0);
            _tabBarVC.viewControllers[1].tabBarItem.title = nil;
        }
    }
    
    _tabBarVC.tabBar.tintColor = [UIColor orangeColor];
    self.window.rootViewController = _tabBarVC;
    
    //在viewcontrollers之间跳转
//    tabBarVC.selectedIndex= 2;
    self.window.rootViewController = _tabBarVC;
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];

    return YES;
}

//下面两个方法都是被别的应用打开的时候被调用
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}


#pragma mark WeiboSDKDelegate
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSLog(@"收到响应");
    if ([response isMemberOfClass:[WBAuthorizeResponse class]]) {
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        
        self.access_token = authorizeResponse.accessToken;
        self.user_id = authorizeResponse.userID;
        
        NSLog(@"access_token = %@",authorizeResponse.accessToken);
        NSLog(@"user_ID = %@",authorizeResponse.userID);
        
        //保存登录信息
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:authorizeResponse.accessToken forKey:@"accessToken"];
        [userDefaults setObject:authorizeResponse.userID forKey:@"userID"];
        [userDefaults synchronize];
        
        [MBProgressHUD hideHUDForView:_tabBarVC.viewControllers[2].view animated:YES];
        
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            _loginVC = [[MainNavigationViewController alloc]initWithRootViewController:[LoginViewController new]];
            _tabBarVC.viewControllers = @[_homeVC,_issueVC,_loginVC];
            _tabBarVC.viewControllers[2].tabBarItem.title = @"我";
            _tabBarVC.viewControllers[2].tabBarItem.image = [UIImage imageNamed:@"user"];
            _tabBarVC.selectedIndex = 0;
        }
        
    }
}
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"收到请求");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "king.WeiBoDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WeiBoDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WeiBoDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
