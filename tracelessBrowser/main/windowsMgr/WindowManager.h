//
//  WindowManager.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WindowModel;
@interface WindowManager : NSObject

@property (nonatomic, retain) NSMutableArray *windowsArray;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
