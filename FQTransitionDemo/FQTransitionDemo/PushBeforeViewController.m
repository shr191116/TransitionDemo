//
//  PushBeforeViewController.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "PushBeforeViewController.h"
#import "ImageTableViewCell.h"
#import "UIViewController+Transition.h"
#import "PushBehindViewController.h"
#import "NormalViewController.h"
@interface PushBeforeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PushBeforeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"push控制器";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"reUse"];
    [self.view addSubview:tableView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"正常跳转" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextAction {
    
    NormalViewController *normal = [[NormalViewController alloc] init];
    [self.navigationController pushViewController:normal animated:YES];
}

#pragma mark 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.row % 10;
    NSString *imageName = [NSString stringWithFormat:@"%ld.jpg", index];
    UIImage *image = [UIImage imageNamed:imageName];
    
    return (self.view.bounds.size.width - 100) / image.size.width * image.size.height + 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reUse"];
    NSInteger index = indexPath.row % 10;
    NSString *imageName = [NSString stringWithFormat:@"%ld.jpg", index];
    cell.imageV.image = [UIImage imageNamed:imageName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ImageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PushBehindViewController *behindVC = [[PushBehindViewController alloc] init];
    behindVC.imageV.image = cell.imageV.image;
    
    TransitionManager *tranManager = [TransitionManager tranWithTranType:TransitionPush animationType:TransitionAnimationImage vc:self];
    tranManager.beforeView = cell.imageV;
    tranManager.behindView = behindVC.imageV;
    self.tranManager = tranManager;
    
    [self.navigationController pushViewController:behindVC animated:YES];
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
