//
//  TBBrowserViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/22.
//

#import "TBBrowserViewController.h"
#import "XYWKTool.h"
#import "UIScrollView+TBScreenGesture.h"
#import "UIViewController+DeviceOriention.h"
#import "TBBrowserHeaderView.h"
#import "TBEnginsManager.h"
#import "TBScreenShotActivity.h"
#import "TBCopyActivity.h"
#import "TBHistoryActivity.h"
#import "WindowListViewController.h"
#import "WindowModel.h"

@interface TBBrowserViewController ()<WKUIDelegate, WKNavigationDelegate,XYWKWebViewMessageHandleDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate, BrowserHeadBtnProtocol>

@property (nonatomic, strong) UIProgressView  *progressView;
@property (nonatomic, strong) NSTimer *progressATimer;
@property (nonatomic, strong) NSTimer *progressBTimer;
@property (nonatomic, strong) TBBrowserHeaderView *head;
@end

@implementation TBBrowserViewController

+ (instancetype)sharedInstance {
    static TBBrowserViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TBBrowserViewController alloc] init];
    });
    return instance;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [WindowManager.sharedInstance getcurrentWindow].isHome = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 30;
//    self.navigationController.fd_fullscreenPopGestureRecognizer.delegate = self;
    self.view.backgroundColor = UIColor.whiteColor;
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    self.webView = [[XYWKWebView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 44, ScreenWidth(), ScreenHeight() - STATUS_BAR_HEIGHT - 44) configuration:config];
    [config.userContentController addScriptMessageHandler:self.webView name:_webViewAppName];
    self.webView.xy_messageHandlerDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.delegate = self;
    
    [self.webView.failView.confirmButton addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView loadRequestWithRelativeUrl:self.url];
    [self.view addSubview:self.webView];
    
    _head = [[TBBrowserHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), 44 + STATUS_BAR_HEIGHT)];
    _head.delegate = self;
    [self.view addSubview:_head];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    XYWKLog(@"dealloc --- %@",NSStringFromClass([self class]));
}

//MARK: - public

//MARK: - private

- (void)reloadData {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webView.URL ?: [NSURL URLWithString:self.webView.webViewRequestUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20]];
}

//MARK: - gestureRecognizer

//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
//{
//    // Ignore when no view controller is pushed into the navigation stack.
//    if (self.navigationController.viewControllers.count <= 1) {
//        return NO;
//    }
//
//    // Ignore when the active view controller doesn't allow interactive pop.
//    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
//    if (topViewController.fd_interactivePopDisabled) {
//        return NO;
//    }
//
//    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
//    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
//    CGFloat maxAllowedInitialDistance = topViewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;
//    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
//        return NO;
//    }
//
//    // Ignore pan gesture when the navigation controller is currently in transition.
//    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
//        return NO;
//    }
//
//    return YES;
//}

#pragma mark - UI

- (void)progressStepA {
    
    if (self.progressATimer) {
        [self.progressATimer invalidate];
        self.progressATimer = nil;
        self.progressView.progress = 0;
    }
    
    self.progressATimer = [NSTimer scheduledTimerWithTimeInterval:0.02 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        float progress = self.progressView.progress;
        if(progress >= 0.8){
            [timer invalidate];
            timer = nil;
            return;
        }
        if(progress >= 0.6){
            progress += 0.01;
        }else{
            progress += 0.03;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLoadingProgress:progress andTintColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        });
    }];
}

- (void)progressStepB {
    if (self.progressBTimer) {
        [self.progressBTimer invalidate];
        self.progressBTimer = nil;
    }
    self.progressBTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 repeats:YES block:^(NSTimer * _Nonnull timer) {
        float progress = self.progressView.progress;
        if(progress >= 1){
            [self hideLoadingProgressView];
            [timer invalidate];
            timer = nil;
            return;
        }
        progress += 0.02;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLoadingProgress:progress andTintColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        });
    }];
}

- (UIProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 44, XYWKScreenW, 1)];
    }
    return _progressView;
}


- (void)hideLoadingProgressView{
    [self.progressView removeFromSuperview];
    self.progressView = nil;
}

- (void)showLoadingProgress:(CGFloat)progress andTintColor:(UIColor *)color{
    
    if (!self.progressView.superview) {
        [self.view addSubview:self.progressView];
    }
    
    self.progressView.progress = progress;
    self.progressView.progressTintColor = color;
    self.progressView.trackTintColor = [UIColor whiteColor];
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == self.webView) {
            if (self.webView.estimatedProgress >= 1.0f) {
                [self progressStepB];
            }else if (self.webView.estimatedProgress <= 0.11) {
                [self progressStepA];
            }
        }
    }else if ([keyPath isEqualToString:@"canGoBack"]) {
        [self judgeCanSwipeBack];
    }
}

#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    XYWKLog(@"%s：%@", __FUNCTION__,webView.URL);
//    [self judgeCanSwipeBack];
    
    _head.titleLab.text = [[webView.URL.absoluteString  stringByRemovingPercentEncoding] stringByReplacingOccurrencesOfString:[TBEnginsManager currentEngineUrl] withString:@""];
    
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    XYWKLog(@"%s", __FUNCTION__);
//    [self judgeCanSwipeBack];
    
    [WindowManager.sharedInstance getcurrentWindow].url = webView.URL;
    //    [WindowManager.sharedInstance getcurrentWindow].webView = webView;
    
    //    [WindowManager.sharedInstance archiveWindows];
}
/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    // 实际上是首页加载完成之后就会走这个方法
    XYWKLog(@"%s 这个页面加载完成了",__func__);
