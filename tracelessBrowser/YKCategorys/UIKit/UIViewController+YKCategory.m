//
//  UIViewController+YKCategory.m
//  xiaolancang
//
//  Created by yuekewei on 2019/12/17.
//  Copyright © 2019 yeqiang. All rights reserved.
//

#import "UIViewController+YKCategory.h"

@implementation UIViewController (YKCategory)

/**
 获取屏幕显示的控制器

 @return 屏幕显示的控制器
 */
+ (UIViewController *)yk_currentController {
    UIViewController *currentController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if (currentController == nil) {
        return nil;
    }    
    while (true) {
        if (currentController.presentedViewController != nil) {
            currentController = currentController.presentedViewController;
        } else if ([currentController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)currentController;
            currentController = navi.topViewController;
        } else if ([currentController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)currentController;
            currentController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return currentController;
}
@end
