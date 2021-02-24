//
//  UIScreen+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ShortCut)



/**
 *  根据屏幕尺寸转换比例
 *
 *  @param scale    尺寸（4.0寸基准）
 *
 *  @return
 */
+(float)screenScale:(float)scale;



/**
 *  返回当前设备的屏幕边界的方向
 *
 *  @return 返回当前设备的屏幕边界的方向
 */
- (CGRect)currentBounds;



/**
 *  返回给定设备的屏幕边界的方向
 *
 *  @param orientation 屏幕方向
 *
 *  @return 返回给定设备的屏幕边界的方向
 */
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;




/**
 *   返回设备是否Retina屏;
 *
 *  @return YES, NO
 */
//- (BOOL)isRetina;
@end
