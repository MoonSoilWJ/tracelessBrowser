//
//  NSString+Category.h
//  Tairong
//
//  Created by yuekewei on 2019/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YKCategory)


/**
 判断字符串不为空

 @return 字符串是否为空
 */
- (BOOL)isAvailable;

/**
 正则判断手机号码 1开头，11位号码
 
 @return BOOL
 */
- (BOOL)isPhoneNumber;

+ (NSString *)stringForFileSize:(NSInteger)size;

/**
 RFC3986 编码URL字符串 百分号编码
 
 @return RFC3986 编码URL字符串
 */
- (NSString *)urlEncodeRFC3986;
@end

NS_ASSUME_NONNULL_END
