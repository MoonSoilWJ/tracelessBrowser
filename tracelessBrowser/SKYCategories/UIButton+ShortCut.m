//
//  UIButton+ShortCut.m
//  
//
//  Created by mac  on 14-8-13.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "UIButton+ShortCut.h"
#import "UIView+ShortCut.h"

@implementation UIButton (ShortCut)

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)imageTopWithTitleFix:(CGFloat)fixSpacing
{
    [self resetImageAndTitleWithFix:fixSpacing/2 withType:0];
    
}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)imageLeftWithTitleFix:(CGFloat)fixSpacing
{
    
    [self resetImageAndTitleWithFix:fixSpacing/2 withType:1];
}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)imageBottomWithTitleFix:(CGFloat)fixSpacing
{
    [self resetImageAndTitleWithFix:fixSpacing/2 withType:2];
}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)imageRightWithTitleFix:(CGFloat)fixSpacing
{
    [self resetImageAndTitleWithFix:fixSpacing/2 withType:3];
}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)resetImageAndTitleWithFix:(CGFloat)fixSpacing withType:(NSInteger)type
{
    //取得中心点(按钮默认图片在左文字在右)
    CGPoint startImageViewCenter = self.imageView.center;
    CGPoint startTitleLabelCenter = self.titleLabel.center;
    
    CGRect imageBounds =self.imageView.bounds;
    CGRect titleBounds = self.titleLabel.bounds;
    
    CGFloat imageEdgeInsetsTop=0, imageEdgeInsetsLeft=0, imageEdgeInsetsBottom=0, imageEdgeInsetsRight=0;
    CGFloat titleEdgeInsetsTop=0, titleEdgeInsetsLeft=0, titleEdgeInsetsBottom=0, titleEdgeInsetsRight=0;
    
    switch (type)
    {
        case 0:
        {
            //Top
            // 设置imageEdgeInsets    向上移的高度为文本高度的一半,向左移动到整个按钮的中心点
            imageEdgeInsetsTop = -CGRectGetMidY(titleBounds)-fixSpacing;
            imageEdgeInsetsLeft = CGRectGetMidX(self.bounds) - startImageViewCenter.x;
            imageEdgeInsetsBottom = -imageEdgeInsetsTop;
            imageEdgeInsetsRight = -imageEdgeInsetsLeft;
            
            // 设置titleEdgeInsets    向下移的高度为图片高度的一半,向左移动到整个按钮的中心点
            titleEdgeInsetsTop = CGRectGetMidY(imageBounds)+fixSpacing;
            titleEdgeInsetsLeft = CGRectGetMidX(self.bounds) - startTitleLabelCenter.x;
            titleEdgeInsetsBottom = -titleEdgeInsetsTop;
            titleEdgeInsetsRight = -titleEdgeInsetsLeft;
        }
            break;
        case 1:{
            //Left
            // 设置imageEdgeInsets    上下左右不变在按钮中心点,只移动间距
            imageEdgeInsetsTop = 0;
            imageEdgeInsetsLeft = -fixSpacing;
            imageEdgeInsetsBottom = 0;
            imageEdgeInsetsRight = -imageEdgeInsetsLeft;
            
            // 设置titleEdgeInsets    上下左右不变在按钮中心点,只移动间距
            titleEdgeInsetsTop = 0;
            titleEdgeInsetsLeft = fixSpacing;
            titleEdgeInsetsBottom = 0;
            titleEdgeInsetsRight = -titleEdgeInsetsLeft;
        }
            break;
        case 2:{
            //Buttom
            // 设置imageEdgeInsets    向下移的高度为文本高度的一半,向左移动到整个按钮的中心点
            imageEdgeInsetsTop = CGRectGetMidY(titleBounds)+fixSpacing;
            imageEdgeInsetsLeft = CGRectGetMidX(self.bounds) - startImageViewCenter.x;
            imageEdgeInsetsBottom = -imageEdgeInsetsTop;
            imageEdgeInsetsRight = -imageEdgeInsetsLeft;
            
            // 设置titleEdgeInsets    向上移的高度为文本高度的一半,向左移动到整个按钮的中心点
            titleEdgeInsetsTop = -CGRectGetMidY(imageBounds)-fixSpacing;
            titleEdgeInsetsLeft = CGRectGetMidX(self.bounds) - startTitleLabelCenter.x;
            titleEdgeInsetsBottom = -titleEdgeInsetsTop;
            titleEdgeInsetsRight = -titleEdgeInsetsLeft;
        }
            break;
        case 3:{
            //Right
            // 设置imageEdgeInsets    上下不变在按钮中心点,移动文本的宽度
            imageEdgeInsetsTop = 0;
            imageEdgeInsetsLeft = titleBounds.size.width+fixSpacing;
            imageEdgeInsetsBottom = -imageEdgeInsetsTop;
            imageEdgeInsetsRight = -imageEdgeInsetsLeft;
            
            // 设置titleEdgeInsets    上下不变在按钮中心点,移动图片的宽度
            titleEdgeInsetsTop = 0;
            titleEdgeInsetsLeft = -imageBounds.size.width-fixSpacing;
            titleEdgeInsetsBottom = -titleEdgeInsetsTop;
            titleEdgeInsetsRight = -titleEdgeInsetsLeft;
        }
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsetsTop,imageEdgeInsetsLeft, imageEdgeInsetsBottom,imageEdgeInsetsRight);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop,titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideImageTopWithFix:(CGFloat)fixSpacing
{
    //取得中心点(按钮默认图片在左文字在右)
    CGPoint startImageViewCenter = self.imageView.center;
    CGRect imageBounds = self.imageView.bounds;
    CGFloat imageEdgeInsets = startImageViewCenter.y - CGRectGetMinY(imageBounds) - fixSpacing;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, imageEdgeInsets, 0);
}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideImageLeftWithFix:(CGFloat)fixSpacing
{
    CGPoint startImageViewCenter = self.imageView.center;
    CGRect imageBounds = self.imageView.bounds;
    CGFloat imageEdgeInsets = startImageViewCenter.x - CGRectGetMidX(imageBounds) -fixSpacing;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -imageEdgeInsets, 0,imageEdgeInsets);
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideImageButtomWithFix:(CGFloat)fixSpacing
{
    //取得中心点(按钮默认图片在左文字在右)
    CGPoint startImageViewCenter = self.imageView.center;
    CGRect imageBounds = self.imageView.bounds;
    CGFloat imageEdgeInsets = startImageViewCenter.y - CGRectGetMinY(imageBounds) -fixSpacing;
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsets, 0, 0, 0);
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideImageRightWithFix:(CGFloat)fixSpacing
{
    CGPoint startImageViewCenter = self.imageView.center;
    CGRect imageBounds = self.imageView.bounds;
    CGFloat imageEdgeInsets = self.width - startImageViewCenter.x -CGRectGetMidX(imageBounds)-fixSpacing;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, imageEdgeInsets, 0, -imageEdgeInsets);
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideTitleTopWithFix:(CGFloat)fixSpacing
{
    //取得中心点(按钮默认图片在左文字在右)
    CGPoint startTitleCenter = self.titleLabel.center;
    CGRect titleBounds = self.titleLabel.bounds;
    CGFloat titleEdgeInsets = startTitleCenter.y - CGRectGetMinY(titleBounds) - fixSpacing;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, titleEdgeInsets, 0);
}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideTitleLeftWithFix:(CGFloat)fixSpacing
{
    CGPoint startTitleCenter = self.titleLabel.center;
    CGRect titleBounds = self.titleLabel.bounds;
    CGFloat titleEdgeInsets = startTitleCenter.x - CGRectGetMidX(titleBounds) -fixSpacing;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -titleEdgeInsets, 0,titleEdgeInsets);
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideTitleButtomWithFix:(CGFloat)fixSpacing
{
    //取得中心点(按钮默认图片在左文字在右)
    CGPoint startTitleCenter = self.titleLabel.center;
    CGRect titleBounds = self.titleLabel.bounds;
    CGFloat titleEdgeInsets = startTitleCenter.y - CGRectGetMinY(titleBounds) -fixSpacing;
    self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsets, 0, 0, 0);
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)sideTitleRightWithFix:(CGFloat)fixSpacing
{
    CGPoint startTitleCenter = self.titleLabel.center;
    CGRect titleBounds = self.titleLabel.bounds;
    CGFloat titleEdgeInsets = self.width - startTitleCenter.x -CGRectGetMidX(titleBounds)-fixSpacing;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, titleEdgeInsets, 0, -titleEdgeInsets);
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(void)ButtonedgeInsetsZero
{
    self.imageEdgeInsets = UIEdgeInsetsZero;
    self.titleEdgeInsets =UIEdgeInsetsZero;
}

@end
