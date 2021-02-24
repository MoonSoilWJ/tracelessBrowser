//
//  TBCopyActivity.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WKWebView;
@interface TBCopyActivity : UIActivity

- (instancetype)initWithWebView:(WKWebView *)webView;

@end

NS_ASSUME_NONNULL_END
