//
//  UIButton+TB.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/18.
//

#import "UIButton+TB.h"

@implementation UIButton (TB)
#pragma mark - create

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor {
    return [self btnWithFontSize:fontSize title:title titleColor:titleColor bgColor:nil];
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor{

    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = bgColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)btnWithImg:(UIImage *)img{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:img forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)btnWithBgImg:(UIImage *)bgImg {
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:bgImg forState:UIControlStateNormal];
    return btn;
}

#pragma mark - convenience
- (void)setNormalTitle:(NSString *)nTitle selectedTitle:(NSString *)sTitle{
    [self setTitle:nTitle forState:UIControlStateNormal];
    [self setTitle:sTitle forState:UIControlStateSelected];
}

- (void)setNormalTitleColor:(UIColor *)nColor selectedTitleColor:(UIColor *)sColor{
    [self setTitleColor:nColor forState:UIControlStateNormal];
    [self setTitleColor:sColor forState:UIControlStateSelected];
}

- (void)setNormalImg:(UIImage *)nImg selectedImg:(UIImage *)sImg {
    [self setImage:nImg forState:UIControlStateNormal];
    [self setImage:sImg forState:UIControlStateSelected];
}

- (void)setNormalBgImg:(UIImage *)nBgImg selectedBgImg:(UIImage *)sBgImg {
    [self setBackgroundImage:nBgImg forState:UIControlStateNormal];
    [self setBackgroundImage:sBgImg forState:UIControlStateSelected];
}

- (void)setNormalBgColor:(UIColor *)nBgColor selectedBgColor:(UIColor *)sBgColor {
    UIImage *nBgImg = [self imageWithBgColor:nBgColor];
    UIImage *sBgImg = [self imageWithBgColor:sBgColor];
    [self setNormalBgImg:nBgImg selectedBgImg:sBgImg];
}

#pragma mark - tool
/** 画圆角矩形 */
- (UIImage *)imageWithBgColor:(UIColor *)bgColor{
    
    //1.画image
    CGSize size = CGSizeMake(10, 10);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    //CGContextRef contentRef = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:0];
    [path addClip];
    [bgColor setFill];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //2.可拉伸
    UIEdgeInsets insets = UIEdgeInsetsMake(0, size.height/2.0 + 1, 0, size.height/2.0 +1);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    //3.return
    return image;
}

#pragma mark private function
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event{
    
    CGRect bounds = self.bounds;
    float v = 44;
    if (self.width >= v && self.height >= v) {
        return [super pointInside:point withEvent:event];
    }else if (self.width >= v && self.height < v){
        bounds = CGRectInset(bounds, 0, -(v - self.height)/2.0);
    }else if (self.width < v && self.height >= v){
        bounds = CGRectInset(bounds,-(v - self.width)/2.0,0);
    }else if (self.width < v && self.height < v){
        bounds = CGRectInset(bounds,-(v-self.width)/2.0,-(v-self.height)/2.0);
    }
    return CGRectContainsPoint(bounds, point);
}


@end
