//
//  UIView+LayerPath.m
//  Tairong
//
//  Created by yuekewei on 2019/8/6.
//

#import "UIView+LayerPath.h"

@implementation UIView (LayerPath)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(setFrame:)), class_getInstanceMethod(self, @selector(category_setFrame:)));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(setBounds:)), class_getInstanceMethod(self, @selector(category_setBounds:)));
    });
}

- (void)category_setFrame:(CGRect)frame {
    BOOL boundsChanged = !CGSizeEqualToSize(frame.size, self.bounds.size);
    [self category_setFrame:frame];
    if (self.viewBoundsChanged && boundsChanged) {
        self.viewBoundsChanged();
    }
}

- (void)category_setBounds:(CGRect)bounds {
    BOOL boundsChanged = !CGSizeEqualToSize(bounds.size, self.bounds.size);
    [self category_setBounds:bounds];
    if (self.viewBoundsChanged && boundsChanged) {
        self.viewBoundsChanged();
    }
}

- (void)setViewBoundsChanged:(ViewBoundsChanged)viewBoundsChanged {
     objc_setAssociatedObject(self, @selector(viewBoundsChanged), viewBoundsChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ViewBoundsChanged)viewBoundsChanged {
    return objc_getAssociatedObject(self, _cmd);
}

/**
 绘制虚线
 
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
- (void)drawDashLineWithlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    __weak typeof (self) weakSelf = self;
    self.viewBoundsChanged = ^{
        __strong typeof (self) self = weakSelf;
        NSString *layerName = @"Dash";
        [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:layerName]) {
                [obj removeFromSuperlayer];
                *stop = YES;
            }
        }];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.name = layerName;
        [shapeLayer setBounds:self.bounds];
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame))];
        [shapeLayer setFillColor:[UIColor clearColor].CGColor];
        [shapeLayer setStrokeColor:lineColor.CGColor];
        [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
        [shapeLayer setLineJoin:kCALineJoinRound];
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
        [shapeLayer setPath:path];
        CGPathRelease(path);
        
        [self.layer addSublayer:shapeLayer];
    };
    
    if (!CGRectEqualToRect(self.bounds, CGRectZero)) {
        self.viewBoundsChanged();
    }
}

@end
