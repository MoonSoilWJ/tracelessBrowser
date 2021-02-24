//
//  NSNumber+ShortCut.m
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "NSNumber+ShortCut.h"
#import "NSString+ShortCut.h"
@implementation NSNumber (ShortCut)



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+ (NSNumber *)numberWithString:(NSString *)string
{
    NSString *str = [[string stringByTrim] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    int sign = 0;
    if ([str hasPrefix:@"0x"])
        sign = 1;
    else if ([str hasPrefix:@"-0x"])
        sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

+ (NSNumber*)add:(NSNumber *)one and:(NSNumber *)another {
    return [NSNumber numberWithFloat:[one floatValue] + [another floatValue]];
}
@end
