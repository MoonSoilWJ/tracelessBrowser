//
//  TBEnginsManager.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/3.
// 引擎管理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBEnginsManager : NSObject

+ (NSString *)currentEngineUrl;

+ (void)saveCurrentEngineUrl:(NSString *)currentEngineUrlStr;

+ (NSInteger )currentEngineIndex;

+ (UIImage *)iconImageforIndex:(NSInteger)index;

+ (NSArray *)enginesArr;


@end

NS_ASSUME_NONNULL_END
