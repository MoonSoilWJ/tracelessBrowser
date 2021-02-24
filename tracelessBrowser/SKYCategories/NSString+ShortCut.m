//
//  NSString+ShortCut.m
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "NSString+ShortCut.h"
#import <Foundation/Foundation.h>
#import "NSNumber+ShortCut.h"
#import "NSData+ShortCut.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation NSString (ShortCut)


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)md5String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)sha1String{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1String];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)sha224String{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha224String];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha256String];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha384String];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha512String];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crc32String];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacMD5StringWithKey:key];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA1StringWithKey:key];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA224StringWithKey:key];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA256StringWithKey:key];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA384StringWithKey:key];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA512StringWithKey:key];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)base64Encoding {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSString *)stringWithBase64Encoding:(NSString *)base64Encoding {
    NSData *data = [NSData dataWithBase64Encoding:base64Encoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}







///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)stringByEscapingHTML{
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i=0; i<len; i++,buf++) {
        unichar c = *buf;
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result,&c,1);
        }
    }
    free(buf);
    return result;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSString *)stringWithUUID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)stringByTrim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (BOOL)containsString:(NSString *)string {
    if(string == nil)
        return NO;
    NSRange range = NSMakeRange(NSNotFound, 0);
    return !NSEqualRanges([self rangeOfString:string], range);
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSNumber*)numberValue
{
    return [NSNumber numberWithString:self];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSData *)dataValue{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
CCOptions _padding = kCCOptionPKCS7Padding;
+ (NSString *)encryptString:(NSString *)oriData Key:(NSString *)key
{
    NSData *_secretData = [oriData dataUsingEncoding:NSASCIIStringEncoding];
    
    // You can use md5 to make sure key is 16 bits long
    NSData *encryptedData = [self encrypt:_secretData Key:key];
    
    return [self hex:encryptedData useLower:NO];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSString *)decryptString:(NSString *)decData  Key:(NSString *)key
{
    NSData *hexData = [self hex:decData];
    NSData *data = [self decrypt:hexData Key:key];
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSData *)encrypt:(NSData *)plainText Key:(NSString *)key
{
    return [self doCipher:plainText Key:key context:kCCEncrypt];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSData *)decrypt:(NSData *)plainText Key:(NSString *)key
{
    return [self doCipher:plainText Key:key context:kCCDecrypt];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSData *)doCipher:(NSData *)plainText Key:(NSString *)key context:(CCOperation)encryptOrDecrypt
{
    CCCryptorStatus ccStatus = kCCSuccess;
    // Symmetric crypto reference.
    CCCryptorRef thisEncipher = NULL;
    // Cipher Text container.
    NSData * cipherOrPlainText = nil;
    // Pointer to output buffer.
    uint8_t * bufferPtr = NULL;
    // Total size of the buffer.
    size_t bufferPtrSize = 0;
    // Remaining bytes to be performed on.
    size_t remainingBytes = 0;
    // Number of bytes moved to buffer.
    size_t movedBytes = 0;
    // Length of plainText buffer.
    size_t plainTextBufferSize = 0;
    // Placeholder for total written.
    size_t totalBytesWritten = 0;
    // A friendly helper pointer.
    uint8_t * ptr;
    CCOptions *pkcs7;
    pkcs7 = &_padding;
    NSData *aSymmetricKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[kChosenCipherBlockSize];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    plainTextBufferSize = [plainText length];
    
    // We don't want to toss padding on if we don't need to
    if(encryptOrDecrypt == kCCEncrypt) {
        if(*pkcs7 != kCCOptionECBMode) {
            *pkcs7 = kCCOptionPKCS7Padding;
        }
    } else if(encryptOrDecrypt != kCCDecrypt) {
        NSLog(@"Invalid CCOperation parameter [%d] for cipher context.", *pkcs7 );
    }
    
    // Create and Initialize the crypto reference.
    CCCryptorCreate(encryptOrDecrypt,
                    kCCAlgorithmAES128,
                    *pkcs7,
                    (const void *)[aSymmetricKey bytes],
                    kChosenCipherKeySize,
                    (const void *)iv,
                    &thisEncipher
                    );
    
    // Calculate byte block alignment for all calls through to and including final.
    bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
    
    // Allocate buffer.
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
    
    // Zero out buffer.
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    // Initialize some necessary book keeping.
    ptr = bufferPtr;
    
    // Set up initial size.
    remainingBytes = bufferPtrSize;
    
    // Actually perform the encryption or decryption.
    CCCryptorUpdate(thisEncipher,
                    (const void *) [plainText bytes],
                    plainTextBufferSize,
                    ptr,
                    remainingBytes,
                    &movedBytes
                    );
    
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
    
    // Finalize everything to the output buffer.
    ccStatus = CCCryptorFinal(thisEncipher,
                              ptr,
                              remainingBytes,
                              &movedBytes
                              );
    
    totalBytesWritten += movedBytes;
    
    if(thisEncipher) {
        (void) CCCryptorRelease(thisEncipher);
        thisEncipher = NULL;
    }
    
    if (ccStatus == kCCSuccess)
        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];
    else
        cipherOrPlainText = nil;
    
    if(bufferPtr) free(bufferPtr);
    
    return cipherOrPlainText;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSString *)hex: (NSData *)data useLower: (bool)isOutputLower
{
    static const char HexEncodeCharsLower[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    static const char HexEncodeChars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    char *resultData;
    // malloc result data
    resultData = malloc([data length] * 2 +1);
    // convert imgData(NSData) to char[]
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    uint length = (uint)[data length];
    
    if (isOutputLower)
    {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    }
    else {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    
    // convert result(char[]) to NSString
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    
    return result;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSData *)hex: (NSString *)data
{
    static const unsigned char HexDecodeChars[] =
    {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, //49
        2, 3, 4, 5, 6, 7, 8, 9, 0, 0, //59
        0, 0, 0, 0, 0, 10, 11, 12, 13, 14,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //79
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 10, 11, 12,   //99
        13, 14, 15
    };
    
    // convert data(NSString) to CString
    const char *source = [data cStringUsingEncoding:NSUTF8StringEncoding];
    // malloc buffer
    unsigned char *buffer;
    uint length =(uint)strlen(source) / 2;
    buffer = malloc(length);
    for (uint index = 0; index < length; index++) {
        buffer[index] = (HexDecodeChars[source[index * 2]] << 4) + (HexDecodeChars[source[index * 2 + 1]]);
    }
    // init result NSData
    NSData *result = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    source = nil;
    
    return  result;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    float height;
    CGSize constraint = CGSizeMake(width,CGFLOAT_MAX);
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:value
     attributes:@
     {
     NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    height=rect.size.height;
    height=ceil(height);
    return height;
}

-(float)heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    float height;
    CGSize constraint = CGSizeMake(width,CGFLOAT_MAX);
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:value
     attributes:@
     {
     NSFontAttributeName:font
     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    height=rect.size.height;
    height=ceil(height);
    return height;
}
@end
