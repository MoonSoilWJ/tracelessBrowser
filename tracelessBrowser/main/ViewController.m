//
//  ViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/17.
//

#import "ViewController.h"
#import "TBSearchInputView.h"
#import "TBTextView.h"
#import "iCarousel.h"
#import "TBBrowserViewController.h"
#import "UIViewController+DeviceOriention.h"
#import "TBEnginsManager.h"
#import "UIImage+RTTint.h"
#import "SettingViewController.h"
#import "WindowListViewController.h"

@interface ViewController ()<iCarouselDelegate,iCarouselDataSource>{
    UIButton *_settingBtn;
    UIButton *_windowBtn;
}

@property(nonatomic, retain) TBTextView *textView;
@property(nonatomic, retain) UIView *backgroundView;
@property(nonatomic, retain) UIView *whiteView;
@property(nonatomic, retain) TBSearchInputView *pop;
@property(nonatomic, retain) UIButton *goButton;
@property(nonatomic, retain) CALayer *layer;
@property (nonatomic, strong) iCarousel *myCarousel;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    XYWKLog(@"viewController-viewDidAppear\n");
    _textView.text = [WindowManager.sharedInstance getcurrentWindow].homeSearchString;
    
    [WindowManager.sharedInstance getcurrentWindow].isHome = YES;
//    [WindowManager.sharedInstance archiveWindows];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backgroundView.backgroundColor = rgba(239, 238, 247, 1);
    [self.view addSubview:self.backgroundView];
    
    [self.backgroundView addSubview:self.myCarousel];

    [self.myCarousel setCurrentItemIndex:[TBEnginsManager currentEngineIndex]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    [self.backgroundView addSubview:self.pop.whiteView];
 
    self.textView = [[TBTextView alloc] initWithFrame:CGRectMake(0,20,UIScreen.mainScreen.bounds.size.width, self.view.height/3)];
    __weak typeof(self) ws = self;
    self.textView.searchTappedBlock = ^(NSString * _Nonnull text) {
        [ws search:text];
    };
    self.textView.searchUrlLinkTappedBlock = ^(NSURL * _Nonnull url) {
        [ws searchUrl:url];
    };
    [self.pop.whiteView addSubview:self.textView];
    
    UISwipeGestureRecognizer *endEditTap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    endEditTap.direction = UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp ;
    [self.textView addGestureRecognizer:endEditTap];
    
    self.goButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth()/2 - 25, ScreenHeight() - TAB_BAR_HEIGHT - self.view.height/7, 60, 60)];
    self.goButton.backgroundColor = UIColor.whiteColor;
    [self.goButton setImage:[UIImage imageNamed:@"logo_alpha"] forState:UIControlStateNormal];
//    [self.goButton setImage:[UIImage imageNamed:@"sou_btn"] forState:UIControlStateHighlighted];
    self.goButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.goButton bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:10];
    [self.goButton addTarget:self action:@selector(goWebView) forControlEvents:UIControlEventTouchUpInside];
   
    self.layer = [CALayer layer];
    self.layer.frame = self.goButton.frame;
    self.layer.backgroundColor = THEME_COLOR.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.3;
    self.layer.cornerRadius = 10;
    [self.view.layer addSublayer:self.layer];
    [self.view addSubview:self.goButton];
    
    _settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, ScreenHeight() - HOME_INDICATOR_HEIGHT - 50, 25, 25)];
    UIImage *image = [[UIImage imageNamed:@"menu_clothes"] rt_tintedImageWithColor:THEME_COLOR];
    [_settingBtn setImage:image forState:UIControlStateNormal];
//    [settingBtn setImage:[UIImage imageNamed:@"circleCloseButton"] forState:UIControlStateHighlighted];
    _settingBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [_settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_settingBtn];
    
    UIImage *window = [UIImage imageNamed:@"toolBar_window"];
    window = [window rt_tintedImageWithColor:THEME_COLOR];
    _windowBtn = [UIButton btnWithBgImg:window];
    [_windowBtn setBackgroundImage:window forState:UIControlStateHighlighted];
    [_windowBtn setTitle:[NSString stringWithFormat:@"%zi",WindowManager.sharedInstance.windowsArray.count] forState:UIControlStateNormal];
    [_windowBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    _windowBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _windowBtn.frame = CGRectMake(20 + _settingBtn.right, _settingBtn.top, _settingBtn.width, _settingBtn.height);
    [_windowBtn addTarget:self action:@selector(jumpWindowListVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_windowBtn];
    
    [self addObservers];
    
}

- (TBSearchInputView *)pop {
    if (!_pop) {
        __weak typeof(self) ws = self;
        _pop = [TBSearchInputView popupViewWithFrame:UIScreen.mainScreen.bounds dismissAnimations:^{
            __strong typeof(ws) strong = ws;
            strong.textView.top = 20;
        } completion:^{
            __strong typeof(ws) strong = ws;
            [strong.backgroundView addSubview:strong.pop.whiteView];
         }];
    }
    return _pop;
}

- (iCarousel *)myCarousel {
    if (!_myCarousel) {
        _myCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 20, ScreenWidth(), 80)];
        _myCarousel.dataSource = self;
        _myCarousel.delegate = self;
        _myCarousel.bounces = NO;
        _myCarousel.clipsToBounds = YES;
        _myCarousel.pagingEnabled = YES;
        _myCarousel.type = iCarouselTypeCustom;
    }
    return _myCarousel;
}


- (void)keyboardWillShow {

}

