//
//  PhotoCollectionViewCell.h
//  SelectPhoto
//
//  Created by Ibokan on 16/8/18.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedBtnClickBlock)(BOOL isSelected);

@interface PhotoCollectionViewCell : UICollectionViewCell
- (IBAction)selectButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageview;
@property (weak, nonatomic) IBOutlet UIImageView *selectView;
@property (nonatomic,strong)SelectedBtnClickBlock selectedBtnClickBlock;
@end
