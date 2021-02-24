//
//  UIColor+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

void RGB2HSL(CGFloat r, CGFloat g, CGFloat b,
             CGFloat *h, CGFloat *s, CGFloat *l);
void HSL2RGB(CGFloat h, CGFloat s, CGFloat l,
             CGFloat *r, CGFloat *g, CGFloat *b);
void RGB2HSB(CGFloat r, CGFloat g, CGFloat b,
             CGFloat *h, CGFloat *s, CGFloat *v);
void HSB2RGB(CGFloat h, CGFloat s, CGFloat v,
             CGFloat *r, CGFloat *g, CGFloat *b);
void RGB2CMYK(CGFloat r, CGFloat g, CGFloat b,
              CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k);
void CMYK2RGB(CGFloat c, CGFloat m, CGFloat y, CGFloat k,
              CGFloat *r, CGFloat *g, CGFloat *b);
void HSB2HSL(CGFloat h, CGFloat s, CGFloat b,
             CGFloat *hh, CGFloat *ss, CGFloat *ll);
void HSL2HSB(CGFloat h, CGFloat s, CGFloat l,
             CGFloat *hh, CGFloat *ss, CGFloat *bb);
#define UIColorRGB(r, g, b)     [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]
#define UIColorHSB(h, s, b)     [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:1]
#define UIColorHSBA(h, s, b, a) [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:(a)]
#define UIColorHSL(h, s, l)     [UIColor colorWithHue:(h) saturation:(s) lightness:(l) alpha:1]
#define UIColorHSLA(h, s, l, a) [UIColor colorWithHue:(h) saturation:(s) lightness:(l) alpha:(a)]
#define UIColorCMYK(c, m, y, k) [UIColor colorWithCyan:(c) magenta:(m) yellow:(y) black:(k) alpha:1]
#define UIColorCMYKA(c,m,y,k,a) [UIColor colorWithCyan:(c) magenta:(m) yellow:(y) black:(k) alpha:(a)]


/**
 提供一些方法给"UIColor", 在RGB,HSB,HSL,CMYK 和 Hex之间转换颜色
 
 | Color space | Meaning                                |
 |-------------|----------------------------------------|
 | RGB         | Red, Green, Blue                       |
 | HSB(HSV)    | Hue, Saturation, Brightness (Value)    |
 | HSL         | Hue, Saturation, Lightness             |
 | CMYK        | Cyan, Magenta, Yellow, Black           |
 苹果默认使用rgb和hsb.
 
 所有的值在这个类里面都是在0.0-1.0的浮点小数,小于0.0的默认归为0.0,大于1.0的默认归为1.0;
*/

@interface UIColor (ShortCut)
/**
 *  用 HSL 色彩值和透明度创建并返回一个颜色对象
 *
 *  @param hue        色彩
 *  @param saturation 饱和度
 *  @param lightness  亮度
 *  @param alpha      透明度
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
                lightness:(CGFloat)lightness
                    alpha:(CGFloat)alpha;
/**
 *  用 CMYK 色彩值和透明度创建并返回一个颜色对象
 *
 *  @param cyan    蓝色值
 *  @param magenta 红色值
 *  @param yellow  黄色值
 *  @param black   黑色值
 *  @param alpha   透明度
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithCyan:(CGFloat)cyan
                   magenta:(CGFloat)magenta
                    yellow:(CGFloat)yellow
                     black:(CGFloat)black
                     alpha:(CGFloat)alpha;
/**
 *  创建并返回一个十六进制的rgb色值(0x----)的颜色
 *
 *  @param rgb值 rgb值(0x66ccff)
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithRGB:(uint32_t)rgbValue;
/**
 *  创建并返回一个十六进制的RGBA的色值(0x------)的颜色
 *
 *  @param rgba值 (0x66ccffff)
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithRGBA:(uint32_t)rgbaValue;
/**
 *  创建并返回一个由 十六进制的RGB色值和透明度组成的颜色
 *
 *  @param rgbValue rgb值(0x66ccff)
 *  @param alpha    透明度
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;
/**
 *  创建一个由十六进制字符串(#------)的颜色
 *
 *  @param hexStr  #rgb #rgba #rrggbb #rrggbbaa 0xrgb
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr;

///=============================================================================
/// @name Get color's description
///=============================================================================

/**
 *  将rgb颜色转换为十六进制(0x----)
 *
 *  @return hex的RGB值(0x66ccff)
 */
