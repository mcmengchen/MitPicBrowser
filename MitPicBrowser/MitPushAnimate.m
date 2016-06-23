//
//  pushAnimate.m
//  MitPicBrowser
//
//  Created by william on 16/6/22.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import "MitPushAnimate.h"
#import "WelcomeViewController.h"
#import "ViewController.h"
@interface MitPushAnimate()

@property (nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;
/** 遮盖图层 */
@property (nonatomic, weak) CAShapeLayer * maskLayer;
/** 起点 */
@property (nonatomic, strong) UIBezierPath *originalPath;
/** 中点 */
@property (nonatomic, strong) UIBezierPath *middlePath;
/** 终点 */
@property (nonatomic, strong) UIBezierPath *maskPath;
/** 零点 */
@property (nonatomic, strong) UIBezierPath * zeroPath;
/** 目标控制器 */
@property (nonatomic, strong) UIViewController * toVc;
/** 源控制器 */
@property (nonatomic, strong) UIViewController * fromVc;
/** <#名称#> */
@property (nonatomic, weak) CAShapeLayer *layer2;
@end

@implementation MitPushAnimate


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    /** 0. 设置上下文 */
    self.transitionContext = transitionContext;

    /** 1.获取来自视图控制器 */
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.fromVc = fromVC;
    /** 2.获取目的的视图控制器 */
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.toVc = toVC;
    
    /** 3.获取动画发生的视图 */
    UIView * contentVi = [transitionContext containerView];
    
    /** 4.将两个界面添加到动画发生的界面上 */
    [contentVi addSubview:fromVC.view];
    [contentVi addSubview:toVC.view];
    
    
    /** 6.创建两个圆形的 贝塞尔曲线,一个是当前点击按钮的大小，一个覆盖整个屏幕的大小,动画在这连个曲线之间进行 */
    //开始点
    self.originalPath  = [UIBezierPath bezierPathWithOvalInRect:self.fromFrame];
    CGPoint finalPoint = CGPointMake(self.fromFrame.origin.x + self.fromFrame.size.width*0.5, self.fromFrame.origin.y + self.fromFrame.size.height*0.5 - CGRectGetMaxY(toVC.view.bounds));
    CGFloat radius = sqrt((finalPoint.x*finalPoint.x) + (finalPoint.y*finalPoint.y));
    //终点
    self.maskPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.fromFrame, -radius,-radius)];

    //中点
    self.middlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.fromFrame, -0.2*radius,-0.2*radius)];
    
    //零点
    self.zeroPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.fromFrame, self.fromFrame.size.width*0.5,self.fromFrame.size.height*0.5)];
    
    /** 7.创建一个 CAShapLayer 来负责展示圆形遮盖 */
    CAShapeLayer * maskLayer= [CAShapeLayer layer];
    maskLayer.path = self.maskPath.CGPath;
    toVC.view.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
    
    
    /** 8.创建一个关于 path 的 CABasicAnimation 动画 */
//    [self startAnimateOne];
    [self startAnimateTwo];

}

#pragma mark ------------------- CABasicAnimation stop 方法 ------------------------
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    
    if (anim == [self.maskLayer animationForKey:@"animateOne"]) {
        [self startAnimateTwo];
    }else{
        /** 1. 告诉系统这个 transition 完成 */
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
        /** 2. 清除 fromVc 的 mask */
        [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    }
}

#pragma mark - action: 添加第一个动画
- (void)startAnimateOne{
    //轮廓动画
    CABasicAnimation * ani2 = [CABasicAnimation animationWithKeyPath:@"path"];
    ani2.fromValue = (__bridge id)self.originalPath.CGPath;
    ani2.toValue = (__bridge id)self.middlePath.CGPath;
//    ani2.duration = 1;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani2.delegate = self;

    //透明度动画
    CABasicAnimation *ani3 = [CABasicAnimation animation];
    ani3.keyPath = @"opacity";
    ani3.fromValue = @1;
    ani3.toValue = @0;
//    ani3.duration = 1;
    ani3.repeatCount = 0;
    ani3.removedOnCompletion = YES;
    ani3.fillMode = kCAFillModeRemoved;
    
    //动画组
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[ani2,ani3];
    group.duration = 0.75;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBackwards;
    group.delegate = self;
    [self.maskLayer addAnimation:group forKey:@"animateOne"];
}


-(void)startAnimateTwo{
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"path"];
    ani.fromValue = (__bridge id)self.originalPath.CGPath;
    ani.toValue = (__bridge id)self.maskPath.CGPath;
    ani.duration = 0.75;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.delegate = self;
    [self.maskLayer addAnimation:ani forKey:@"animateTwo"];
}

@end
