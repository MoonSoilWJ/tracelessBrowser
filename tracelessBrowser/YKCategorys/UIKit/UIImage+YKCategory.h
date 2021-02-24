//
//  UIImage+YKCategory.h
//  Tairong
//
//  Created by yuekewei on 2019/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YKCategory)

/**
 改变图片的缩放倍率
 
 @param targetWidth 目标Width
 @param filePah 图片路径
 @return 改变缩放倍率的图片
 */
+ (UIImage *)imageChangeScaleForTargetWidth:(CGFloat)targetWidth filePath:(NSString *)filePah;

/**
 渐变色UIImage实例
 
 @param colors colors
 @param rect rect
 @param isVertical 是否垂直渐变
 @return 渐变色UIImage实例
 */
+ (UIImage *)imageForGradientWithColors:(NSArray <UIColor *>*)colors andRect:(CGRect)rect orientationIsVertical:(BOOL)isVertical;

/**
 获取指定颜色图片
 
 @param color color
 @return 指定颜色UIImage实例
 */
+ (UIImage *)imageForColor:(UIColor *)color;


/**
 *  获取指定颜色椭圆形图片
 *
 *  @param rect  rect
 *  @param color color
 *
 *  @return UIImage
 */
+ (UIImage *)ellipseImageWithRect:(CGRect)rect color:(UIColor *)color;



/**
 *  获取图片主色调
 *
 *  @param image image
 *
 *  @return UIColor
 */
+ (UIColor *)imageMostColor:(UIImage*)image;

/**
 获取app启动图
 
 @return app启动图
 */
+ (UIImage *)appLaunchImage;
@end

NS_ASSUME_NONNULL_END
