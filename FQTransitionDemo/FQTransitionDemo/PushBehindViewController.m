//
//  PushBehindViewController.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "PushBehindViewController.h"
#import "PushNextViewController.h"
@interface PushBehindViewController ()

@end

@implementation PushBehindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"被Push控制器";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = self.imageV.image;
    
    CGFloat width = self.view.bounds.size.width - 20;
    CGFloat height = width / image.size.width * image.size.height;
   
    self.imageV.frame = CGRectMake(10, 10, width, height);
    
    [self.view addSubview:self.imageV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, self.view.bounds.size.height - 300, 100, 100);
    [btn setTitle:@"跳下一个" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height - 200, width, 200)];
    label.numberOfLines = 0;
    label.text = @"吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧吧唧";
    [self.view addSubview:label];
    
}

- (void)nextAction {
 
    PushNextViewController *vc = [[PushNextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIImageView *)imageV {
 
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    
    return _imageV;
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
