//
//  WindowManager.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/30.
//

#import "WindowManager.h"
#import "WindowModel.h"

@implementation WindowManager

+ (instancetype)sharedInstance {
    static WindowManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WindowManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)clearMemory{
    for (WindowModel *window in _windowsArray) {
        window.webView = nil;
    }
}


@end
