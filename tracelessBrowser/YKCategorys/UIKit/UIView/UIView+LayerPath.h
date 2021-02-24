//
//  UIView+LayerPath.h
//  Tairong
//
//  Created by yuekewei on 2019/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LayerPath)

typedef void (^ViewBoundsChanged) (void);

@property(nonatomic, copy) ViewBoundsChanged viewBoundsChanged;

/**
 绘制虚线
 
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
- (void)drawDashLineWithlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
