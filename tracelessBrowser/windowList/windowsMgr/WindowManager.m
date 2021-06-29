//
//  WindowManager.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/30.
//

#import "WindowManager.h"
#import "WindowModel.h"
#import "XYWKWebView.h"
#import "TBBrowserViewController.h"

#define windowsArhicvePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"TBWindowsList.plist"]

@interface WindowManager() {
    dispatch_queue_t queue;
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
        
        queue = dispatch_queue_create("windowManagerQueue", DISPATCH_QUEUE_SERIAL);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
        self.windowsArray = [NSMutableArray new];
        //todo 去本地读取
        [self unArchiveWindows];
        
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
    
    [self archiveWindows];
}

- (void)deleteWindow:(WindowModel *)model {
    if ([self.windowsArray containsObject:model]) {
        [self.windowsArray removeObject:model];
    }
    [self archiveWindows];
}

//MARK: 归档
- (void)archiveWindows {
    dispatch_async(queue, ^{

        NSDictionary *dic = @{@"currentIndex":@(self.currentWindowIndex),@"windows":self.windowsArray};
        NSError *error;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:&error];
        BOOL result = [[NSFileManager defaultManager] createFileAtPath:windowsArhicvePath contents:data attributes:nil];
        if (!result) {
         BOOL result2 = [data writeToFile:windowsArhicvePath atomically:YES];
        }
    });
}

- (void)unArchiveWindows {
    
        NSData *data = [NSData dataWithContentsOfFile:windowsArhicvePath];
        NSError *error;
        NSDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:NSObject.class fromData:data error:&error];
        if (dic[@"currentIndex"]) {
            self.currentWindowIndex = [dic[@"currentIndex"] integerValue];
        }
        if (dic[@"windows"]) {
            self.windowsArray = [NSMutableArray arrayWithArray:dic[@"windows"]];
        }
}

- (void)clearMemory{
    for (WindowModel *window in self.windowsArray) {
        [window.browserVC removeFromParentViewController];
        window.browserVC = nil;
    }
}


@end
