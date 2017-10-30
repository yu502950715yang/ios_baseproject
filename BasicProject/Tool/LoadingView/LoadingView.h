//
//  LoadingView.h
//  BasicProject
//
//  Created by 余洋 on 2017/10/30.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic, copy) NSString *loadingInfo;//loading信息

+ (instancetype) shareadInstance;//loading图单例

@end
