//
//  TBBrowserViewController.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/22.
//

#import <UIKit/UIKit.h>
#import "XYWKWebView.h"
#import "XYScriptMessage.h"
//#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class WindowModel;
@interface TBBrowserViewController : UIViewController

@property (nonatomic, strong) XYWKWebView *webView;
// 完整url
@property (nonatomic, copy) NSString *url;
//// 用户输入的文字内容，头部回显使用
//@property (nonatomic, copy) NSString *userSearchText;

@property (nonatomic, assign) CGFloat contentOffsetY;
/**
 * JS & App 协议的交互名称
 * 用于子类化自由设置,默认 @“webViewApp”
 */
@property (nonatomic, copy) NSString * webViewAppName;

@property (nonatomic, retain) WindowModel *windowModel;

+(instancetype)sharedInstance;

- (void)loadUrl:(WindowModel *)model;

@end

NS_ASSUME_NONNULL_END
