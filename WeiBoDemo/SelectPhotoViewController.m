//
//  SelectPhotoViewController.m
//  SelectPhoto
//
//  Created by Ibokan on 16/8/18.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "PhotoModel.h"
#import "PhotoCollectionViewCell.h"
#import <Photos/Photos.h>

@interface SelectPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *dataSource;
    UICollectionView *photoCollectionView;
    NSMutableArray *images;
}

@end

@implementation SelectPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    dataSource = [NSMutableArray array];
    images = [NSMutableArray array];
    [self getAllPhoto];
}

-(void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片选择";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finshAction:)];
    
    //UICollectionViewCell布局类
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //cell之间的最小行间距
    flowLayout.minimumLineSpacing = 10;
    //cell之间的最小纵间距
    flowLayout.minimumInteritemSpacing = 10;
    //cell的大小
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    photoCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    photoCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:photoCollectionView];
    
    [photoCollectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionViewCell class])];
}

-(void)getAllPhoto{
    PHFetchOptions *options = [PHFetchOptions new];
    //返回结果
    PHFetchResult *allPhoto = [PHAsset fetchAssetsWithOptions:options];
    for (int i=0; i<allPhoto.count; i++) {
        //PHAsset对象代表一张图片库资源
        PHAsset *asset = allPhoto[i];
        PHImageManager *manager = [PHImageManager new];
        [manager requestImageForAsset:asset targetSize:CGSizeMake(120, 180) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            PhotoModel *m = [PhotoModel new];
            m.image = result;
            m.isSelected = NO;
            [dataSource addObject:m];
            dispatch_async(dispatch_get_main_queue(), ^{
                [photoCollectionView reloadData];
            });
        }];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.photoImageview.image = [UIImage imageNamed:@"photo"];
        cell.selectView.hidden = YES;
        cell.selectedButton.hidden = YES;
        return cell;
    }
    PhotoModel *m = dataSource[indexPath.row];
    cell.photoImageview.image = m.image;
    cell.selectView.hidden = NO;
    if (m.isSelected) {
        cell.selectView.image = [UIImage imageNamed:@"selected"];
    }else{
        cell.selectView.image = [UIImage imageNamed:@"unselected"];
    }
    cell.selectedButton.hidden = NO;
    cell.selectedButton.selected = m.isSelected;
    cell.selectedBtnClickBlock = ^(BOOL isSelected){
        if (images.count >= 9 && isSelected) {
            NSLog(@"不能选择大于9张图片");
        }else{
            m.isSelected = isSelected;
            if (m.isSelected) {
                [images addObject:m];
            }else{
                [images removeObject:m];
            }
            [collectionView reloadData];
        }
    };
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}






-(void)finshAction:(UIBarButtonItem *)sender{
    self.imageHandle(images);
    [self.navigationController popViewControllerAnimated:YES];
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
