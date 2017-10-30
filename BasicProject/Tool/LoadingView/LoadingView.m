//
//  LoadingView.m
//  BasicProject
//
//  Created by 余洋 on 2017/10/30.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "LoadingView.h"
#import <Masonry.h>

@implementation LoadingView{
    UILabel *_loadingInfoLabel;//loading信息label
}

static LoadingView *loadingView;

#pragma mark loading图单例
+ (instancetype)shareadInstance {
    if (loadingView == nil) {
        loadingView = [[LoadingView alloc] init];
    }
    return loadingView;
}

#pragma mark 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        //loading imageView
        UIImageView *loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        [self addSubview:loadingImageView];
        loadingImageView.image = [UIImage imageNamed:@"loading_0"];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 0; i < 15; i++) {
            NSString *imageName = [NSString stringWithFormat:@"loading_%d",i];
            [imageArray addObject:[UIImage imageNamed:imageName]];
        }
        loadingImageView.animationImages = imageArray;
        loadingImageView.animationDuration = 0.6;
        loadingImageView.animationRepeatCount = 0;
        [loadingImageView startAnimating];
        [loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        //说明文本
        _loadingInfoLabel = [[UILabel alloc] init];
        [self addSubview:_loadingInfoLabel];
        _loadingInfoLabel.textAlignment = NSTextAlignmentCenter;
        _loadingInfoLabel.font = [UIFont systemFontOfSize:14];
        _loadingInfoLabel.textColor = [UIColor redColor];
        [_loadingInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(loadingImageView);
            make.top.mas_equalTo(loadingImageView.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(18);
        }];
    }
    return self;
}

#pragma mark 赋值loading说明信息
- (void)setLoadingInfo:(NSString *)loadingInfo{
    _loadingInfo = loadingInfo;
    _loadingInfoLabel.text = _loadingInfo;
}
@end
