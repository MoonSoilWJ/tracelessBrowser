//
//  WindowManager.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/30.
//

#import "WindowManager.h"
#import "WindowModel.h"

@interface WindowManager() {
}

@end

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
        self.windowsArray = [NSMutableArray new];
        //todo 去本地读取
        
        if (self.windowsArray.count <= 0) {
            [self addNewWindow];
        }
    }
    return self;
}

- (WindowModel *)getcurrentWindow {
    if (self.windowsArray.count > self.currentWindowIndex) {
    }else {
        self.currentWindowIndex = self.windowsArray.count - 1;
    }
    return self.windowsArray[self.currentWindowIndex];
}

- (void)addNewWindow {
    WindowModel *m = [[WindowModel alloc] init];
    m.isHome = YES;
    [self.windowsArray addObject:m];
    self.currentWindowIndex = self.windowsArray.count - 1;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WINDOWS_COUNT_CHANGED_NOTI_NAME object:nil];
}

- (void)clearMemory{
    for (WindowModel *window in self.windowsArray) {
        window.webView = nil;
    }
}


@end
