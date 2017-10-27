//
//  MenuViewController.m
//  BasicProject
//
//  Created by 余洋 on 2017/10/27.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "MenuViewController.h"
#import "NetworkConnections.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTV;

@property (strong, nonatomic) NSArray *menuArray;

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
        case 0:
            [[NetworkConnections alloc] netWorkState];//监测网络状态
            break;
            
        default:
            break;
    }
}

#pragma mark 懒加载
- (NSArray *) menuArray {
    if (_menuArray == nil) {
        _menuArray = [NSArray arrayWithObjects:@"判断当前网络状态", nil];
    }
    return _menuArray;
}

//- (UITableView *) menuTV {
//    if (_menuTV == nil) {
//        _menuTV = [UITableView alloc] 
//    }
//}


@end
