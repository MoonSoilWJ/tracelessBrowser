//
//  UIImage+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ShortCut)


//=============================================================================
/// @name Create image
///=============================================================================
/**
 *  将色值返回为1x1像素的png图片
 *
 *  @param color UIColor
 *
 *  @return 返回为1x1像素的png图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


///=============================================================================
/// @name Get info from image
///=============================================================================

/**
 *  获取该图片的某像素点的颜色
 *
 *  @param point 点坐标
 *
 *  @return 返回UIColor 或者错误(nil)
 */
- (UIColor *)colorAtPoint:(CGPoint )point;




/**
 *  给图片加圆角
 *
 *  @param image  图片
 *  @param size   大小
 *  @param radius 圆角
 *
 *  @return 
 */
+ (UIImage *)createRoundedRectImage:(UIImage *)image size:(CGSize)size roundRadius:(CGFloat)radius;


/**
 *  返回该图片是否有透明度通道
 *
 *  @return YES, NO
 */
- (BOOL)hasAlphaChannel;


/**
 *  九宫格图片拉伸
 *
 *  @return UIImage
 */
-(UIImage *)ImageWithLeftCapWidth;






/**
 *  获取截图view的图片
 *
 *  @param uiview 截图的view
 *  @param size   截图的大小
 *
 *  @return 
 */
-(UIImage *)getScreenshotImage:(UIView *)uiview size:(CGSize)size;




/**
 *  毛玻璃
 *
 *  @param blurRadius
 *  @param tintColor
 *  @param saturationDeltaFactor
 *  @param maskImage
 *
 *  @return
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage didCancel:(BOOL (^)(void))didCancel;

- (UIImage *)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
