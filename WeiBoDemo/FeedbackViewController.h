//
//  FeedbackViewController.h
//  WeiBoDemo
//
//  Created by Ibokan on 16/8/10.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "WeiboViewController.h"

typedef NS_ENUM(NSInteger,IssueViewControllerType){
    IssueViewControllerTypeWord,
    IssueViewControllerTypeImage,
    IssueViewControllerTypeTop,
    IssueViewControllerTypeFeedback
};

@interface FeedbackViewController : WeiboViewController
@property (nonatomic,assign)IssueViewControllerType type;
@end
