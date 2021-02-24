//
//  TBSearchPopView.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/2.
//

#import <UIKit/UIKit.h>

#define endFrame() CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (STATUS_BAR_HEIGHT + 0))

#define beginFrame()  CGRectMake(0, STATUS_BAR_HEIGHT + 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (STATUS_BAR_HEIGHT + 0))


@class TBTextView;
@interface TBSearchPopView : UIView

@property (nonatomic, retain) UIView *whiteView;
@property (nonatomic, retain) TBTextView *textView;

@property (nonatomic, assign) bool isShowing;

+ (instancetype)popupViewWithFrame:(CGRect)frame dismissAnimations:(void (^)(void))animations completion:(void (^)(void))completion;

- (void)showFrom:(UIView *)fromView animations:(void (^)(void))animations completion:(void (^)(void))completion;

- (void)deviceOrientionChanged:(UIDeviceOrientation)deviceOriention;

- (void)close;

@end
