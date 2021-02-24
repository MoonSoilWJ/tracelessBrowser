//
//  UIApplication+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (ShortCut)


/**
 *  判断此app是否是盗版(不是appstore的产品)
 *
 *  @return YES, NO
 */
- (BOOL)isPirated;


+ (UINavigationController *)getRootNav;

@end
