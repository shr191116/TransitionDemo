//
//  ImageAnimation.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "ImageAnimation.h"

@implementation ImageAnimation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containView = [transitionContext containerView];
    
    UIView *targetImageV;
    UIView *originImageV;
    
    switch (self.type) {
        case PushType:
        case PresentType:
        {
            targetImageV = self.behindView;
            originImageV = self.beforeView;
            [containView addSubview:toView];
        }
            break;
        case PopType:
        case DismissType:
        {
            originImageV = self.behindView;;
            targetImageV = self.beforeView;
            //iOS13后.toview为nil
            if (toView) {
                [containView insertSubview:toView belowSubview:fromView];
            }
        }
            break;
        default:
            break;
    }
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    
    UIView *snapView = [originImageV snapshotViewAfterScreenUpdates:NO];
    CGRect rect = [originImageV convertRect:originImageV.bounds toView:window];
    snapView.frame = rect;
    [containView addSubview:snapView];
    
    targetImageV.hidden = YES;
    originImageV.hidden = YES;
    toView.alpha = 0;
    
    CGRect targetRect = [targetImageV convertRect:targetImageV.bounds toView:window];
    
    [UIView animateWithDuration:self.animationTime animations:^{
        
        [containView layoutIfNeeded];
        
        toView.alpha = 1;
        fromView.alpha = 0;
        
        snapView.frame = targetRect;
    } completion:^(BOOL finished) {
        targetImageV.hidden = NO;
        originImageV.hidden = NO;
        
        fromView.alpha = 1;
        toView.alpha = 1;
        
        [snapView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        if (self.completeBlock) {
            self.completeBlock();
        }
    }];
}

@end
