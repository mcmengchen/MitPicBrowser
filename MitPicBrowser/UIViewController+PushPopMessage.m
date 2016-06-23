//
//  UIViewController+PushPopMessage.m
//  MitPicBrowser
//
//  Created by william on 16/6/22.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import "UIViewController+PushPopMessage.h"
#import <objc/runtime.h>



@implementation UIViewController (PushPopMessage)
@dynamic pushFrame;
@dynamic popFrame;



-(void)setPopFrame:(CGRect)popFrame{
    NSValue *value = [NSValue value:&popFrame withObjCType:@encode(CGRect)];
    objc_setAssociatedObject(self, @"popFrame", value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGRect)popFrame{
    NSValue *value = objc_getAssociatedObject(self, @"popFrame");
    if(value) {
        CGRect rect;
        [value getValue:&rect];
        return rect;
    }else {
        return CGRectZero;
    }
}


-(void)setPushFrame:(CGRect)pushFrame{
    NSValue *value = [NSValue value:&pushFrame withObjCType:@encode(CGRect)];
    objc_setAssociatedObject(self, @"pushFrame", value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGRect)pushFrame{
    NSValue *value = objc_getAssociatedObject(self, @"pushFrame");
    if(value) {
        CGRect rect;
        [value getValue:&rect];
        return rect;
    }else {
        return CGRectZero;
    }
}


@end
