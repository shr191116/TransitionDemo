//
//  TransitionAnimation.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "TransitionAnimation.h"

@implementation TransitionAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return self.animationTime;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    
}

- (NSTimeInterval)animationTime {
    
    if (_animationTime <= 0.1) {
        _animationTime = 0.35;
    }
    return _animationTime;
}

@end
