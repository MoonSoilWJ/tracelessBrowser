//
//  BrowserTransition.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/4/12.
//

#import "BrowserTransition.h"
#import "WindowListViewController.h"
#import "WindowManager.h"

@interface BrowserTransition () {
    BrowserTransitionType _type;
}
@end

@implementation BrowserTransition

- (instancetype)initWithType:(BrowserTransitionType) type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

+ (BrowserTransition *)transitionWithTransitionType:(BrowserTransitionType )type {
    return [[BrowserTransition alloc] initWithType:type];
}

// MARK: - delegate
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
//        case BrowserTransitionTypePopToNewHomeV:
//            return 0.1;
//            break;
        default:
            return .5;
            break;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case BrowserTransitionTypePushToWindowList:
            [self pushToWindowsListAnimationTransitionContext:transitionContext];
            break;
        case BrowserTransitionTypePopToHomeFromWindowList:
            [self popToBrowserFromWindowsListAnimation:transitionContext];
            break;
        case BrowserTransitionTypePopToBrowserFromWindowList:
            [self popToBrowserFromWindowsListAnimation:transitionContext];
            break;
//        case BrowserTransitionTypePopToNewHomeV:
//            [self popToNewHomeFromWindowsListAnimation:transitionContext];
//            break;;
        default:
            break;
    }
}

/// 进入窗口管理
- (void) pushToWindowsListAnimationTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    WindowListViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toVC.view];

    UICollectionView *collectionView = toVC.collectionView;
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForItem:WindowManager.sharedInstance.currentWindowIndex inSection:0];
    UICollectionViewLayoutAttributes *att = [collectionView layoutAttributesForItemAtIndexPath:selectIndexPath];

    CGRect frame = [toVC.view convertRect:att.frame fromView:collectionView];
    
    // 用于遮挡动画时snap过渡缩小时出现的重影
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    contentView.backgroundColor = collectionView.backgroundColor;
    [containerView addSubview:contentView];
    
    //快照
    UIImageView *snapshotView = [[UIImageView alloc] initWithFrame: fromVC.view.frame];
    snapshotView.image = [WindowManager.sharedInstance getcurrentWindow].imageSnap;
    snapshotView.layer.cornerRadius = 7;
    snapshotView.layer.masksToBounds = true;
    snapshotView.contentMode = UIViewContentModeScaleAspectFill;
    [containerView addSubview:snapshotView];

    fromVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        snapshotView.frame = frame;
    } completion:^(BOOL finished) {
        fromVC.view.alpha = 1;
        [contentView removeFromSuperview];
        [snapshotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

/// 从窗口管理打开浏览器
- (void)popToBrowserFromWindowsListAnimation:( id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    WindowListViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toVC.view];
    
    UICollectionView *collectionView = fromVC.collectionView;
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForItem:WindowManager.sharedInstance.currentWindowIndex inSection:0];
    UICollectionViewLayoutAttributes *att = [collectionView layoutAttributesForItemAtIndexPath:selectIndexPath];
    CGRect frame = [containerView convertRect:att.frame fromView:collectionView];
    
    UIImageView *snapshotView = [[UIImageView alloc] initWithFrame:frame];
    UIImage *snap = [WindowManager.sharedInstance getcurrentWindow].imageSnap;
    snapshotView.image = snap ? snap : toVC.view.snapshotImage;
    snapshotView.contentMode = UIViewContentModeScaleAspectFill;
    snapshotView.layer.cornerRadius = 7;
    snapshotView.layer.masksToBounds = true;
    [containerView addSubview:snapshotView];
    
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        snapshotView.frame = toVC.view.frame;
    } completion:^(BOOL finished) {
        toVC.view.alpha = 1;
        [snapshotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

/// 新增首页
//- (void)popToNewHomeFromWindowsListAnimation:( id <UIViewControllerContextTransitioning>)transitionContext {
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *containerView = transitionContext.containerView;
//    [containerView addSubview:toVC.view];
//
//    toVC.view.alpha = 0;
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//    } completion:^(BOOL finished) {
//        toVC.view.alpha = 1;
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
//}
@end
