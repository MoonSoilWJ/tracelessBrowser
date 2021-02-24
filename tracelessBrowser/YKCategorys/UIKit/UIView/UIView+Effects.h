//
//  UIView+Effects.h
//  CCViewEffects
//
//  Created by 佰道聚合 on 2017/9/8.
//  Copyright © 2017年 cyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Effects)

- (void)clerBezierPath;

- (void)bezierPathRectCorner:(UIRectCorner) rectCorner
               conrnerRadius:(CGFloat) conrnerRadius;

- (void)bezierPathConrnerRadius:(CGFloat) conrnerRadius
                    shadowColor:(UIColor *) shadowColor
                   shadowOffset:(CGSize) shadowOffset
                   shadowRadius:(CGFloat) shadowRadius
                  shadowOpacity:(CGFloat) shadowOpacity;

- (void)bezierPathRectCorner:(UIRectCorner) rectCorner
               conrnerRadius:(CGFloat) conrnerRadius
                 borderWidth:(CGFloat) borderWidth
                 borderColor:(UIColor *) borderColor;

- (void)bezierPathBorderWidth:(CGFloat) borderWidth
                  borderColor:(UIColor *) borderColor
                  shadowColor:(UIColor *) shadowColor
                 shadowOffset:(CGSize) shadowOffset
                 shadowRadius:(CGFloat) shadowRadius
                shadowOpacity:(CGFloat) shadowOpacity;

- (void)bezierPathRectCorner:(UIRectCorner) rectCorner
               conrnerRadius:(CGFloat) conrnerRadius
                 borderWidth:(CGFloat) borderWidth
                 borderColor:(UIColor *) borderColor
                 shadowColor:(UIColor *) shadowColor
                shadowOffset:(CGSize) shadowOffset
                shadowRadius:(CGFloat) shadowRadius
               shadowOpacity:(CGFloat) shadowOpacity;
@end
