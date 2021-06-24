//
//  TBSearchPopView.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/2.
//

#import "TBSearchPopView.h"
#import "TBTextView.h"

@interface TBSearchPopView ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, copy) void(^animationsBlock)(void);
@property (nonatomic, copy) void(^completionBlock)(void);

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL isDragScrollView;
@property (nonatomic, assign) CGFloat lastTransitionY;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation TBSearchPopView

+ (instancetype)popupViewWithFrame:(CGRect)frame dismissAnimations:(void (^)(void))animations completion:(void (^)(void))completion {
    TBSearchPopView *pop =[[TBSearchPopView alloc] initWithFrame:frame];
    pop.animationsBlock = animations;
    pop.completionBlock = completion;
    return pop;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.whiteView = [[UIView alloc] initWithFrame:beginFrame()];
        self.whiteView.backgroundColor = UIColor.whiteColor;
        [self.whiteView bezierPathRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight conrnerRadius:10];
        [self addSubview: self.whiteView];
        
        self.textView = [[TBTextView alloc] initWithFrame:CGRectMake(0,50,UIScreen.mainScreen.bounds.size.width, self.whiteView.height)];
        [self.whiteView addSubview:self.textView];
        
        self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.whiteView.bounds.size.width - 45, 15, 30, 30)];
        self.closeBtn.backgroundColor = rgba(240, 240, 240, 1);
        [self.closeBtn bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:15];
        UIImage *image = [UIImage imageNamed:@"circleCloseButton"];
        [self.closeBtn setImage:image forState:UIControlStateNormal];
        self.closeBtn.hidden = YES;
        [self.whiteView addSubview:self.closeBtn];
        [self.closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加手势
        [self.whiteView addGestureRecognizer:self.panGesture];
        
    }
    return self;
}

- (void)showFrom:(UIView *)fromView animations:(void (^)(void))animations completion:(nonnull void (^)(void))completion {
    [fromView addSubview:self];
    [self.textView becomeFirstResponder];
    [self showWithAnimations:animations Completion:completion];
}

- (void)showWithAnimations:(void (^)(void))animations Completion:(void (^)(void))completion {
    self.hidden = NO;
    self.closeBtn.hidden = NO;
    self.isShowing = YES;
//    self.whiteView.frame = endFrame();
    [UIView animateWithDuration:0.25f animations:^{
        !animations ?: animations();
        self.whiteView.frame = beginFrame();
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
        self.closeBtn.alpha = 1;
    } completion:^(BOOL finished) {
        !completion ? : completion();
        self.textView.selectedRange = NSRangeMake(0, self.textView.text.length);
    }];
}

//MARK:- action

- (void)close {
    [self endEditing:YES];
    [self dismiss];
}

- (void)dismiss{
    self.isShowing = NO;
    [UIView animateWithDuration:0.25f animations:^{
        self.whiteView.frame = endFrame();
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.closeBtn.alpha = 0;
        if (self.animationsBlock) {
            self.animationsBlock();
        }
    }completion:^(BOOL finished) {
        self.hidden = YES;
        self.closeBtn.hidden = YES;
        if (self.completionBlock) {
            self.completionBlock();
        }
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (!self.isShowing) {
        return NO;
    }
    if (gestureRecognizer == self.panGesture) {
        UIView *touchView = touch.view;
        while (touchView != nil) {
            if ([touchView isKindOfClass:[UIScrollView class]]) {
                self.scrollView = (UIScrollView *)touchView;
                self.isDragScrollView = YES;
                break;
            }else if (touchView == self.whiteView) {
                self.isDragScrollView = NO;
                break;
            }
            touchView = (UIView *)[touchView nextResponder];
        }
    }
    return YES;
}

// 是否与其他手势共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.panGesture) {
        if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - HandleGesture

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:self.whiteView];
    if (self.isDragScrollView) {
        // 当UIScrollView在最顶部时，处理视图的滑动
        if (self.scrollView.contentOffset.y <= 0) {
            if (translation.y > 0) { // 向下拖拽
                self.scrollView.contentOffset = CGPointZero;
                self.scrollView.panGestureRecognizer.enabled = NO;
                self.isDragScrollView = NO;
                
                CGRect contentFrame = self.whiteView.frame;
                contentFrame.origin.y += translation.y;
                self.whiteView.frame = contentFrame;
            }
        }
    }else {
        CGFloat contentM = (self.frame.size.height - self.whiteView.frame.size.height);
        
        if (translation.y > 0) { // 向下拖拽
            CGRect contentFrame = self.whiteView.frame;
            contentFrame.origin.y += translation.y;
            self.whiteView.frame = contentFrame;
        }else if (translation.y < 0 && self.whiteView.frame.origin.y > contentM) { // 向上拖拽
            CGRect contentFrame = self.whiteView.frame;
            contentFrame.origin.y = MAX((self.whiteView.frame.origin.y + translation.y), contentM);
            self.whiteView.frame = contentFrame;
        }
    }
    
    [panGesture setTranslation:CGPointZero inView:self.whiteView];
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [panGesture velocityInView:self.whiteView];
        NSLog(@"velocity.y=%f",velocity.y);
        
        self.scrollView.panGestureRecognizer.enabled = YES;
        // 结束时的速度>0 滑动距离> 5 且UIScrollView滑动到最顶部
        if (velocity.y > 0 && !self.isDragScrollView && self.whiteView.top > (beginFrame().origin.y + endFrame().origin.y )/ 5) {
//        if (self.whiteView.top > (beginFrame().origin.y + endFrame().origin.y )/ 3) {
            [self dismiss];
        }else {
            [self showWithAnimations:nil Completion:nil];
        }
    }
    
    self.lastTransitionY = translation.y;
    [self endEditing:YES];
}

#pragma mark - 懒加载
- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

-(void)deviceOrientionChanged:(UIDeviceOrientation)deviceOriention {

    if (self.isShowing) {
        self.whiteView.frame = beginFrame();
    }else {
        self.whiteView.frame = endFrame();
    }

    [self.whiteView bezierPathRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight conrnerRadius:10];
    self.textView.frame = CGRectMake(0,50,UIScreen.mainScreen.bounds.size.width, self.whiteView.height);
    self.closeBtn.frame = CGRectMake(self.whiteView.bounds.size.width - 45, 15, 30, 30);
}

@end
