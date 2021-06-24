//
//  BrowserTransition.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/4/12.
//

typedef enum : NSUInteger {
    BrowserTransitionTypePopToBrowserFromWindowList,//从窗口管理打开浏览器
    BrowserTransitionTypePopToHomeFromWindowList,//从窗口打开首页
    BrowserTransitionTypePushToWindowList,//进入窗口管理
//    BrowserTransitionTypePushToSearchFromBrowser,//从浏览器进入编辑地址页
//    BrowserTransitionTypePopToNewHomeV,//新增窗口
    BrowserTransitionTypeNormal,//
} BrowserTransitionType;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrowserTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (BrowserTransition *)transitionWithTransitionType:(BrowserTransitionType )type;
@end

NS_ASSUME_NONNULL_END
