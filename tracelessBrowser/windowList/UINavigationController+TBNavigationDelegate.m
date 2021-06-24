//
//  UINavigationController+TBNavigationDelegate.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/6/23.
//

#import "UINavigationController+TBNavigationDelegate.h"
#import "BrowserTransition.h"
#import "WindowListViewController.h"

@implementation UINavigationController (TBNavigationDelegate)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(tb_viewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)tb_viewDidLoad {
    [self tb_viewDidLoad];
    
    self.delegate = self;
}

//MARK:UINavigationControllerDelegate（转场动画）
//触发条件：(它push时||它pop时||pop到它时,)&&animated为true
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPop) {
        
        // 窗口到首页
        if ([toVC isKindOfClass:NSClassFromString(@"ViewController")] && [fromVC isKindOfClass:NSClassFromString(@"WindowListViewController")]) {
            return [BrowserTransition transitionWithTransitionType:BrowserTransitionTypePopToHomeFromWindowList];
        }
        // 窗口到浏览器
        else if ([toVC isKindOfClass:NSClassFromString(@"TBBrowserViewController")] && [fromVC isKindOfClass:NSClassFromString(@"WindowListViewController")]) {
            return [BrowserTransition transitionWithTransitionType:BrowserTransitionTypePopToBrowserFromWindowList];
        }
    }
    else if (operation == UINavigationControllerOperationPush) {
        // 首页进入窗口管理
        if ([toVC isKindOfClass:NSClassFromString(@"WindowListViewController")] && ([fromVC isKindOfClass:NSClassFromString(@"ViewController")] || [fromVC isKindOfClass:NSClassFromString(@"TBBrowserViewController")])) {
            return [BrowserTransition transitionWithTransitionType:BrowserTransitionTypePushToWindowList];
        }
    }
    return nil;
}

@end
