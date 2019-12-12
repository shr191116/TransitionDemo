//
//  ImageAnimation.h
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import "TransitionAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageAnimation : TransitionAnimation

@property(nonatomic,weak) UIView   *beforeView;

@property(nonatomic,weak) UIView   *behindView;

@end

NS_ASSUME_NONNULL_END
