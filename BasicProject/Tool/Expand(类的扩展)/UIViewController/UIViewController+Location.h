//
//  UIViewController+Location.h
//  BasicProject
//
//  Created by 余洋 on 2017/10/31.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UIViewController (Location) <CLLocationManagerDelegate>

/**
 获取当前地理位置信息
 */
- (void)getLocationInfo;

@end
