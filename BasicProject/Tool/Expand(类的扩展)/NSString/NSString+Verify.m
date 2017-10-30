//
//  NSString+Verify.m
//  BasicProject
//
//  Created by 余洋 on 2017/10/30.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)

- (BOOL)isValidateWithRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateWithRegex:emailRegex];
}

@end
