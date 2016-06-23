//
//  ViewController.m
//  MitPicBrowser
//
//  Created by william on 16/6/22.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+PushPopMessage.h"
#import "MitPopAnimate.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
/** 数据源 */
@property (nonatomic, strong) NSArray * dataArr;
/** 列表 */
@property (nonatomic, weak) UITableView *table;
/** push 按钮 */
@property (nonatomic, weak) UIButton * popBtn;

@end
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kNavHeight 80

@implementation ViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Mit 图片浏览器";
    self.dataArr = @[@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser",@"花瓣 browser"];
    self.popBtn.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.popBtn.center = self.view.center;
    self.popFrame = self.popBtn.frame;

    [UIView animateWithDuration:1 delay:0.18 usingSpringWithDamping:30 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.popBtn.center = CGPointMake(30, 45);
    } completion:^(BOOL finished) {
        self.table.alpha = 0;
        [self.popBtn setTitle:@"返回" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            self.table.alpha = 1;
        }];
    }];
}
#pragma mark - viewWillAppear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - 创建 -> 创建 push 按钮
-(UIButton *)popBtn{
    if (!_popBtn) {
        UIButton * btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(40, 40, 45, 45);
        btn.backgroundColor = [UIColor colorWithRed:223/255.0 green:107/255.0 blue:93/255.0 alpha:1];
        [btn setTitle:@"开始" forState: UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.layer.cornerRadius = btn.frame.size.height *0.5;
        btn.layer.masksToBounds = true;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _popBtn = btn;
    }
    return _popBtn;
}

#pragma mark - action: Pop
- (void)btnClick:(UIButton *)btn{
    
    [self.view bringSubviewToFront:self.popBtn];

    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.popBtn.center = self.view.center;
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });

    
}


#define SCWIDTH [UIScreen mainScreen].bounds.size.width
#define SCHEIGHT [UIScreen mainScreen].bounds.size.height
#pragma mark - 创建 -> table
-(UITableView *)table{
    if (!_table) {
        
        UITableView * vi = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavHeight, SCWIDTH, SCHEIGHT - kNavHeight) style:UITableViewStylePlain];
        vi.delegate = self;
        vi.dataSource = self;
        vi.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:vi];
        _table = vi;
        
    }
    return _table;
}

#pragma mark ------------------- UITableViewDelegate ------------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    //当顶部下拉和底部上拉的时候不会调用该方法
    if (tableView.contentSize.height - kScreen_Height +kNavHeight> tableView.contentOffset.y ||
        tableView.contentOffset.y < 0) {
        //在刚进入视图的时候
        if (tableView.contentOffset.y == 0) {
            //准备动画
            [self prepareVisibleCellsForAnimationWithRow:indexPath.row andCell:cell];
            //开始动画
            [self animateVisibleCell:cell withRow:indexPath.row];
        }else {
            [self prepareVisibleCellsForAnimationWithRow:1 andCell:cell];
            [self animateVisibleCell:cell withRow:1];
        }
    }
    return cell;
}



#pragma mark - cell 动画
//cell 在最左侧
- (void)prepareVisibleCellsForAnimationWithRow:(NSInteger )row
                                       andCell:(UITableViewCell *)cell{
    
    //1.从左到右渐入动画
    cell.frame = CGRectMake(-kScreen_Width,
                            cell.frame.origin.y,
                            CGRectGetWidth(cell.bounds),
                            CGRectGetHeight(cell.bounds));
    
    cell.alpha = 0.f;
}


//cell 在最右侧
- (void)animateVisibleCell:(UITableViewCell *)cell withRow:(NSInteger)row {
    
    cell.alpha = 1.f;
    
    [UIView animateWithDuration:0.25 delay:0.15 *row usingSpringWithDamping:0.8
          initialSpringVelocity:1.0 options:0 animations:^{
              cell.frame = CGRectMake(0.f, cell.frame.origin.y,
                                      CGRectGetWidth(cell.bounds),
                                      CGRectGetHeight(cell.bounds));
          } completion:^(BOOL finished) {
              
          }];
    
    
    
}


#pragma mark ------------------- UINavigationDelegate ------------------------
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        MitPopAnimate * pop = [MitPopAnimate new];
//        pop.detinFrame = CGRectMake(self.view.center.x, self.view.center.y, self.popBtn.frame.size.width, self.popBtn.frame.size.height);
        pop.detinFrame = self.popFrame;

        return pop;
    }else{
        return nil;
    }
}



@end