//MARK: action

- (void)goWebView {
    NSString * string = self.textView.text;
    // 去搜索
    NSRange urlRange = [self.textView rangeOfUrlInText:string];
    if (urlRange.location<=0 && urlRange.length > 0) {
        [self searchUrl:[NSURL URLWithString:[string substringWithRange:urlRange]]];
  
    }else {
        [self search:string];
    }
}

- (void)search:(NSString *)searchString {
    if (searchString.length <= 0) {
        return;
    }
    [self.textView resignFirstResponder];
    [self jumpbrowserVC:[NSString stringWithFormat:@"%@%@", [TBEnginsManager currentEngineUrl], searchString]];
}

- (void)searchUrl:(NSURL *)url {
    if (!url) {
        return;
    }
    [self.textView resignFirstResponder];
    NSString *urlStr = url.absoluteString;
    if (![urlStr hasPrefix:@"http://"] && ![urlStr hasPrefix:@"https://"]) {
        urlStr = [NSString stringWithFormat:@"http://%@",urlStr];
    }
    [self jumpbrowserVC:urlStr];
}

- (void)jumpbrowserVC:(NSString *)urlStr {
    
    WindowModel *model = WindowManager.sharedInstance.getcurrentWindow;
    model.homeSearchString = self.textView.text;
    
    TBBrowserViewController *searchVC ;
//    if (model.browserVC) {
//        searchVC = model.browserVC;
//    }else {
        searchVC = [TBBrowserViewController new];
        searchVC.url = urlStr;
//    }
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)endEdit{
    [self.view endEditing:YES];
}

- (void)settingAction {
    
    SettingViewController *vc = [SettingViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpWindowListVC {
    
    WindowListViewController *windowList = [[WindowListViewController alloc] init];
    WindowModel *model = WindowManager.sharedInstance.getcurrentWindow;
    UIImage *image = self.view.snapshotImageAfterScreenUpdates;
    model.imageSnap = image;
    XYWKLog(@"%@",NSHomeDirectory());
    
    model.homeSearchString = self.textView.text;
    [self.navigationController pushViewController:windowList animated:YES];
}


- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowsCountChangedNoti) name:WINDOWS_COUNT_CHANGED_NOTI_NAME object:nil];
}

- (void)windowsCountChangedNoti {
    [_windowBtn setTitle:[NSString stringWithFormat:@"%zi",WindowManager.sharedInstance.windowsArray.count] forState:UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - iCarouselDataSource - iCarouselDelegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [TBEnginsManager enginesArr].count;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    NSString *currentEngineUrl = [TBEnginsManager enginesArr][carousel.currentItemIndex][@"url"];
    [TBEnginsManager saveCurrentEngineUrl:currentEngineUrl];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (view == nil) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
        view.backgroundColor = UIColor.clearColor;
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 130, 60)];
        whiteView.backgroundColor = UIColor.whiteColor;
        [whiteView bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:10 borderWidth:2 borderColor:THEME_COLOR];
        [view addSubview:whiteView];
        
        UIImageView *imagV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 120, 30)];
        UIImage *image = [TBEnginsManager iconImageforIndex:index];
        imagV.image = image;
        imagV.contentMode = UIViewContentModeScaleAspectFit;
        [whiteView addSubview:imagV];
    }
    return view;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    
    static CGFloat max_sacle = 0.7f;
    static CGFloat min_scale = 0.45f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * self.myCarousel.itemWidth * 1.2, 0, 0);
}

- (CGFloat)carousel:(iCarousel *)carousel
     valueForOption:(iCarouselOption)option
        withDefault:(CGFloat)value {

    switch (option) {
        case iCarouselOptionFadeMin:
            return 0;
        case iCarouselOptionFadeMax:
            return 0;
        case iCarouselOptionFadeRange:
            return [TBEnginsManager enginesArr].count;
        default:
            return value;
    }
}

- (void)skinDidChanged:(NSDictionary *)info {
    NSInteger type = [info[@"type"] integerValue];
    if (type == 0) { //关闭
        bool close = [info[@"close"] boolValue];
        if (close) {
            self.backgroundView.backgroundColor = rgba(239, 238, 247, 1);
            self.pop.whiteView.backgroundColor = UIColor.whiteColor;
        }else {
            self.pop.whiteView.backgroundColor = UIColor.clearColor;
            self.backgroundView.backgroundColor = UIColor.clearColor;
        }
    }
}

//MARK: - deviceOrientionChangedProtocol
- (void)deviceOrientionChanged:(UIDeviceOrientation)deviceOrientation {
//    [super deviceOrientionChanged:deviceOrientation];
    
    self.backgroundView.frame  = self.view.bounds;
    self.myCarousel.frame = CGRectMake(0, STATUS_BAR_HEIGHT + 20, ScreenWidth(), 80);
    self.goButton.frame = CGRectMake(ScreenWidth()/2 - 25, ScreenHeight() - TAB_BAR_HEIGHT - self.view.height/7, 60, 60);
    self.layer.frame = self.goButton.frame;
    self.pop.frame = UIScreen.mainScreen.bounds;
    [self.pop deviceOrientionChanged:deviceOrientation];
    
    self.textView.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, self.view.height/3);
    _settingBtn.frame = CGRectMake(20, ScreenHeight() - HOME_INDICATOR_HEIGHT - 50, 25, 25);
    _windowBtn.frame = CGRectMake(20 + _settingBtn.right, _settingBtn.top, _settingBtn.width, _settingBtn.height);
}

@end
