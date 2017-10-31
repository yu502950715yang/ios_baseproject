//
//  UIViewController+Location.m
//  BasicProject
//
//  Created by 余洋 on 2017/10/31.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "UIViewController+Location.h"
#import "UIView+Addition.h"

@implementation UIViewController (Location)

CLLocationManager *locationManager;

#pragma mark -------------获取地理位置信息-------------
- (void)getLocationInfo {
    [self startLocation];
}

//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        //开始定位
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [locationManager requestAlwaysAuthorization];
        locationManager.distanceFilter = 10.0f;
        [locationManager requestAlwaysAuthorization];
        [locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    CLLocation *newLocation = [locations lastObject];
    NSString *longitude = [NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];//经度
    NSString *latitude = [NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];//纬度
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
        if (!error && placemarks.count > 0) {
            for (CLPlacemark *placeMark in placemarks) {
                NSDictionary *addressDic=placeMark.addressDictionary;
                NSString *state=[addressDic objectForKey:@"State"];
                NSString *city=[addressDic objectForKey:@"City"];
                NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
                NSString *street=[addressDic objectForKey:@"Street"];
                NSString *name = [addressDic objectForKey:@"Name"];
                NSString *locationStr = [[[[state stringByAppendingString:city] stringByAppendingString:subLocality] stringByAppendingString:street] stringByAppendingString:name];
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:longitude,@"longitude",latitude,@"latitude",locationStr,@"locationStr", nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getLoctionMessage" object:nil userInfo:dic];
            }
        } else {
            [self.view lc_showToastMessage:@"获取地理位置信息失败！"];
        }
    }];
}

@end
