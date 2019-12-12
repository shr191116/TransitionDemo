//
//  ViewController.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "ViewController.h"
#import "PushBeforeViewController.h"
#import "PresentBeforeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)pushAction:(UIButton *)sender {
    
    PushBeforeViewController *vc = [[PushBeforeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)presentAction:(UIButton *)sender {
    PresentBeforeViewController *vc = [[PresentBeforeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
