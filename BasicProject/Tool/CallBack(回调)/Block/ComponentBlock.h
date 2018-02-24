//
//  ComponentBlock.h
//  BasicProject
//
//  Created by 余洋 on 2018/2/22.
//  Copyright © 2018年 余洋. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义Block块类型的变量
typedef void(^BlockType) (NSString *parameter);

@interface ComponentBlock : NSObject

//声明Block类型的变量
@property (nonatomic, strong)BlockType blockDemo;

//接受要回调的代码块，把接受的代码块赋给成员变量blockDemo
-(void)setBlockDemo:(BlockType)blockDemo;

//执行代码块的方法
-(void)runBlock;

@end
