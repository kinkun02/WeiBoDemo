//
//  SelectPhotoViewController.h
//  SelectPhoto
//
//  Created by Ibokan on 16/8/18.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImagesHandle) (NSArray *images);

@interface SelectPhotoViewController : UIViewController
@property (nonatomic,copy)ImagesHandle imageHandle;
@end
