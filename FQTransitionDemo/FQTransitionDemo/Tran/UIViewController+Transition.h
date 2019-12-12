//
//  UIViewController+Transition.h
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "TransitionManager.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Transition)

@property(nonatomic,strong) TransitionManager   *tranManager;

@end

NS_ASSUME_NONNULL_END
