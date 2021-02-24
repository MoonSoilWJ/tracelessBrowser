//
//  NSUserDefaults+YKCategory.h
//  xiaolancang
//
//  Created by yuekewei on 2020/1/6.
//  Copyright © 2020 yeqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (YKCategory)

+ (void)setUserDefaultsWithKey:(NSString*)key data:(id)data;

+ (id)getUserDefaultsWithKey:(NSString*)key;

+ (void)removeUserDefaultsWithKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