//    [self judgeCanSwipeBack];
    
    self.webView.failView.hidden = YES;
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    XYWKLog(@"%s%@", __FUNCTION__,error);
//    [self judgeCanSwipeBack];
    [self progressStepB];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    XYWKLog(@"%s%@", __FUNCTION__,error);
    if (error.code == -1001 ||
        error.code == -1003 ||
        error.code == -1009) {
        self.webView.failView.hidden = NO;
    }
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    XYWKLog(@"%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    XYWKLog(@"%s", __FUNCTION__);
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    [self judgeCanSwipeBack];
    //返回+2的枚举值,禁止universal link
    decisionHandler(WKNavigationActionPolicyAllow + 2);
    
}

//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
//    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
//        NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
//        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//    }
//}

#pragma mark - scrollview delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    XYWKLog(@"y:%f",scrollView.contentOffset.y);
//    [[NSUserDefaults standardUserDefaults] setFloat:scrollView.contentOffset.y forKey:@"browserY"];
//}

//MARK: - head menu Delegate

- (void)backBtnTapped {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        [self.navigationController  popViewControllerAnimated:YES];
    }
}

- (void)homeBtnTapped {
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)windowBtnTapped {
    
    [self.webView stopLoading];
    
    WindowListViewController *windowList = [[WindowListViewController alloc] init];
    [self.navigationController pushViewController:windowList animated:YES];
    
    UIImage *image = self.view.snapshotImage;
    WindowManager.sharedInstance.getcurrentWindow.imageSnap = image;
    WindowManager.sharedInstance.getcurrentWindow.browserVC = self;
    [self removeFromParentViewController];
}

- (void)menuRefreshAction {
    [self.webView reload];
}

// 分享
- (void)menuBtnTapped {
    NSArray *activityItems = [NSArray arrayWithObjects:self.webView.URL, nil];
    
    UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[
        //        [[TBCreateNewActivity alloc] init],
        [[TBScreenShotActivity alloc] initWithWebView:self.webView],
        [[TBCopyActivity alloc] initWithWebView:self.webView],
    ]];
    aVC.excludedActivityTypes = @[UIActivityTypeAddToReadingList,UIActivityTypeCopyToPasteboard];
    aVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) //分享回调
    {
        if (completed) {
            if ([activityType isEqualToString:@"history"]) { //浏览记录
                [self jumpHistory];
            } else {
                
            }
        }
        else {
        }
    };
    
    UIPopoverPresentationController*popover = aVC.popoverPresentationController;
    if (popover) {
        popover.sourceView = self.head.menuBtn;
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    
    [self presentViewController:aVC animated:true completion:nil];
}

- (void)searchTapped:(NSString *)urlStr {
    [self.webView loadRequestWithRelativeUrl:urlStr];
}

#pragma mark - private

- (void)judgeCanSwipeBack {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if ([self.webView canGoBack]) {
            self.fd_interactivePopDisabled = YES;
        }else {
            self.fd_interactivePopDisabled = NO;
        }
    }
}

- (NSString *)valueForParam:(NSString *)param inUrl:(NSURL *)url {
    
    NSArray *queryArray = [url.query componentsSeparatedByString:@"&"];
    for (NSString *params in queryArray) {
        NSArray *temp = [params componentsSeparatedByString:@"="];
        if ([[temp firstObject] isEqualToString:param]) {
            return [temp lastObject];
        }
    }
    return @"";
}

- (NSMutableDictionary *)paramsOfUrl:(NSURL *)url {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    
    NSArray *queryArray = [url.query componentsSeparatedByString:@"&"];
    for (NSString *params in queryArray) {
        NSArray *temp = [params componentsSeparatedByString:@"="];
        NSString *key = [temp firstObject];
        NSString *value = temp.count == 2 ? [temp lastObject]:@"";
        [paramDict setObject:value forKey:key];
    }
    return paramDict;
}

- (NSString *)stringByJoinUrlParams:(NSDictionary *)params {
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in params.allKeys) {
        [arr addObject:[NSString stringWithFormat:@"%@=%@",key,params[key]]];
    }
    return [arr componentsJoinedByString:@"&"];
}

- (NSString *)urlWithoutQuery:(NSURL *)url {
    NSRange range = [url.absoluteString rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        return [url.absoluteString substringToIndex:range.location];
    }
    return url.absoluteString;
}

- (void)jumpHistory {
    
}

#pragma mark - WKUIDelegate

/**
 *  处理js里的alert
 *
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 *  处理js里的confirm
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 *  处理js里的 textInput 需要在根据情况做
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:prompt preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alert.textFields.firstObject.text);
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (navigationAction.targetFrame.isMainFrame == NO) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKContextMenuElementInfo *)elementInfo {
    return NO;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self resizeViews];
}

- (void)resizeViews {
    //update views here, e.g. calculate your view
    self.webView.frame = CGRectMake(0, STATUS_BAR_HEIGHT + 44, ScreenWidth(), ScreenHeight() - STATUS_BAR_HEIGHT - 44);
    _progressView.frame = CGRectMake(0, STATUS_BAR_HEIGHT + 44, XYWKScreenW, 1);
    
    self.webView.failView.frame = self.webView.bounds;
    [self.webView.failView deviceOrientionChanged];
    
    _head.frame = CGRectMake(0, 0, ScreenWidth(), 44 + STATUS_BAR_HEIGHT);
    [_head deviceOrientionChanged];
}

//MARK: device oriention changed
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self resizeViews];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

//
////MARK: 换肤通知
//- (void)skinDidChanged:(NSDictionary *)info {
//    NSInteger type = [info[@"type"] integerValue];
//    if (type == 0) { //关闭
//        bool close = [info[@"close"] boolValue];
//        if (close) {
//            self.head.backgroundColor = UIColor.whiteColor;
//        }else {
//            self.head.backgroundColor = UIColor.whiteColor;
//        }
//    }
//}

@end
