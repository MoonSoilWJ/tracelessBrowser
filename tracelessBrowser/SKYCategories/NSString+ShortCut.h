//
//  NSString+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH
@interface NSString (ShortCut)



/**
 *   用 md5 hash 加密 NSString
 *
 *  @return  返回一个小写字母组成的NSString
 */
- (NSString *)md5String;


/**
 *   用 sha1 hash 加密 NSString
 *
 *  @return  返回一个小写字母组成的NSString
 */
- (NSString *)sha1String;


/**
 *   用 sha224 hash 加密 NSString
 *
 *  @return  返回一个小写字母组成的NSString
 */
- (NSString *)sha224String;


/**
 *   用 sha256 hash 加密 NSString
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)sha256String;

/**
 *   用 sha384 hash 加密 NSString
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)sha384String;

/**
 *   用 sha512 hash 加密 NSString
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)sha512String;

/**
 *   用 md5 算法和键值的 Hmac加密 NSString
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 *   用 sha1 算法和键值的 Hmac加密 NSString
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 *   用sha224算法和键值的 Hmac加密 NSString
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

/**
 *   用sha256算法和键值的 Hmac加密 NSString
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 *   用sha384算法和键值的 Hmac加密 NSString
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

/**
 *   用sha512算法和键值的 Hmac加密 NSString
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

/**
 *   用crc32 Hash加密 NSString
 *
 *  @return 返回一个小写字母组成的NSString
 */
- (NSString *)crc32String;

///=============================================================================
/// @name Encode and decode 编码和解码
///=============================================================================

/**
 *  用 base64编码 NSString
 *
 *  @return 返回一个 NSString
 */
- (NSString *)base64Encoding;

/**
 *   用 base64编码过的NSString 的NSString
 *
 *  @param base64Encoding base64编码过的NSString
 *
 *  @return NSString
 */
+ (NSString *)stringWithBase64Encoding:(NSString *)base64Encoding;




/**
 *  将html代码转为实体
 *
 *  @return "a<b" will be escape to "a&lt;b"
 */
- (NSString *)stringByEscapingHTML;

///=============================================================================
/// @name Utilities
///=============================================================================

/**
 *  返回一个新的UUID字符串(带分割
 *
 *  @return e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
+ (NSString *)stringWithUUID;

/**
 *   清空换行和空格
 *
 *  @return string
 */
- (NSString *) stringByTrim;

/**
 *  判断为空,空字符串,换行或空格
 *
 *  @return  判断为空,空字符串,换行或空格返回NO,其他返回YES
 */
- (BOOL) isNotBlank;

/**
 *  是否赋值字符串
 *
 *  @param string
 *
 *  @return 如果接收器有给字符串返回yes,否则返回no
 */
- (BOOL) containsString:(NSString *)string;

/**
 *  是否含有数字
 *
 *  @return 判断字符串是否含有数字有返回NSNumber或者空(解析错误);
 */
- (NSNumber*)numberValue;

/**
 *  用utf8加密 NSData
 *
 *  @return NSData
 */
- (NSData *)dataValue;


/**
 *  AES加密
 *
 *  @param oriData 加密数据
 *  @param key     加密密钥
 *
 *  @return 加密后的字符串
 */
+(NSString *)encryptString:(NSString *)oriData Key:(NSString *)key;



/**
 *  AES解密
 *
 *  @param decData 解密数据
 *  @param key     解密密钥
 *
 *  @return 解密后的字符串
 */
+ (NSString *)decryptString:(NSString *)decData  Key:(NSString *)key;




/**
 *  获取指定宽度情况ixa,字符串value的高度
 *
 *  @param value    待计算的字符串
 *  @param fontSize 字体的大小
 *  @param width    限制字符串显示区域的宽度
 *
 *  @return 高度
 */
-(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

/**
 *  获取指定宽度情况ixa,字符串value的高度
 *
 *  @param value    待计算的字符串
 *  @param font 字体
 *  @param width    限制字符串显示区域的宽度
 *
 *  @return 高度
 */
//-(float)heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width;
@end
