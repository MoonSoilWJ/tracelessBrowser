//
//  NSString+Category.m
//  Tairong
//
//  Created by yuekewei on 2019/7/10.
//

#import "NSString+YKCategory.h"

@implementation NSString (YKCategory)

- (BOOL)isAvailable {
    if(self && [self isKindOfClass:[NSString class]] && [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0){
        return YES;
    }
    return NO;
}

/**
 正则判断手机号码 1开头，11位号码

 @return BOOL
 */
- (BOOL)isPhoneNumber {
    NSString *phoneRegex = @"1[0-9]{10}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

+ (NSString *)stringForFileSize:(NSInteger)size {
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {
        // 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }
    else if (size < 1024 * 1024) {
        // 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }
    else if (size < 1024 * 1024 * 1024) {
        // 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }
    else {
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}


/**
 RFC3986 编码URL字符串 百分号编码

 @return RFC3986 编码URL字符串
 */
- (NSString *)urlEncodeRFC3986 {
    NSMutableCharacterSet *set = [NSMutableCharacterSet alphanumericCharacterSet];
    [set addCharactersInString:@"-._~"];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];
}
@end
