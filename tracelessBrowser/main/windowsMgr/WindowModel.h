//
//  WindowModel.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/30.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WindowModel : NSObject
@property (nonatomic, retain, nullable) WKWebView *webView;
@property (nonatomic, retain, nullable) NSURL *url;
@property (nonatomic, retain) UIImage *imageSnap;

///是否是首页
@property (nonatomic, assign) BOOL isHome;
///首页搜索框内容
@property (nonatomic, retain, nullable) NSString *homeSearchString;

/// 窗口VC中 所在cell的偏移量
@property (nonatomic, assign) CGPoint windowOffSet;
@end

NS_ASSUME_NONNULL_END
