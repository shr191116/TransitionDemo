//
//  PresentBehindViewController.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "PresentBehindViewController.h"

@interface PresentBehindViewController ()

@end

@implementation PresentBehindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"被Present控制器";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImage *image = self.imageV.image;
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = width / image.size.width * image.size.height;
    
    self.imageV.frame = CGRectMake(0, 0, width, height);
    self.imageV.center = self.view.center;
    [self.view addSubview:self.imageV];
}

- (UIImageView *)imageV {
    
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    
    return _imageV;
}
@end
