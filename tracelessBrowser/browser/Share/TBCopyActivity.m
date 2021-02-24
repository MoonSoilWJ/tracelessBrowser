//
//  TBCopyActivity.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/7.
//

#import "TBCopyActivity.h"
#import "UIView+Toast.h"
#import <WebKit/WebKit.h>

@interface TBCopyActivity(){
    WKWebView *_web;
}
@end
@implementation TBCopyActivity

- (instancetype)initWithWebView:(WKWebView *)webView {
    self = [super init];
    if (self) {
        _web = webView;
    }
    return self;
}

+(UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (UIActivityType)activityType{
    return @"CopyUrl";
}

- (NSString *)activityTitle {
    return @"复制链接";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    NSURL *url = [activityItems firstObject];
    [UIPasteboard generalPasteboard].string = url.absoluteString;
    [_web.viewController.view makeToast:@"复制成功"];
}

@end
