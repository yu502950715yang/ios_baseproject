//
//  UIView+Addition.m
//  BaseProject
//
//  Created by zhangrongbing on 2016/10/12.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "UIView+Addition.h"
#import "AppDelegate.h"
#import "LoadingView.h"
#import <Masonry.h>

@implementation UIView (Addition)

-(void)setLc_x:(CGFloat)lc_x{
    CGRect frame = self.frame;
    frame.origin.x = lc_x;
    self.frame = frame;
}

-(CGFloat)lc_x{
    return self.frame.origin.x;
}

-(void)setLc_y:(CGFloat)lc_y{
    CGRect frame = self.frame;
    frame.origin.y = lc_y;
    self.frame = frame;
}

-(CGFloat)lc_y{
    return self.frame.origin.y;
}

-(void)setLc_w:(CGFloat)lc_w{
    CGRect frame = self.frame;
    frame.size.width = lc_w;
    self.frame = frame;
}

-(CGFloat)lc_w{
    return self.frame.size.width;
}

-(void)setLc_h:(CGFloat)lc_h{
    CGRect frame = self.frame;
    frame.size.height = lc_h;
    self.frame = frame;
}

-(CGFloat)lc_h{
    return self.frame.size.height;
}

-(void)setLc_size:(CGSize)lc_size{
    CGRect frame = self.frame;
    frame.size = lc_size;
    self.frame = frame;
}

-(CGSize)lc_size{
    return self.frame.size;
}

-(void)setLc_origin:(CGPoint)lc_origin{
    CGRect frame = self.frame;
    frame.origin = lc_origin;
    self.frame = frame;
}

-(CGPoint)lc_origin{
    return self.frame.origin;
}

-(CGPoint)lc_center{
    return self.center;
}

-(void)setLc_b:(CGFloat)lc_b{
    CGRect frame = self.frame;
    frame.origin.y = lc_b - frame.size.height;
    self.frame = frame;
}

-(CGFloat)lc_b{
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

-(void)setLc_center:(CGPoint)lc_center{
    CGPoint point = self.center;
    point.x = lc_center.x;
    point.y = lc_center.y;
    self.center = point;
}

-(void)lc_showToastMessage:(NSString*)message{
    UIApplication* application = [UIApplication sharedApplication];
    MBProgressHUD* toastHud ;
    if (!toastHud) {
        toastHud = [[MBProgressHUD alloc] initWithView:application.keyWindow];
        toastHud.removeFromSuperViewOnHide = YES;
    }
    toastHud.mode = MBProgressHUDModeText;
    toastHud.label.text = message;
    UIView *keyboard = [NSObject lc_findKeyboard];
    if (keyboard == nil) {
        toastHud.offset = CGPointMake(0, MBProgressMaxOffset);
    } else {
        toastHud.offset = CGPointMake(0, [UIScreen mainScreen].bounds.size.height/2.f - CGRectGetHeight(keyboard.frame) - 90);
    }
    [application.keyWindow addSubview:toastHud];
    [toastHud showAnimated:YES];
    [toastHud hideAnimated:YES afterDelay:1];
}

-(MBProgressHUD*)lc_showHUD{
    UIApplication* application = [UIApplication sharedApplication];
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithFrame:application.keyWindow.bounds];
    hud.removeFromSuperViewOnHide = YES;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [[UIColor grayColor] colorWithAlphaComponent:.4];
    hud.mode = MBProgressHUDModeIndeterminate;
    [application.keyWindow addSubview:hud];
    hud.graceTime = .3f;
    [hud showAnimated:YES];
    return hud;
}

-(void)lc_setCornerRadius:(CGFloat)radius{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}

#pragma mark -----------loading------------
/**
 带提示的loading
 @param message 提示信息
 */
- (void)showLoadingWithMessage:(NSString *)message {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:[LoadingView shareadInstance]];
    [LoadingView shareadInstance].loadingInfo = message;
    [[LoadingView shareadInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

/**
 移除lodaing
 */
- (void)dismissLoading {
    [[LoadingView shareadInstance] removeFromSuperview];
}
@end
