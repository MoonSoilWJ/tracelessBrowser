//
//  NSUserDefaults+YKCategory.m
//  xiaolancang
//
//  Created by yuekewei on 2020/1/6.
//  Copyright © 2020 yeqiang. All rights reserved.
//

#import "NSUserDefaults+YKCategory.h"


@implementation NSUserDefaults (YKCategory)

+ (void)setUserDefaultsWithKey:(NSString*)key data:(id)data {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getUserDefaultsWithKey:(NSString*)key {
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([object isKindOfClass:[NSData class]]) {
         return [NSKeyedUnarchiver unarchiveObjectWithData:object];
    }
    return object;
}

+ (void)removeUserDefaultsWithKey:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
