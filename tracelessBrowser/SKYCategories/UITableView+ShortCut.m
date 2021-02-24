//
//  UITableView+ShortCut.m
//  开吃
//
//  Created by mac  on 14-1-23.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "UITableView+ShortCut.h"

@implementation UITableView (ShortCut)

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(void)SeparatorInset:(BOOL)separatorInset
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        if (!separatorInset)
        {
           self.separatorInset=UIEdgeInsetsZero;
        }
    }
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(void)ContentInset:(UIEdgeInsets)contentInset
{
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0)
    {
        self.contentInset=contentInset;
    }
    else
    {
        self.contentInset=UIEdgeInsetsZero;
    }
}
@end
