//
//  UIButton+TB.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/18.
//

#import <UIKit/UIKit.h>

@interface UIButton (TB)
#pragma mark - create
+ (UIButton *)btnWithFontSize:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor;

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor;

+ (UIButton *)btnWithImg:(UIImage *)img;

+ (UIButton *)btnWithBgImg:(UIImage *)bgImg;

#pragma mark - convenience
- (void)setNormalTitle:(NSString *)nTitle selectedTitle:(NSString *)sTitle;
- (void)setNormalTitleColor:(UIColor *)nColor selectedTitleColor:(UIColor *)sColor;

- (void)setNormalImg:(UIImage *)nImg selectedImg:(UIImage *)sImg;
- (void)setNormalBgImg:(UIImage *)nBgImg selectedBgImg:(UIImage *)sBgImg;

- (void)setNormalBgColor:(UIColor *)nBgColor selectedBgColor:(UIColor *)sBgColor;

@end

