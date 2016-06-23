//
//  WelcomeViewController.m
//  MitPicBrowser
//
//  Created by william on 16/6/22.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UIViewController+PushPopMessage.h"
#import "MitPushAnimate.h"
#import "ViewController.h"
@interface WelcomeViewController ()<UINavigationControllerDelegate>
/** push 按钮 */
@property (nonatomic, weak) UIButton * pushBtn;

@end

@implementation WelcomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:107/255.0 blue:93/255.0 alpha:1];
    self.pushBtn.center = self.view.center;
    self.pushFrame = self.pushBtn.frame;
    
}
#pragma mark - 创建 -> 创建 push 按钮
-(UIButton *)pushBtn{
    if (!_pushBtn) {
        UIButton * btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(40, 40, 45, 45);
        btn.backgroundColor = [UIColor colorWithRed:223/255.0 green:107/255.0 blue:93/255.0 alpha:1];
        btn.layer.cornerRadius = btn.frame.size.height *0.5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.masksToBounds = true;
        [btn setTitle:@"开始" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn = btn;
    }
    return _pushBtn;
}
#define angle2Radion(angle) (angle / 180.0 * M_PI)
#pragma mark - action: 进入下一个界面
- (void)btnClick:(UIButton *)btn{
    ViewController * vc = [[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        MitPushAnimate * push = [MitPushAnimate new];
        push.fromFrame = self.pushFrame;
        return push;
    }else{
        return nil;
    }
}

@end
