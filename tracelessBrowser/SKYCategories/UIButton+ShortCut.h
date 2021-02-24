//
//  UIButton+ShortCut.h
//  开吃
//
//  Created by mac  on 14-8-13.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ShortCut)


/**
 *  图片在文字左边
 *
 *  @param fixSpacing 间距
 */
-(void)imageLeftWithTitleFix:(CGFloat)fixSpacing;
/**
 *  图片在文字右边
 *
 *  @param fixSpacing 间距
 */
-(void)imageRightWithTitleFix:(CGFloat)fixSpacing;


/**
 *  图片在文字上面
 *
 *  @param fixSpacing 间距
 */
-(void)imageTopWithTitleFix:(CGFloat)fixSpacing;


/**
 *  图片在文字下面
 *
 *  @param fixSpacing 间距
 */
-(void)imageBottomWithTitleFix:(CGFloat)fixSpacing;




/**
 *  图片在最上面
 *
 *  @param fixSpacing 间距
 */
-(void)sideImageTopWithFix:(CGFloat)fixSpacing;
/**
 *  图片在最左边
 *
 *  @param fixSpacing 间距
 */
-(void)sideImageLeftWithFix:(CGFloat)fixSpacing;
/**
 *  图片在最下面
 *
 *  @param fixSpacing 间距
 */
-(void)sideImageButtomWithFix:(CGFloat)fixSpacing;
/**
 *  图片在最右边
 *
 *  @param fixSpacing 间距
 */
-(void)sideImageRightWithFix:(CGFloat)fixSpacing;




/**
 *  标题在最上面
 *
 *  @param fixSpacing 间距
 */
-(void)sideTitleTopWithFix:(CGFloat)fixSpacing;


/**
 *  标题在最左边
 *
 *  @param fixSpacing 间距
 */
-(void)sideTitleLeftWithFix:(CGFloat)fixSpacing;


/**
 *  标题在最下面
 *
 *  @param fixSpacing 间距
 */
-(void)sideTitleButtomWithFix:(CGFloat)fixSpacing;


/**
 *  标题在最右边
 *
 *  @param fixSpacing 间距
 */
-(void)sideTitleRightWithFix:(CGFloat)fixSpacing;



/**
 *  回归初始数据
 */
-(void)ButtonedgeInsetsZero;
@end