- (uint32_t)rgbValue;
/**
 *  将rgba颜色转换为十六进制(0x------)
 *
 *  @return hex的RGBA值(0x66ccffff)
 */
- (uint32_t)rgbaValue;
/**
 *  将RGB颜色转换为十六进制字符串,不包含#和大写
 *
 *  @return 0066cc
 */
- (NSString *)hexString;
/**
 *  将RGBA颜色转换为十六进制字符串,不包含#和大写
 *
 *  @return 0066ccff
 */
- (NSString *)hexStringWithAlpha;

///=============================================================================
/// @name Retrieving Color Information
///=============================================================================

/**
 判断传入的hsl和透明度值是否构成颜色
 Returns the components that make up the color in the HSL color space.
 
 @param hue On return, the hue component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param saturation On return, the saturation component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param lightness On return, the lightness component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param alpha On return, the alpha component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @return YES if the color could be converted, NO otherwise.
 */
/**
 *   判断传入的hsl和透明度值是否构成颜色
 *
 *  @param hue        色彩
 *  @param saturation 饱和度
 *  @param lightness  亮度
 *  @param alpha      透明度
 *
 *  @return YES, NO
 */
- (BOOL)getHue:(CGFloat *)hue
    saturation:(CGFloat *)saturation
     lightness:(CGFloat *)lightness
         alpha:(CGFloat *)alpha;
/**
 判断传入的cmyk和透明度值是否构成颜色
 Returns the components that make up the color in the CMYK color space.
 
 @param cyan On return, the cyan component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param magenta On return, the magenta component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param yellow On return, the yellow component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param black On return, the black component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param alpha On return, the alpha component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @return YES if the color could be converted, NO otherwise.
 */
/**
 *  判断传入的cmyk和透明度值是否构成颜色
 *
 *  @param cyan    蓝色值
 *  @param magenta 红色值
 *  @param yellow  黄色值
 *  @param black   黑色值
 *  @param alpha   透明度
 *
 *  @return YES, NO
 */
- (BOOL)getCyan:(CGFloat *)cyan
        magenta:(CGFloat *)magenta
         yellow:(CGFloat *)yellow
          black:(CGFloat *)black
          alpha:(CGFloat *)alpha;



/**
 *  判断红色的参数是否在rgb颜色空间里
 */
@property (nonatomic, readonly) CGFloat red;
/**
 *   判断绿色的参数是否在rgb颜色空间里
 */
@property (nonatomic, readonly) CGFloat green;
/**
 *   判断蓝色的参数是否在rgb颜色空间里
 */
@property (nonatomic, readonly) CGFloat blue;
/**
 *   判断Hue的参数是否在hsb颜色空间里
 */
@property (nonatomic, readonly) CGFloat hue;
/**
 *   判断saturation的参数是否在hsb颜色空间里
 */
@property (nonatomic, readonly) CGFloat saturation;
/**
 *  判断brightness的参数是否在hsb颜色空间里
 */
@property (nonatomic, readonly) CGFloat brightness;
/**
 *   透明度的值是否正确
 */
@property (nonatomic, readonly) CGFloat alpha;

@property (nonatomic, assign, readonly) CGFloat xlc_red;
@property (nonatomic, assign, readonly) CGFloat xlc_green;
@property (nonatomic, assign, readonly) CGFloat xlc_blue;
@property (nonatomic, assign, readonly) CGFloat xlc_alpha;

@end
