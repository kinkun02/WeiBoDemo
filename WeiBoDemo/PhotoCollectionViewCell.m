//
//  PhotoCollectionViewCell.m
//  SelectPhoto
//
//  Created by Ibokan on 16/8/18.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)selectButtonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.selectedBtnClickBlock(sender.selected);
}

@end
