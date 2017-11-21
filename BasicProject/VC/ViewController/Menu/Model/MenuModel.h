//
//  MenuModel.h
//  BasicProject
//
//  Created by 余洋 on 2017/11/21.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionModel.h"
#import "MJExtension.h"

@interface MenuModel : NSObject

@property(nonatomic, strong) NSString *menuTitle;

@property(nonatomic, strong) NSArray<FunctionModel*> *functionList;

@end
