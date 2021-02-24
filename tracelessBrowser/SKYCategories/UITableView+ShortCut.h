//
//  UITableView+ShortCut.h
//  开吃
//
//  Created by mac  on 14-1-23.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ShortCut)



/**
 *  是否开启IOS7的cell分割线风格(IOS7)
 *
 *  @param separatorInset
 */
-(void)SeparatorInset:(BOOL)separatorInset;





/**
 *  设置Ios7的跟IOS7以下的内容显示的区别
 *
 *  @param contentInset
 */
-(void)ContentInset:(UIEdgeInsets)contentInset;

@end
