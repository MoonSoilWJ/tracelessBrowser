//
//  NSData+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ShortCut)


///=============================================================================
/// @name Hash 哈希
///=============================================================================

/**
 *  NSString, 用 md5 Hash加密
 *
 *  @return  返回一个小写字母组成的 NSString
 */
- (NSString *)md5String;


/**
 *  NSData, 用 md5 Hash加密
 *
 *  @return  返回一个 NSData
 */
-(NSData *)md5Data;



/**
 *  NSString, 用 sha1 Hash加密
 *
 *  @return  返回一个小写字母组成的 NSString
 */
- (NSString *)sha1String;

/**
 *  NSData, 用 sha1 Hash加密
 *
 *  @return  返回一个 NSData
 */
- (NSData *)sha1Data;

/**
 *  NSString, 用 sha224 Hash加密
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)sha224String;

/**
 *  NSData, 用 sha224 Hash加密
 *
 *  @return  返回一个 NSData
 */
- (NSData *)sha224Data;

/**
 *  NSString, 用 sha256 Hash加密
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)sha256String;

/**
 *  NSData, 用 sha256 Hash加密
 *
 *  @return  返回一个 NSData
 */
- (NSData *)sha256Data;

/**
 *  NSString, 用 sha384 Hash加密
 *
 *  @return  返回一个小写字母组成的 NSString,
 */
- (NSString *)sha384String;

/**
 *  NSData, 用 sha384 Hash加密
 *
 *  @return  返回一个 NSData,
 */
- (NSData *)sha384Data;

/**
 *  NSString, 用 sha512 Hash加密
 *
 *  @return  返回一个小写字母组成的 NSString
 */
- (NSString *)sha512String;

/**
 *  NSData, 用 sha512 Hash加密
 *
 *  @return  返回一个 NSData
 */
- (NSData *)sha512Data;

/**
 *  NSString,用md5算法和键值的 Hmac加密
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 *  NSString,用sha1算法和键值的 Hmac加密
 *
 *  @param key 自定义键值
 *
 *  @return  返回一个小写字母组成的 NSString
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 *  NSString,用sha224算法和键值的 Hmac加密
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

/**
 *  NSString,用sha256算法和键值的 Hmac加密
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 *  NSString,用sha384算法和键值的 Hmac加密
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

/**
 *  NSString,用sha512算法和键值的 Hmac加密
 *
 *  @param key 自定义键值
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

/**
 *  NSString,用crc32 Hash加密
 *
 *  @return 返回一个小写字母组成的 NSString
 */
- (NSString *)crc32String;

/**
 *  转换为crc32 hash
 *
 *  @return 返回crc32 hash
 */
- (uint32_t)crc32;




///=============================================================================
/// @name Encrypt and Decrypt 加密和解密
///=============================================================================

/**
 *  AES 加密NSData
 *
 *  @param key 键值的长度 16, 24 or 32 (128, 192 or 256位)
 *  @param iv  一个长度为16(128位)的初始化向量,如果不想使用,返回Nil.
 *
 *  @return 加密过的NSData或者空(发生错误).
 */
- (NSData *)aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;

/**
 *  AES 解密 NSData
 *
 *  @param key 键值的长度 16, 24 or 32 (128, 192 or 256位)
 *  @param iv  一个长度为16(128位)的初始化向量,如果不想使用,返回Nil.
 *
 *  @return 解密过的NSData或者空(发生错误).
 */
- (NSData *)aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;




///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 *  用十六进制编码的 NSString
 *
 *  @return 返回一个大写字母组成的 NSString
 */
- (NSString *)hexString;

/**
 *  十六进制编码 NSData
 *
 *  @param hexString 不区分大小写的十六进制字符串.
 *
 *  @return 一个新的NSData或者空(发生错误).
 */
+ (NSData *)dataWithHexString:(NSString *)hexString;

/**
 *  用 base64编码 NSString
 *
 *  @return NSString
 */
- (NSString *)base64Encoding;

/**
 *  用base64编码过的字符串组成的 NSData
 *
 *  @param base64Encoding
 *
 *  @return NSData
 */
+ (NSData *)dataWithBase64Encoding:(NSString *)base64Encoding;




///=============================================================================
/// @name Inflate and deflate 压缩和解压
///=============================================================================

/**
 *  解压被 gzip压缩过的数据
 *
 *  @return NSData
 */
- (NSData *)gzipInflate;

/**
 *  用默认压缩级别压缩数据到gzip
 *
 *  @return NSData
 */
- (NSData *)gzipDeflate;

/**
 *   解压被 zlib(压缩算法)压缩过的数据
 *
 *  @return NSData
 */
- (NSData *) zlibInflate;

/**
 *   用默认的压缩级别将数据压缩到 zlib
 *
 *  @return NSData
 */
- (NSData *) zlibDeflate;
@end
