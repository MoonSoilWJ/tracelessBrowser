//
//  UIApplication+ShortCut.m
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "UIApplication+ShortCut.h"
#import "AppDelegate.h"

@implementation UIApplication (ShortCut)


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (BOOL)isPirated
{
    
    if ([[[NSBundle mainBundle] infoDictionary]
         objectForKey:@"SignerIdentity"]) {
        return YES;
    }
    
    if (![self _fileExistMainBundle:@"_CodeSignature"]) {
        return YES;
    }
    
    if (![self _fileExistMainBundle:@"CodeResources"])
    {
        return YES;
    }
    
    if (![self _fileExistMainBundle:@"ResourceRules.plist"]) {
        return YES;
    }
    
    //you may test binary's modify time ...but,
    //if someone want to crack your app, this method is useless..
    //you need to change this method's name and do more check..
    return NO;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (BOOL)_fileExistMainBundle:(NSString *)name {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *path = [NSString stringWithFormat:@"%@/%@", bundlePath, name];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (UINavigationController *)getRootNav{
   // return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    /* keywindow会出现bug,参考:
     https://stackoverflow.com/questions/21698482/diffrence-between-uiapplication-sharedapplication-delegate-window-and-u/42996156#42996156
     http://www.jianshu.com/p/ae84cd31d8f0
     */
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appdelegate.window.rootViewController;
    
    if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)rootViewController;
    }
    else if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    
    return nil;
}
@end
