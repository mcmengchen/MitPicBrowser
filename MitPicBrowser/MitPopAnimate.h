//
//  popAnimate.h
//  MitPicBrowser
//
//  Created by william on 16/6/22.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MitPopAnimate : NSObject<UIViewControllerAnimatedTransitioning>
/** 目标视图 */
@property (nonatomic, assign) CGRect detinFrame;
@end
