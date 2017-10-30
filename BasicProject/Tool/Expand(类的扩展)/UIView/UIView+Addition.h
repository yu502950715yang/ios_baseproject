//
//  UIView+Addition.h
//  BaseProject
//
//  Created by zhangrongbing on 2016/10/12.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#import "NSObject+Current.h"

@interface UIView (Addition)


@property (assign, nonatomic) CGFloat lc_x;
@property (assign, nonatomic) CGFloat lc_y;
@property (assign, nonatomic) CGFloat lc_w;
@property (assign, nonatomic) CGFloat lc_h;
@property (assign, nonatomic) CGFloat lc_b;
@property (assign, nonatomic) CGSize lc_size;
@property (assign, nonatomic) CGPoint lc_origin;
@property (assign, nonatomic) CGPoint lc_center;

-(void)lc_showToastMessage:(NSString*)message;

-(MBProgressHUD*)lc_showHUD;

-(void)lc_setCornerRadius:(CGFloat)radius;

@end
