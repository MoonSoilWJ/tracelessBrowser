//
//  UIScreen+ShortCut.m
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "UIScreen+ShortCut.h"


@implementation UIScreen (ShortCut)

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(float)screenScale:(float)scale
{
    float newscale;
    if ([UIScreen mainScreen].bounds.size.height==480)
    {
        newscale=scale*0.84;
    }
    else if ([UIScreen mainScreen].bounds.size.height==568)
    {
        newscale=scale*1.0;
    }
    else if ([UIScreen mainScreen].bounds.size.height==667)
    {
        newscale=scale*1.17;
    }
    else if ([UIScreen mainScreen].bounds.size.height==736)
    {
        newscale=scale*1.29;
    }
    else
    {
        newscale=scale*1.8;
    }
    return ceilf(newscale);
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (CGRect)currentBounds
{
	return [self boundsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation
{
	CGRect bounds = [self bounds];
    
	if (UIInterfaceOrientationIsLandscape(orientation))
    {
		CGFloat buffer = bounds.size.width;
		bounds.size.width = bounds.size.height;
		bounds.size.height = buffer;
	}
	return bounds;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
// should not predicate
//- (BOOL)isRetina
//{
//    return self.scale == 2;
//}

@end
