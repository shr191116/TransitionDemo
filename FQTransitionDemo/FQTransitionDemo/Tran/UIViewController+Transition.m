//
//  UIViewController+Transition.m
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "UIViewController+Transition.h"
#import <Objc/runtime.h>

static NSString *kTransitionManagerKey = @"transitionManagerKey";

@implementation UIViewController (Transition)

- (void)setTranManager:(TransitionManager *)tranManager {
    
    objc_setAssociatedObject(self, &kTransitionManagerKey, tranManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TransitionManager *)tranManager {
    
   return  objc_getAssociatedObject(self, &kTransitionManagerKey);
}

@end
