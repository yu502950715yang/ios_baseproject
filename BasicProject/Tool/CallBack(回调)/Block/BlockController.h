//
//  BlockController.h
//  BasicProject
//
//  Created by 余洋 on 2018/2/22.
//  Copyright © 2018年 余洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComponentBlock.h"

@interface BlockController : NSObject

-(void)start;

//声明组件
@property (nonatomic, strong) ComponentBlock *component;
@end
