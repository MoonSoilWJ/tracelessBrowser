//
//  TBSearchInputView.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/17.
//

#import "TBSearchInputView.h"
@interface TBSearchInputView()
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, copy) void(^animationsBlock)(void);
@property (nonatomic, copy) void(^completionBlock)(void);

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL isDragScrollView;
@property (nonatomic, assign) CGFloat lastTransitionY;
@property (nonatomic, strong) UIButton *closeBtn;

@end
@implementation TBSearchInputView

+ (instancetype)popupViewWithFrame:(CGRect)frame dismissAnimations:(void (^)(void))animations completion:(void (^)(void))completion {
    TBSearchInputView *pop =[[TBSearchInputView alloc] initWithFrame:frame];
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
        [self.whiteView bezierPathRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight conrnerRadius:10];
        [self addSubview: self.whiteView];
        
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
    [self showWithAnimations:animations Completion:completion];
}

- (void)showWithAnimations:(void (^)(void))animations Completion:(void (^)(void))completion {
    self.hidden = NO;
    self.closeBtn.hidden = NO;
    self.isShowing = YES;
    NSTimeInterval time = (fabs(endFrame().origin.y - self.whiteView.top))/50 * 0.1;
    time = time > 0.25 ? 0.25 : time;
    [UIView animateWithDuration:time animations:^{
        !animations ?: animations();
        self.whiteView.frame = endFrame();
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
        self.closeBtn.alpha = 1;
    } completion:^(BOOL finished) {
        !completion ? : completion();
    }];
}

//MARK:- action

- (void)close {
    [self endEditing:YES];
    [self dismiss];
}

- (void)dismiss{
    self.isShowing = NO;
    NSTimeInterval time = (fabs(beginFrame().origin.y - self.whiteView.top))/50 * 0.1;
    time = time > 0.25 ? 0.25 : time;
    [UIView animateWithDuration:time animations:^{
        self.whiteView.frame = beginFrame();
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.closeBtn.alpha = 0;
        self.animationsBlock();
    }completion:^(BOOL finished) {
        self.hidden = YES;
        self.closeBtn.hidden = YES;
        self.completionBlock();
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
//        CGPoint velocity = [panGesture velocityInView:self.whiteView];
        
        self.scrollView.panGestureRecognizer.enabled = YES;
        // 结束时的速度>0 滑动距离> 5 且UIScrollView滑动到最顶部
//        if (velocity.y > 0 && self.lastTransitionY > 5 && !self.isDragScrollView) {
        if (self.whiteView.top > (beginFrame().origin.y + endFrame().origin.y )/ 2) {
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

-(void)deviceOrientionChanged{
    if (self.isShowing) {
        self.whiteView.frame = endFrame();
    }else {
        self.whiteView.frame = beginFrame();
    }
    [self.whiteView bezierPathRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight conrnerRadius:10];
    self.closeBtn.frame = CGRectMake(self.whiteView.bounds.size.width - 45, 15, 30, 30);
}

@end
