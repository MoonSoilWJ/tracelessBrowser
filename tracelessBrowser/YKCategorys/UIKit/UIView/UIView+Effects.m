//
//  UIView+Effects.m
//  CCViewEffects
//
//  Created by 佰道聚合 on 2017/9/8.
//  Copyright © 2017年 cyd. All rights reserved.
//

#import "UIView+Effects.h"
#import <objc/runtime.h>

@interface UIView (Effects_Private)

@property(nonatomic, assign)  UIRectCorner privateConrnerCorner;
@property(nonatomic, assign)  CGFloat privateConrnerRadius;

@property(nonatomic, strong)  UIColor *privateBorderColor;
@property(nonatomic, assign)  CGFloat privateBorderWidth;

@property(nonatomic, assign)  CGFloat privateShadowOpacity;
@property(nonatomic, assign)  CGFloat privateShadowRadius;
@property(nonatomic, assign)  CGSize privateShadowOffset;
@property(nonatomic, strong)  UIColor *privateShadowColor;
@property(nonatomic, strong)  UIView *shadowBackgroundView;

@end


@implementation UIView (Effects_Private)

#pragma mark - 添加私有属性
- (void)setPrivateConrnerCorner:(UIRectCorner)privateConrnerCorner {
    objc_setAssociatedObject(self, @selector(privateConrnerCorner), [NSNumber numberWithInteger:privateConrnerCorner], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIRectCorner)privateConrnerCorner {
    id corner = objc_getAssociatedObject(self, _cmd);
    return corner ? [corner integerValue] : UIRectCornerAllCorners;
}

- (void)setPrivateConrnerRadius:(CGFloat)privateConrnerRadius {
    objc_setAssociatedObject(self, @selector(privateConrnerRadius), [NSNumber numberWithFloat:privateConrnerRadius], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)privateConrnerRadius {
    id radius = objc_getAssociatedObject(self, _cmd);
    return radius ? [radius floatValue] : 0.0;
}

- (void)setPrivateBorderWidth:(CGFloat)privateBorderWidth {
    objc_setAssociatedObject(self, @selector(privateBorderWidth), [NSNumber numberWithFloat:privateBorderWidth], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)privateBorderWidth {
    id width = objc_getAssociatedObject(self, _cmd);
    return width ? [width floatValue] : 0.0;
}

- (void)setPrivateBorderColor:(UIColor *)privateBorderColor {
    objc_setAssociatedObject(self, @selector(privateBorderColor), privateBorderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)privateBorderColor {
    id color = objc_getAssociatedObject(self, _cmd);
    return color ? color : [UIColor blackColor];
}

- (void)setPrivateShadowRadius:(CGFloat)privateShadowRadius {
    objc_setAssociatedObject(self, @selector(privateShadowRadius), [NSNumber numberWithFloat:privateShadowRadius], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)privateShadowRadius {
    id radius = objc_getAssociatedObject(self, _cmd);
    return radius ? [radius floatValue] : 0.0;
}

- (void)setPrivateShadowOpacity:(CGFloat)privateShadowOpacity {
    objc_setAssociatedObject(self, @selector(privateShadowOpacity), [NSNumber numberWithFloat:privateShadowOpacity], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)privateShadowOpacity {
    id opacity = objc_getAssociatedObject(self, _cmd);
    return opacity ? [opacity floatValue] : 0.0;
}

- (void)setPrivateShadowOffset:(CGSize)privateShadowOffset {
    objc_setAssociatedObject(self, @selector(privateShadowOffset), NSStringFromCGSize(privateShadowOffset), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGSize)privateShadowOffset {
    id offset = objc_getAssociatedObject(self, _cmd);
    return offset ? CGSizeFromString(offset) : CGSizeZero;
}

- (void)setPrivateShadowColor:(UIColor *)privateShadowColor {
    objc_setAssociatedObject(self, @selector(privateShadowColor), privateShadowColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)privateShadowColor {
    id color = objc_getAssociatedObject(self, _cmd);
    return color ? color : [UIColor blackColor];
}

- (void)setShadowBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, @selector(shadowBackgroundView), backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)shadowBackgroundView {
    return objc_getAssociatedObject(self, _cmd);
}

@end


#pragma mark -
@implementation UIView (Effects)

- (void)bezierPathRectCorner:(UIRectCorner) rectCorner
               conrnerRadius:(CGFloat) conrnerRadius {
    [self bezierPathRectCorner:rectCorner
                 conrnerRadius:conrnerRadius
                   borderWidth:0
                   borderColor:nil
                   shadowColor:nil
                  shadowOffset:CGSizeZero
                  shadowRadius:0
                 shadowOpacity:0];
}

- (void)bezierPathRectCorner:(UIRectCorner) rectCorner
               conrnerRadius:(CGFloat) conrnerRadius
                 borderWidth:(CGFloat) borderWidth
                 borderColor:(UIColor *) borderColor {
    [self bezierPathRectCorner:rectCorner
                 conrnerRadius:conrnerRadius
                   borderWidth:borderWidth
                   borderColor:borderColor
                   shadowColor:nil
                  shadowOffset:CGSizeZero
                  shadowRadius:0
                 shadowOpacity:0];
}

- (void)bezierPathBorderWidth:(CGFloat) borderWidth
                  borderColor:(UIColor *) borderColor
                  shadowColor:(UIColor *) shadowColor
                 shadowOffset:(CGSize) shadowOffset
                 shadowRadius:(CGFloat) shadowRadius
                shadowOpacity:(CGFloat) shadowOpacity {
    [self bezierPathRectCorner:UIRectCornerAllCorners
                 conrnerRadius:0
                   borderWidth:borderWidth
                   borderColor:borderColor
                   shadowColor:shadowColor
                  shadowOffset:shadowOffset
                  shadowRadius:shadowRadius
                 shadowOpacity:shadowOpacity];
}

- (void)bezierPathRectCorner:(UIRectCorner) rectCorner
               conrnerRadius:(CGFloat) conrnerRadius
                 borderWidth:(CGFloat) borderWidth
                 borderColor:(UIColor *) borderColor
                 shadowColor:(UIColor *) shadowColor
                shadowOffset:(CGSize) shadowOffset
                shadowRadius:(CGFloat) shadowRadius
               shadowOpacity:(CGFloat) shadowOpacity {
    self.privateConrnerCorner = rectCorner;
    self.privateConrnerRadius = conrnerRadius;
    self.privateBorderColor = borderColor;
    self.privateBorderWidth = borderWidth;
    self.privateShadowOpacity = shadowOpacity;
    self.privateShadowRadius = shadowRadius;
    self.privateShadowOffset = shadowOffset;
    self.privateShadowColor = shadowColor;
    //    self.privateBezierPath = path;
    [self addShadow];
    [self addBorderAndRadius];
}

- (void)bezierPathConrnerRadius:(CGFloat) conrnerRadius
                    shadowColor:(UIColor *) shadowColor
                   shadowOffset:(CGSize) shadowOffset
                   shadowRadius:(CGFloat) shadowRadius
                  shadowOpacity:(CGFloat) shadowOpacity {
    self.privateConrnerRadius = conrnerRadius;
    self.privateShadowOpacity = shadowOpacity;
    self.privateShadowRadius = shadowRadius;
    self.privateShadowOffset = shadowOffset;
    self.privateShadowColor = shadowColor;
    [self addShadow];
}

- (void)clerBezierPath {
    // 阴影
    if (self.shadowBackgroundView) {
        [self.shadowBackgroundView removeFromSuperview];
        self.shadowBackgroundView = nil;
    }
    
    // 圆角、边框
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:@"CCViewEffects"]) {
            [layer removeFromSuperlayer];
        }
    }
    
    // 恢复默认设置
    self.privateConrnerCorner = UIRectCornerAllCorners;
    self.privateConrnerRadius = 0.0;
    self.privateBorderColor   = [UIColor blackColor];
    self.privateBorderWidth   = 0.0;
    self.privateShadowOpacity = 0.0;
    self.privateShadowRadius  = 0.0;
    self.privateShadowOffset  = CGSizeZero;
    self.privateShadowColor   = [UIColor blackColor];
    self.shadowBackgroundView = nil;
    
    self.layer.masksToBounds  = NO;
    self.layer.cornerRadius   = 0.0;
    self.layer.borderWidth    = 0.0;
    self.layer.borderColor    = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity  = 0.0;
    self.layer.shadowPath     = nil;
    self.layer.shadowRadius   = 0.0;
    self.layer.shadowColor    = [UIColor blackColor].CGColor;
    self.layer.shadowOffset   = CGSizeZero;
    self.layer.mask           = nil;
}

#pragma mark - Private methods
- (UIBezierPath *)drawBezierPath {
    return [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                 byRoundingCorners:self.privateConrnerCorner
                                       cornerRadii:CGSizeMake(self.privateConrnerRadius, self.privateConrnerRadius)];
}


- (void)addShadow {
    UIView *shadowView = self;
    if (self.shadowBackgroundView) {
        [self.shadowBackgroundView removeFromSuperview];
        self.shadowBackgroundView = nil;
    }
    // 阴影
    if (self.privateShadowOpacity > 0) {
        NSAssert(self.superview, @"添加阴影和圆角时，请先将view加到父视图上");
        shadowView = [[UIView alloc] initWithFrame:self.frame];
        shadowView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.superview insertSubview:shadowView belowSubview:self];
        [self.superview addConstraints:@[[NSLayoutConstraint constraintWithItem:shadowView
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:0],
                                         [NSLayoutConstraint constraintWithItem:shadowView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0],
                                         [NSLayoutConstraint constraintWithItem:shadowView
                                                                      attribute:NSLayoutAttributeRight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1.0
                                                                       constant:0],
                                         [NSLayoutConstraint constraintWithItem:shadowView
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0
                                                                       constant:0]]];
        self.shadowBackgroundView = shadowView;
        // 阴影
        shadowView.layer.masksToBounds = NO;
        shadowView.layer.shadowOpacity = self.privateShadowOpacity;
        shadowView.layer.shadowRadius  = self.privateShadowRadius;
        shadowView.layer.shadowOffset  = self.privateShadowOffset;
        shadowView.layer.shadowColor   = self.privateShadowColor.CGColor;
        shadowView.layer.shadowPath    = [self drawBezierPath].CGPath;
    }
}

- (void)addBorderAndRadius {
    // 圆角或阴影或自定义曲线
    if (self.privateConrnerRadius > 0 || self.privateShadowOpacity > 0) {
        // 圆角
        if (self.privateConrnerRadius > 0) {
            UIBezierPath *path = [self drawBezierPath];
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.frame = self.bounds;
            maskLayer.path  = path.CGPath;
            self.layer.mask = maskLayer;
        }
        // 边框
        if (self.privateBorderWidth > 0) {
            for (CALayer *layer in self.layer.sublayers) {
                if ([layer.name isEqualToString:@"CCViewEffects"]) {
                    [layer removeFromSuperlayer];
                }
            }
            UIBezierPath *path = [self drawBezierPath];
            CAShapeLayer *layer = [[CAShapeLayer alloc]init];
            layer.name  = @"CCViewEffects";
            layer.frame = self.bounds;
            layer.path  = path.CGPath;
            layer.lineWidth   = self.privateBorderWidth;
            layer.strokeColor = self.privateBorderColor.CGColor;
            layer.fillColor   = [UIColor clearColor].CGColor;
            [self.layer addSublayer:layer];
        }
    } else {
        // 只有边框
        self.layer.masksToBounds = true;
        self.layer.borderWidth   = self.privateBorderWidth;
        self.layer.borderColor   = self.privateBorderColor.CGColor;
    }
}

@end
