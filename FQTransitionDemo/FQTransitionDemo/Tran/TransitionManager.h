//
//  TransitionManager.h
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TransitionPush,
    TransitionPresent
} TransitionType;

typedef enum : NSUInteger {
    TransitionAnimationImage    //点击图片跳转
} TransitionAnimationType;

NS_ASSUME_NONNULL_BEGIN

@interface TransitionManager : UIPercentDrivenInteractiveTransition

//前一控制器的视图  TransitionAnimationImage 需要用到
@property (nonatomic, weak) UIView *beforeView;
// 后一控制器的视图, TransitionAnimationImage 需要用到
@property(nonatomic,weak) UIView   *behindView;

/// 动画时间 默认0.35s
@property(nonatomic,assign) NSTimeInterval   animalTime;

/// 转场动画    在push / present 之前调用
/// @param tranType 跳转类型
/// @param animationType 转场动画类型
/*
 TransitionAnimationImage : 需要beforeView 和 behindView
 */
/// @param vc  push:当前控制器   present:  presented 控制器
+ (instancetype)tranWithTranType:(TransitionType)tranType animationType:(TransitionAnimationType)animationType vc:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
