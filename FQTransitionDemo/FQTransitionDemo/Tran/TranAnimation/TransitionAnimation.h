//
//  TransitionAnimation.h
//  FQTransitionDemo
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 FQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PushType,
    PopType,
    PresentType,
    DismissType
} TranType;
NS_ASSUME_NONNULL_BEGIN

@interface TransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

/// 默认 0.35s
@property(nonatomic,assign) NSTimeInterval   animationTime;

//跳转类型
@property(nonatomic,assign) TranType   type;

//完成回调
@property(nonatomic,copy)   void (^ completeBlock)(void);
@end

NS_ASSUME_NONNULL_END
