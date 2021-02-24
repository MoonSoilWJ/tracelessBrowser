//
//  UIScrollView+TBScreenGesture.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/24.
//

#import "UIScrollView+TBScreenGesture.h"

@implementation UIScrollView (TBScreenGesture)

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer.view isKindOfClass:NSClassFromString(@"WKScrollView")]) {
        CGPoint point = [gestureRecognizer locationInView:self.viewController.view];
        if (point.x <= self.viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge) {
            return NO;
        }
    }
    return YES;
}

@end
