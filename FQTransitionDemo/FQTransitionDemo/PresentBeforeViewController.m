//
//  PresentBeforeViewController.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "PresentBeforeViewController.h"
#import "ImageCollectionViewCell.h"
#import "PresentBehindViewController.h"
#import "UIViewController+Transition.h"

@interface PresentBeforeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong) NSArray   *imageNameArr;

@end

@implementation PresentBeforeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"presenting控制器";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageNameArr = @[@"0.jpg", @"2.jpg", @"4.jpg"];
    CGFloat space = 10.0f;
    CGFloat width = (self.view.bounds.size.width - 4 * space) / 3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, width + 20);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = space;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"reUse"];
    [self.view addSubview:collectionView];
    [collectionView reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reUse" forIndexPath:indexPath];
    
    NSInteger index = indexPath.item % 3;
    cell.imageV.image = [UIImage imageNamed:self.imageNameArr[index]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *imageV = cell.imageV;
    
    PresentBehindViewController *vc = [[PresentBehindViewController alloc] init];
    vc.imageV.image = imageV.image;
    
    TransitionManager *manager = [TransitionManager tranWithTranType:TransitionPresent animationType:TransitionAnimationImage vc:vc];
    manager.beforeView = imageV;
    manager.behindView = vc.imageV;
    self.tranManager = manager;
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
