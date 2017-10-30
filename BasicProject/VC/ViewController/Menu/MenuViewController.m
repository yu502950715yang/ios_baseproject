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

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTV;

@property (strong, nonatomic) NSArray *menuArray;

@property (assign, nonatomic) NSInteger index;//定时任务的队列 assign表示直接赋值，用于基本数据类型（NSInteger和CGFloat）和C数据类型（入int，float，double，char等）另外还有id类型，这个修饰符不会牵涉到内存管理，但是如果是对象类型，使用此修饰符则可能会导致内存泄漏或EXC_BAD_ACCESS错误。

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏多余cell
    self.menuTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
           _index = [[ZXCCycleTimer shareInstance]addQueueWithTimeInterval:1 Block:^(NSInteger queueId) {
                NSLog(@"每隔一秒调用一次");
            }];
            break;
        case 2://取消定时任务
            [[ZXCCycleTimer shareInstance]removeByIndex:_index];
        default:
            break;
    }
}

#pragma mark 懒加载
- (NSArray *) menuArray {
    if (_menuArray == nil) {
        _menuArray = [NSArray arrayWithObjects:@"判断当前网络状态",@"定时任务",@"取消定时任务", nil];
    }
    return _menuArray;
}

@end
