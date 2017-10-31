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

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTV;

@property (strong, nonatomic) NSArray *menuArray;

@property (assign, nonatomic) NSInteger index;//定时任务的队列 assign表示直接赋值，用于基本数据类型（NSInteger和CGFloat）和C数据类型（入int，float，double，char等）另外还有id类型，这个修饰符不会牵涉到内存管理，但是如果是对象类型，使用此修饰符则可能会导致内存泄漏或EXC_BAD_ACCESS错误。

@property (assign, nonatomic) NSInteger timeIndex;//用于记录定时任务执行了多长时间

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //tableview隐藏多余cell
    self.menuTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"getLoctionMessage" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.menuTV dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    //取消cell点击阴影
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *menuLable = (UILabel *)[cell viewWithTag:101];
    menuLable.text = self.menuArray[indexPath.row];
    return cell;
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0://监测网络状态
            [[NetworkConnections alloc] netWorkState];
            break;
        case 1://定时任务
            [self startTimer];
            break;
        case 2://取消定时任务
            [self stopTimer];
            break;
        case 3://loading
            [self showLoading];
            break;
        case 4://跳转到验证页面
            [self goToValidatePage];
            break;
        case 5://获取当前地理位置
            [self getLocationInfo];
            break;
        default:
            break;
    }
}

#pragma mark 跳转验证页面
- (void)goToValidatePage {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"ValidateStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ValidateViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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
        _menuArray = [NSArray arrayWithObjects:@"判断当前网络状态",@"定时任务（开始）",@"取消定时任务",@"loading",@"正则校验",@"获取当前地理位置", nil];
    }
    return _menuArray;
}

- (void)InfoNotificationAction:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo);
    [self.view lc_showToastMessage:[notification.userInfo valueForKey:@"locationStr"]];
}

@end
