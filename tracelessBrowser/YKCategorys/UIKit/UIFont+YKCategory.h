//
//  UIFont+YKCategory.h
//  Tairong
//
//  Created by yuekewei on 2019/7/16.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (YKCategory)

/// 平方中黑体
/// @param fontSize 字体大小
+ (UIFont *)yk_pingFangMediumFontOfSize:(CGFloat)fontSize;

/// 平方中粗体
/// @param fontSize 字体大小
+ (UIFont *)yk_pingFangSemiboldFontOfSize:(CGFloat)fontSize;

/// 平方细体
/// @param fontSize 字体大小
+ (UIFont *)yk_pingFangLightFontOfSize:(CGFloat)fontSize;

/// 平方极细体
/// @param fontSize 字体大小
+ (UIFont *)yk_pingFangUltralightFontOfSize:(CGFloat)fontSize;

/// 平方常规体
/// @param fontSize 字体大小
+ (UIFont *)yk_pingFangRegularFontOfSize:(CGFloat)fontSize;

/// 平方纤细体
/// @param fontSize 字体大小
+ (UIFont *)yk_pingFangThinFontOfSize:(CGFloat)fontSize;
/**
 注册字体文件
 
 @param path 字体文件路径
 */
- (void)yk_registerFontWithFontFilePath:(NSString *)path;

/**
 注册字体文件
 
 @param fontData  字体文件NSData
 */
- (void)yk_registerFontWithFontData:(NSData *)fontData;

/**
 打印系统所有字体名称
 */
+ (void)yk_printAllFonts;
@end

NS_ASSUME_NONNULL_END
