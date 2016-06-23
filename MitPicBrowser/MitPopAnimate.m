//
//  popAnimate.m
//  MitPicBrowser
//
//  Created by william on 16/6/22.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import "MitPopAnimate.h"

@interface MitPopAnimate()

@property (nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;

@end


@implementation MitPopAnimate



-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIView * contentVi  = [self.transitionContext containerView];
    
    UIViewController * fromVc = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [contentVi addSubview:toVc.view];
    [contentVi addSubview:fromVc.view];
    
    CGPoint finalPoint = CGPointMake(self.detinFrame.origin.x+ self.detinFrame.size.width*0.5-0, self.detinFrame.origin.y+ self.detinFrame.size.height*0.5 - CGRectGetMaxY(self.detinFrame));
    CGFloat radius = sqrt((finalPoint.x*finalPoint.x) + (finalPoint.y*finalPoint.y));
    
    /** 原来的贝塞尔曲线 */
    UIBezierPath * originalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.detinFrame, -1.5*radius, -1.5*radius)];
    /** 遮盖的贝塞尔曲线 */
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithOvalInRect:self.detinFrame];
    
    /** 7.创建一个 CAShapLayer 来负责展示圆形遮盖 */
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    fromVc.view.layer.mask = maskLayer;
    
    /** 8.创建一个关于 path 的 CABasicAnimation 动画 */
    CABasicAnimation* maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = ((__bridge id)originalPath.CGPath);
    maskLayerAnimation.toValue =((__bridge id)maskPath.CGPath);
    maskLayerAnimation.duration =[self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseIn];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"pingInvert"];
}
#pragma mark ------------------- CABasicAnimation的 Delegate ------------------------
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    /** 1. 告诉系统这个 transition 完成 */
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    /** 2. 清除 fromVc 的 mask */
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}
@end
