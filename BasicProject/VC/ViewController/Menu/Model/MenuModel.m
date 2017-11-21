//
//  MenuModel.m
//  BasicProject
//
//  Created by 余洋 on 2017/11/21.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"functionName"]) {
        return [FunctionModel mj_objectArrayWithKeyValuesArray:oldValue];
    }
    return oldValue;
}

@end
