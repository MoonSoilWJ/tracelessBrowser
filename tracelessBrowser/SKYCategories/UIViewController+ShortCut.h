//
//  UIViewController+ShortCut.h
//  开吃
//
//  Created by mac  on 14-1-23.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShortCut)

/**
 *  添加左边的leftBarButtonItem(解决IOS7 10px的偏移纠正)
 *
 *  @param leftBarButtonItem
 */
- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem,...NS_REQUIRES_NIL_TERMINATION;



/**
 *  添加右边rightBarButtonItem(解决IOS7 10px的偏移纠正)
 *
 *  @param rightBarButtonItem
 */
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem,...NS_REQUIRES_NIL_TERMINATION;



/**
 *  是否开启全屏布局(ios7)
 *
 *  @param FullScreen
 */
-(void)FullScreen:(BOOL)FullScreen;


/**
 *  是否开启ScrollView可以滚动整个屏幕(ios7)
 *
 *  @param FullScreen
 */
-(void)ScrollFullScreen:(BOOL)FullScreen;


/**
 *  是否开启毛玻璃比较明显(ios7)
 *
 *  @param Translucent
 */
-(void)Translucent:(BOOL)Translucent;


/**
 *  是否开启右滑返回(ios7)
 *
 *  @param GestureRecognizer
 */
-(void)interactivePopGestureRecognizer:(BOOL)GestureRecognizer;


@end
