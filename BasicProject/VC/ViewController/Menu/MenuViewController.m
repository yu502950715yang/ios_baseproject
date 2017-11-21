//
//  MenuViewController.m
//  BasicProject
//
//  Created by 余洋 on 2017/10/27.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "MenuViewController.h"
#import "NetworkConnections.h"
#import "ZXCGlobalTimer.h"
#import "UIView+Addition.h"
#import "UIViewController+Location.h"
#import "MenuModel.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTV;

@property (strong, nonatomic) NSMutableArray *menuArray;

@property (assign, nonatomic) NSInteger index;//定时任务的队列 assign表示直接赋值，用于基本数据类型（NSInteger和CGFloat）和C数据类型（入int，float，double，char等）另外还有id类型，这个修饰符不会牵涉到内存管理，但是如果是对象类型，使用此修饰符则可能会导致内存泄漏或EXC_BAD_ACCESS错误。

@property (assign, nonatomic) NSInteger timeIndex;//用于记录定时任务执行了多长时间

@property NSMutableArray *array; //存放需要展开的section序号
@property NSMutableArray *titleArray; //存放需要展开的section序号

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [[NSMutableArray alloc] init];
    //tableview隐藏多余cell
    _menuTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _menuTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"getLoctionMessage" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏navigationbar
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //显示navigationbar
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.menuArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *str = [NSString stringWithFormat:@"%ld",section];
    if ([_array containsObject:str]) {
        return [[self.menuArray[section] valueForKey:@"functionList"] count] + 1;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [self.menuTV dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
        //取消cell点击阴影
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *menuLable = (UILabel *)[cell viewWithTag:101];
        menuLable.text = [self.menuArray[indexPath.section] valueForKey:@"menuTitle"];
        return cell;
    } else {
        UITableViewCell *cell = [self.menuTV dequeueReusableCellWithIdentifier:@"FunctionCell"];
        //取消cell点击阴影
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *menuLable = (UILabel *)[cell viewWithTag:201];
        menuLable.text = [self.menuArray[indexPath.section] valueForKey:@"functionList"][indexPath.row - 1];
        return cell;
    }
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *str = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
        if ([_array containsObject:str]) {
            [_array removeObject:str];
        } else {
            [_array addObject:str];
        }
        [_menuTV reloadData];
    } else {
        switch (indexPath.section) {
            case 0://网络
                {
                    if (indexPath.row == 1) {//判断当前网络状态
                        [[NetworkConnections alloc] netWorkState];
                    }
                }
                break;
            case 1://定时任务
                {
                    if (indexPath.row == 1) {//开始定时任务
                        [self startTimer];
                    } else if (indexPath.row == 2) {//结束定时任务
                         [self stopTimer];
                    }
                }
                break;
            case 2://加载
                {
                    if (indexPath.row == 1) {//加载
                        [self showLoading];
                    }
                }
                break;
            case 3://校验
                {
                    if (indexPath.row == 1) {//跳转校验页面
                        [self goToValidatePage];
                    }
                }
                break;
            case 4://定位
                {
                    if (indexPath.row == 1) {//获取当前地理位置
                        [self getLocationInfo];
                    }
                }
                break;
            case 5://动画
                {
                    if (indexPath.row == 1) {//跑马灯
                        [self goToMarqueeView];
                    }
                }
                break;
            case 6://push动画
                {
                    if (indexPath.row == 1) {//从下到上
                        [self pushFromBottom];
                    }
                }
                break;
            default:
                break;
        }
    }
}

#pragma mark 跳转验证页面
- (void)goToValidatePage {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"ValidateStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ValidateViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)goToMarqueeView {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"AnimationStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MarqueeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushFromBottom {
    CATransition *transition = [CATransition animation];
//    视图控制器出现的方式
//    CA_EXTERN NSString * const kCATransitionFade
//    CA_EXTERN NSString * const kCATransitionMoveIn
//    CA_EXTERN NSString * const kCATransitionPush
//    CA_EXTERN NSString * const kCATransitionReveal
    transition.type = kCATransitionPush;//改变视图控制器出现的方式
//    出现的位置
//    CA_EXTERN NSString * const kCATransitionFromRight
//    CA_EXTERN NSString * const kCATransitionFromLeft
//    CA_EXTERN NSString * const kCATransitionFromTop
//    CA_EXTERN NSString * const kCATransitionFromBottom
    transition.subtype = kCATransitionFromTop;//出现的位置
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"AnimationStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MarqueeViewController"];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark loading展示
- (void)showLoading {
    [self.view showLoadingWithMessage:@"加载中。。。"];
    //3秒后移除loading
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view dismissLoading];
    });
}

#pragma mark 定时任务
/**
 开始定时任务
 */
- (void)startTimer {
    [self.view lc_showToastMessage:@"定时任务开始"];
    _timeIndex = 0;
    _index = [[ZXCCycleTimer shareInstance]addQueueWithTimeInterval:1 Block:^(NSInteger queueId) {
        _timeIndex++;
    }];
}
/**
 取消定时任务
 */
- (void)stopTimer {
    [self.view lc_showToastMessage:[NSString stringWithFormat:@"定时任务执行了%lds",(long)_timeIndex]];
    _timeIndex = 0;
    [[ZXCCycleTimer shareInstance]removeByIndex:_index];
}

#pragma mark 懒加载
- (NSArray *) menuArray {
    if (_menuArray == nil) {
        _menuArray = [[NSMutableArray alloc] init];
        MenuModel *model = [MenuModel new];
        model.menuTitle = @"网络";
        model.functionList = [NSArray arrayWithObjects:@"判断当前网络状态", nil];
        [_menuArray addObject:model];
        MenuModel *model2 = [MenuModel new];
        model2.menuTitle = @"定时任务";
        model2.functionList = [NSArray arrayWithObjects:@"开始定时任务",@"结束定时任务", nil];
        [_menuArray addObject:model2];
        MenuModel *model3 = [MenuModel new];
        model3.menuTitle = @"加载";
        model3.functionList = [NSArray arrayWithObjects:@"loading", nil];
        [_menuArray addObject:model3];
        MenuModel *model4 = [MenuModel new];
        model4.menuTitle = @"校验";
        model4.functionList = [NSArray arrayWithObjects:@"正则校验", nil];
        [_menuArray addObject:model4];
        MenuModel *model5 = [MenuModel new];
        model5.menuTitle = @"系统地理位置";
        model5.functionList = [NSArray arrayWithObjects:@"获取当前地理位置", nil];
        [_menuArray addObject:model5];
        MenuModel *model6 = [MenuModel new];
        model6.menuTitle = @"各种动画效果";
        model6.functionList = [NSArray arrayWithObjects:@"跑马灯", nil];
        [_menuArray addObject:model6];
        MenuModel *model7 = [MenuModel new];
        model7.menuTitle = @"push动画效果";
        model7.functionList = [NSArray arrayWithObjects:@"从下面push", nil];
        [_menuArray addObject:model7];
    }
    return _menuArray;
}

#pragma mark 通知事件
- (void)InfoNotificationAction:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo);
    [self.view lc_showToastMessage:[notification.userInfo valueForKey:@"locationStr"]];
}

@end
