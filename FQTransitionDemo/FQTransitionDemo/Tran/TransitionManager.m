//
//  TransitionManager.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "TransitionManager.h"
#import "UIViewController+Transition.h"
#import "ImageAnimation.h"

@interface TransitionManager ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property(nonatomic,assign) TransitionType   tranType;

@property(nonatomic,assign) TransitionAnimationType   tranAnimationType;

@property(nonatomic,assign) BOOL   isInteracting;

@property(nonatomic,weak) UIViewController   *vc;

@property(nonatomic,weak) id primaryDelegate;

@end

@implementation TransitionManager


+ (instancetype)tranWithTranType:(TransitionType)tranType animationType:(TransitionAnimationType)animationType vc:(UIViewController *)vc {
    
    if (!vc) return nil;
    if (tranType == TransitionPush && !vc.navigationController) return nil;
    
    TransitionManager *tranManager;
    
    if (vc.tranManager && vc.tranManager.tranType == tranType && vc.tranManager.tranAnimationType == animationType) {
        //使用已有tranManager
        tranManager = vc.tranManager;
    }else {
        //新建
        tranManager = [[TransitionManager alloc] init];
        tranManager.tranType = tranType;
        tranManager.tranAnimationType = animationType;
    }
    tranManager.vc = vc;
    [tranManager settingDelegate];
    
    return tranManager;
}

#pragma mark Push/Present后,还原代理, 给下一个控制器添加边缘清扫手势
- (void)dealWithCompleteWithViewController:(UIViewController *)controller {
    
    NSLog(@"转场结束,添加手势");
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgeGesPan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [controller.view addGestureRecognizer:edgeGes];
    
    if (self.tranType == PushType) {
        UINavigationController *nav = controller.navigationController;
        [nav.interactivePopGestureRecognizer requireGestureRecognizerToFail:edgeGes];
    }else {
        
        //iOS13 后图层会发生变化,并且系统会给presentedView添加一个拖拽手势
        if (@available(iOS 13.0, *)) {
            NSArray<UIGestureRecognizer *> *arr = controller.presentationController.presentedView.gestureRecognizers;
            if (arr.firstObject != edgeGes) {
                [arr.firstObject requireGestureRecognizerToFail:edgeGes];
            }
            
        }
    }
}

#pragma mark 手势
-(void)edgeGesPan:(UIPanGestureRecognizer *)edgeGes{
    
    CGPoint translation = [edgeGes translationInView:edgeGes.view];
    
    CGFloat percent;
    
    CGFloat percentX = translation.x / edgeGes.view.bounds.size.width;
    CGFloat percentY = translation.y / edgeGes.view.bounds.size.height;
    
    percent = MAX(percentX, percentY);
    percent = MIN(0.99, MAX(0.0, percent));
    
    switch (edgeGes.state) {
        case UIGestureRecognizerStateBegan:{
            self.isInteracting =  YES;
            NSLog(@"手势触发,开始转场");
            
            if (self.tranType == PushType) {
                [self.vc.navigationController popViewControllerAnimated:YES];
            }else {
                [self.vc dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            
            [self updateInteractiveTransition:percent];
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            
            self.isInteracting = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            NSLog(@"手势结束,转场结束");
            break;
        }
        default:
            break;
    }
}

#pragma mark 还原代理
- (void)restoreDelegate {
    
    if (self.tranType == PushType) {
        self.vc.navigationController.delegate = self.primaryDelegate;
    }else {
        self.vc.transitioningDelegate = self.primaryDelegate;
    }
}

#pragma mark 设置代理
- (void)settingDelegate {
    
    if (self.tranType == TransitionPush) {
        self.primaryDelegate = self.vc.navigationController.delegate;
        self.vc.navigationController.delegate = self;
    }else {
        self.primaryDelegate = self.vc.transitioningDelegate;
        self.vc.transitioningDelegate = self;
    }
}

#pragma mark   --UINavigationControllerDelegate--

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController API_AVAILABLE(ios(7.0)) {
    
    if (self.isInteracting && [animationController isKindOfClass:[TransitionAnimation class]]) {
        return self;
    }else {
        return nil;
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  API_AVAILABLE(ios(7.0)) {
    
    TransitionAnimation *tranAnimation;
    
    if ((operation == UINavigationControllerOperationPush && [fromVC isKindOfClass:[self.vc class]]) ||  (operation == UINavigationControllerOperationPop && [toVC isKindOfClass:[self.vc class]])) {
        
        if (self.tranAnimationType == TransitionAnimationImage) {
            NSLog(@"生成转场动画");
            ImageAnimation *animation = [[ImageAnimation alloc] init];
            animation.beforeView = self.beforeView;
            animation.behindView = self.behindView;
            tranAnimation = animation;
        }
        tranAnimation.animationTime = self.animalTime;
        tranAnimation.type = operation - 1;
        
        if (operation == UINavigationControllerOperationPush) {
            tranAnimation.completeBlock = ^{
                [self dealWithCompleteWithViewController:toVC];
            };
        }
    }
    return tranAnimation;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self.vc class]]) {
        NSLog(@"显示当前控制器时,还原代理");
#warning 注意,不还原代理,当前控制器的侧滑手势会失效, 并且当前控制器正常push其他控制器的侧滑也会失效!
        [self restoreDelegate];
    }
}


#pragma mark   --UIViewControllerTransitioningDelegate--

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    TransitionAnimation *tranAnimation;
    //可扩充动画
    if (self.tranAnimationType == TransitionAnimationImage) {
        ImageAnimation *animation = [[ImageAnimation alloc] init];
        animation.beforeView = self.beforeView;
        animation.behindView = self.behindView;
        tranAnimation = animation;
    }
    tranAnimation.animationTime = self.animalTime;
    tranAnimation.type = PresentType;
    
    tranAnimation.completeBlock = ^{
        [self dealWithCompleteWithViewController:presented];
    };
    return tranAnimation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    TransitionAnimation *tranAnimation;
    
    if (self.tranAnimationType == TransitionAnimationImage) {
        ImageAnimation *animation = [[ImageAnimation alloc] init];
        animation.beforeView = self.beforeView;
        animation.behindView = self.behindView;
        tranAnimation = animation;
    }
    tranAnimation.animationTime = self.animalTime;
    tranAnimation.type = DismissType;
    
    return tranAnimation;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    if (self.isInteracting && [animator isKindOfClass:[TransitionAnimation class]]) {
        return self;
    }
    return nil;
}

- (void)dealloc {
    
    NSLog(@"%@已释放", NSStringFromClass([self class]));
}

@end
