//
//  UIViewController+ShortCut.m
//  开吃
//
//  Created by mac  on 14-1-23.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "UIViewController+ShortCut.h"

@implementation UIViewController (ShortCut)


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem,...
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        negativeSpacer.width = -10;
        
        NSMutableArray *buttonItemArray=[[NSMutableArray alloc]init];
        [buttonItemArray addObject:negativeSpacer];
        id eachObject;
        va_list argumentList;
        if (leftBarButtonItem)
        {
            [buttonItemArray addObject:leftBarButtonItem];
            va_start(argumentList,leftBarButtonItem);
            while ((eachObject = va_arg(argumentList,id)))
                [buttonItemArray addObject: eachObject];
            va_end(argumentList);
        }
        
        self.navigationItem.leftBarButtonItems=buttonItemArray;
    }
    else
    {
        negativeSpacer.width = 0;
        NSMutableArray *buttonItemArray=[[NSMutableArray alloc]init];
        id eachObject;
        va_list argumentList;
        if (leftBarButtonItem)
        {
            [buttonItemArray addObject:leftBarButtonItem];
            va_start(argumentList,leftBarButtonItem);
            while ((eachObject = va_arg(argumentList,id)))
                [buttonItemArray addObject: eachObject];
            va_end(argumentList);
        }
        self.navigationItem.leftBarButtonItems=buttonItemArray;
    }
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem,...
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        negativeSpacer.width = -10;
        
        NSMutableArray *buttonItemArray=[[NSMutableArray alloc]init];
        [buttonItemArray addObject:negativeSpacer];
        id eachObject;
        va_list argumentList;
        if (rightBarButtonItem)
        {
            [buttonItemArray addObject:rightBarButtonItem];
            va_start(argumentList,rightBarButtonItem);
            while ((eachObject = va_arg(argumentList,id)))
                [buttonItemArray addObject: eachObject];
            va_end(argumentList);
        }
        self.navigationItem.rightBarButtonItems=buttonItemArray;
        
    } else
    {
        negativeSpacer.width = 0;
        NSMutableArray *buttonItemArray=[[NSMutableArray alloc]init];
        id eachObject;
        va_list argumentList;
        if (rightBarButtonItem)
        {
            [buttonItemArray addObject:rightBarButtonItem];
            va_start(argumentList,rightBarButtonItem);
            while ((eachObject = va_arg(argumentList,id)))
                [buttonItemArray addObject: eachObject];
            va_end(argumentList);
        }
        self.navigationItem.rightBarButtonItems=buttonItemArray;
    }
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(void)FullScreen:(BOOL)FullScreen
{
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0)
    {
        if (!FullScreen)
        {
            self.edgesForExtendedLayout=UIRectEdgeNone;
        }
    }
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(void)ScrollFullScreen:(BOOL)FullScreen
{
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0)
    {
        if (FullScreen)
        {
            self.automaticallyAdjustsScrollViewInsets=YES;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
    }
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(void)Translucent:(BOOL)Translucent
{
    self.navigationController.navigationBar.translucent=Translucent;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(void)interactivePopGestureRecognizer:(BOOL)GestureRecognizer
{
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0)
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = GestureRecognizer;
    }
}
@end
