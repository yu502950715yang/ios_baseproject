//
//  BlockController.m
//  BasicProject
//
//  Created by 余洋 on 2018/2/22.
//  Copyright © 2018年 余洋. All rights reserved.
//

#import "BlockController.h"

@implementation BlockController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.component = [ComponentBlock new];
        [self.component setBlockDemo:^(NSString *parameter) {
            NSLog(@"%@",parameter);
        }];
    }
    return self;
}

-(void)start {
    [self.component runBlock];
}

@end
