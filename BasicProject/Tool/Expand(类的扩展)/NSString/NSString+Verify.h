//
//  NSString+Verify.h
//  BasicProject
//
//  Created by 余洋 on 2017/10/30.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

/**
 邮箱校验
 */
- (BOOL)isValidEmail;

/** 手机号码验证 */
- (BOOL)isValidPhoneNum;

/**
 IP格式，xxx.xxx.xxx.xxx
 */
- (BOOL)isValidIP;

/** 工商税号 */
- (BOOL)isValidTaxNo;

/** 身份证验证 */
- (BOOL)isValidIdCardNum;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth maxLenth:(NSInteger)maxLenth containChinese:(BOOL)containChinese firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
@end
