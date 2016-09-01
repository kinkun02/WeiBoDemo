//
//  PhotoModel.h
//  SelectPhoto
//
//  Created by Ibokan on 16/8/18.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface PhotoModel : NSObject
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,assign)BOOL isSelected;
@end
