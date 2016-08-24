//
//  OtherViewController.h
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/22.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "WeiboViewController.h"

typedef NS_ENUM(NSInteger,OtherViewControllerType){
    OtherViewControllerTypeForLocation,
    OtherViewControllerTypeForSharePage,
    OtherViewControllerTypeForSelectPhoto,
    OtherViewControllerTypeForMenition,
    OtherViewControllerTypeForHotTopics
};

@interface OtherViewController : WeiboViewController
@property (nonatomic,assign)OtherViewControllerType type;



@end
