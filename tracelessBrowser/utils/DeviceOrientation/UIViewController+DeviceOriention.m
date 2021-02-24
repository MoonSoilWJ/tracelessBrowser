//
//  UIViewController+DeviceOriention.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/1/29.
//

#import "UIViewController+DeviceOriention.h"

static NSString *screenWidthKey = @"screenWidthKey";

@interface UIViewController (DeviceOriention)
@property (nonatomic, assign) CGFloat lastScreenWidth;
@end

@implementation UIViewController (DeviceOriention)

-(void)setLastScreenWidth:(CGFloat)lastScreenWidth {
    objc_setAssociatedObject(self, &screenWidthKey, @(lastScreenWidth), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)lastScreenWidth {
    NSNumber *num = objc_getAssociatedObject(self, &screenWidthKey);
    return num.floatValue;
}

+ (void)load {
    [self exChanageMethodSystemSel:@selector(viewDidLoad) swizzSel:@selector(deviceOrienViewDidLoad)];
    
    [self exChanageMethodSystemSel:NSSelectorFromString(@"dealloc") swizzSel:@selector(deviceOriendealloc)];
}

+ (void)exChanageMethodSystemSel:(SEL)systemSel swizzSel:(SEL)swizzSel {
    //两个方法的Method
    Method systemMethod = class_getInstanceMethod([self class], systemSel);
    Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
    //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
    BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    if (isAdd) {
        //如果成功，说明类中不存在这个方法的实现
        //将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        //否则，交换两个方法的实现
        method_exchangeImplementations(systemMethod, swizzMethod);
    }
}

- (void)deviceOrienViewDidLoad {
    //开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self deviceOrienViewDidLoad];
}

//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;

    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            deviceOrientation = UIDeviceOrientationFaceUp;
//            NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            deviceOrientation = UIDeviceOrientationFaceUp;
//            NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
//            NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:{
//            NSLog(@"屏幕向左横置");
        }
            break;
        case UIDeviceOrientationLandscapeRight:
//            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            deviceOrientation = UIDeviceOrientationFaceUp;
//            NSLog(@"屏幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            deviceOrientation = UIDeviceOrientationFaceUp;
//            NSLog(@"屏幕直立，上下顛倒");
            break;
        default:
//            NSLog(@"无法辨识");
            break;
    }
    
    if (self.lastScreenWidth != UIScreen.mainScreen.bounds.size.width) {
        self.lastScreenWidth = UIScreen.mainScreen.bounds.size.width;
        if ([self conformsToProtocol:@protocol(DeviceOrientionChangedProtocol)]) {
            if ([self respondsToSelector:@selector(deviceOrientionChanged:)]) {
                [self deviceOrientionChanged:deviceOrientation];
            }
        }
    }
}

- (void)deviceOriendealloc {
    [self deviceOriendealloc];
}

@end
