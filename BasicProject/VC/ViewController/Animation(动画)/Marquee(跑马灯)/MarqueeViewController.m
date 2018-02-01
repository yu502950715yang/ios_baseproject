//
//  MarqueeViewController.m
//  BasicProject
//
//  Created by 余洋 on 2017/11/1.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "MarqueeViewController.h"
#import "CQMarqueeView.h"
#import "UIView+frameAdjust.h"

@interface MarqueeViewController ()<CQMarqueeViewDelegate>

@end

@implementation MarqueeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"title", nil);//第一个参数是建（必须）第二个参数是注释（可选）
    CQMarqueeView *marqueeView = [[CQMarqueeView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 30)];
    [self.view addSubview:marqueeView];
    marqueeView.marqueeTextArray = @[@"第一条信息", @"第二条信息" ,@"第三条信息"];
    marqueeView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 跑马灯view上的关闭按钮点击时回调
- (void)marqueeView:(CQMarqueeView *)marqueeView closeButtonDidClick:(UIButton *)sender {
    NSLog(@"点击了关闭按钮");
    [UIView animateWithDuration:1 animations:^{
        marqueeView.height = 0;
    } completion:^(BOOL finished) {
        [marqueeView removeFromSuperview];
    }];
}

@end
