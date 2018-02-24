//
//  ComponentBlock.m
//  BasicProject
//
//  Created by 余洋 on 2018/2/22.
//  Copyright © 2018年 余洋. All rights reserved.
//

#import "ComponentBlock.h"

@implementation ComponentBlock

-(void)setBlockDemo:(BlockType)blockDemo {
    self.blockDemo = blockDemo;
}

-(void)runBlock {
    self.blockDemo(@"测试block");
}

@end
