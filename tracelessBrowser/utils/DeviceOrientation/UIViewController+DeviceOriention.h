//
//  UIViewController+DeviceOriention.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/1/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DeviceOrientionChangedProtocol <NSObject>

- (void)deviceOrientionChanged:(UIDeviceOrientation )deviceOrientation;

@end

@interface UIViewController (DeviceOriention) <DeviceOrientionChangedProtocol>



@end

NS_ASSUME_NONNULL_END
