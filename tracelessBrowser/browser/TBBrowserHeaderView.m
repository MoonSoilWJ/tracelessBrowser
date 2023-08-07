//
//  TBBrowserHeaderView.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/2.
//

#import "TBBrowserHeaderView.h"
#import "UIButton+TB.h"
#import "UIImage+RTTint.h"
#import "TBSearchPopView.h"
#import "TBTextView.h"
#import "TBEnginsManager.h"
#import "WindowListViewController.h"

@interface TBBrowserHeaderView(){
    CAGradientLayer *_gradientLayer;
    UIButton *_backBtn;
    UIButton *_homeBtn;
    UIButton *_menuRefreshBtn;
    TBSearchPopView *_pop;
}

@end

@implementation TBBrowserHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)(THEME_COLOR).CGColor, (__bridge id)(THEME_COLOR).CGColor,  (__bridge id)[UIColor whiteColor].CGColor];
        _gradientLayer.locations = @[@0, @0.2, @1.0];
        _gradientLayer.startPoint = CGPointMake(0.5, 0);
        _gradientLayer.endPoint = CGPointMake(0.5, 1);
        _gradientLayer.frame = self.bounds;
//        [self.layer addSublayer:_gradientLayer];
        
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    
    UIImage *back = [UIImage imageNamed:@"toolBar_left_gray"];
    back = [back rt_tintedImageWithColor:THEME_COLOR];
    _backBtn = [UIButton btnWithBgImg:back];
    _backBtn.frame = CGRectMake(20, 5 + STATUS_BAR_HEIGHT, 26, 26);
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(homeAction)];
    [_backBtn addGestureRecognizer:longPress];
    
    UIImage *home = [UIImage imageNamed:@"toolBar_window"];
    home = [home rt_tintedImageWithColor:THEME_COLOR];
    _homeBtn = [UIButton btnWithBgImg:home];
    [_homeBtn setBackgroundImage:home forState:UIControlStateHighlighted];
    [_homeBtn setTitle:[NSString stringWithFormat:@"%zi",WindowManager.sharedInstance.windowsArray.count] forState:UIControlStateNormal];
    [_homeBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    _homeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _homeBtn.frame = CGRectMake(20 + 45, 5.5 + STATUS_BAR_HEIGHT, 25, 25);
    [_homeBtn addTarget:self action:@selector(windowAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_homeBtn];
    
    UIImage *menuRefresh = [UIImage imageNamed:@"menu_refresh"];
    menuRefresh = [menuRefresh rt_tintedImageWithColor:THEME_COLOR];
    _menuRefreshBtn = [UIButton btnWithBgImg:menuRefresh];
    _menuRefreshBtn.frame = CGRectMake(ScreenWidth()-45-42.5, 7.5 + STATUS_BAR_HEIGHT, 20, 20);
    [_menuRefreshBtn addTarget:self action:@selector(menuRefreshAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_menuRefreshBtn];
    
    UIImage *menu = [UIImage imageNamed:@"toolBar_menu"];
    menu = [menu rt_tintedImageWithColor:THEME_COLOR];
    _menuBtn = [UIButton btnWithBgImg:menu];
    _menuBtn.frame = CGRectMake(ScreenWidth()-20-25, 5 + STATUS_BAR_HEIGHT, 25, 25);
    [self addSubview:_menuBtn];
    [_menuBtn addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(_homeBtn.right + 5, STATUS_BAR_HEIGHT + 2, _menuRefreshBtn.left - _homeBtn.right - 0 - 10 , 34)];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont systemFontOfSize:16];
//    _titleLab.numberOfLines = 0;
//    _titleLab.adjustsFontSizeToFitWidth = YES;
    _titleLab.backgroundColor = UIColor.clearColor;
    _titleLab.textColor = THEME_COLOR;
    _titleLab.userInteractionEnabled = YES;
    [self addSubview:_titleLab];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTapped)];
    [_titleLab addGestureRecognizer:tap];
    
    [self addObservers];
}

- (TBSearchPopView *)pop {
    if (!_pop) {
        
        __weak typeof(self) ws = self;
        _pop = [TBSearchPopView popupViewWithFrame:UIScreen.mainScreen.bounds dismissAnimations:^{
        } completion:nil];
        
        _pop.textView.searchTappedBlock = ^(NSString * _Nonnull text) {
            [ws.pop close];
            [ws search:text];
        };
        _pop.textView.searchUrlLinkTappedBlock = ^(NSURL * _Nonnull url) {
            [ws.pop close];
            [ws searchUrl:url];
        };
    }
    return _pop;
}

#pragma mark - action

- (void)backAction {
    if ([self.delegate respondsToSelector:@selector(backBtnTapped)]) {
        [self.delegate backBtnTapped];
    };
}

- (void)homeAction {
    if ([self.delegate respondsToSelector:@selector(homeBtnTapped)]) {
        [self.delegate homeBtnTapped];
    }
}

- (void)windowAction {
    if ([self.delegate respondsToSelector:@selector(windowBtnTapped)]) {
        [self.delegate windowBtnTapped];
    }
}

- (void)menuRefreshAction {
    if ([self.delegate respondsToSelector:@selector(menuRefreshAction)]) {
        [self.delegate menuRefreshAction];
    }
}

- (void)menuAction {
    if ([self.delegate respondsToSelector:@selector(menuBtnTapped)]) {
        [self.delegate menuBtnTapped];
    }
}

- (void)titleTapped {

    self.pop.textView.text = _titleLab.text;
    [self.pop showFrom:self.viewController.view animations:nil completion:nil];
}

- (void)searchUrl:(NSURL *)url {
    if (!url) {
        return;
    }
    NSString *urlStr = url.absoluteString;
    if (![urlStr hasPrefix:@"http://"] && ![urlStr hasPrefix:@"https://"]) {
        urlStr = [NSString stringWithFormat:@"http://%@",urlStr];
    }
    if ([self.delegate respondsToSelector:@selector(searchTapped:)]) {
        [self.delegate searchTapped:urlStr];
    }
}

- (void)search: (NSString *)text {
    
    if ([self.delegate respondsToSelector:@selector(searchTapped:)]) {
        [self.delegate searchTapped:[NSString stringWithFormat:@"%@%@", [TBEnginsManager currentEngineUrl], text]];
    };
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowsCountChangedNoti) name:WINDOWS_COUNT_CHANGED_NOTI_NAME object:nil];
}

- (void)windowsCountChangedNoti {
    [_homeBtn setTitle:[NSString stringWithFormat:@"%zi",WindowManager.sharedInstance.windowsArray.count] forState:UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)deviceOrientionChanged{
    _gradientLayer.frame = self.bounds;
    _backBtn.frame = CGRectMake(20, 5 + STATUS_BAR_HEIGHT, 26, 26);
    _homeBtn.frame = CGRectMake(20 + 45, 5.5 + STATUS_BAR_HEIGHT, 25, 25);
    _menuBtn.frame = CGRectMake(ScreenWidth()-20-30, 5 + STATUS_BAR_HEIGHT, 25, 25);
    _menuRefreshBtn.frame = CGRectMake(ScreenWidth()-45-42.5, 7.5 + STATUS_BAR_HEIGHT, 20, 20);
    _titleLab.frame = CGRectMake(_homeBtn.right + 10, STATUS_BAR_HEIGHT + 2, _menuRefreshBtn.left - _homeBtn.right - 20 , 34);
    
    self.pop.frame = UIScreen.mainScreen.bounds;
    [self.pop deviceOrientionChanged];
}

@end
