//
//  BaseViewController.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/3.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DeviceOriention.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SkinDidChangedProtocol <NSObject>

- (void)skinDidChanged:(NSDictionary *)info;

@end

@interface BaseViewController : UIViewController <SkinDidChangedProtocol>

/*
 必须放在视图加载后调用，不然代理调用时，有些视图还没有创建
 */
- (void)initSkin;

@end

NS_ASSUME_NONNULL_END
