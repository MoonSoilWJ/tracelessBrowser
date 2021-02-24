//
//  NSNumber+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (ShortCut)


/**
 *  创建并返回一个NSNumber对象,用来提取字符串中的数字
 *
 *  @param string  @"12", @"12.345", @" -0xFF", @" .23e99 "..
 *
 *  @return 返回一个NSNumber,返回空,错误
 */
+ (NSNumber *)numberWithString:(NSString *)string;

+ (NSNumber*)add:(NSNumber *)one and:(NSNumber *)another;
@end
