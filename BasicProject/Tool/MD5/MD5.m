//
//  MD5.m
//  OrderCar
//
//  Created by 余洋 on 2017/8/10.
//  Copyright © 2017年 lovcreate. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto//CommonDigest.h>

@implementation MD5

+ (NSString *) md5:(NSString *)str {
   const char *cStr = [str UTF8String];
   unsigned char digest[CC_MD5_DIGEST_LENGTH];
   CC_MD5(cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
   NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
   for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
   [output appendFormat:@"%02x", digest[i]];
   return output;
}

@end
