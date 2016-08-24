//
//  AppDelegate.h
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/8.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MainTabBarViewController.h"
#import "MainNavigationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)NSString *access_token;
@property (nonatomic,strong)NSString *user_id;
@property (nonatomic,strong)MainTabBarViewController *tabBarVC;
@property (nonatomic,strong)MainNavigationViewController *issueVC;
@property (nonatomic,strong)MainNavigationViewController *myVC;
@property (nonatomic,strong)MainNavigationViewController *homeVC;
@property (nonatomic,strong)MainNavigationViewController *loginVC;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

