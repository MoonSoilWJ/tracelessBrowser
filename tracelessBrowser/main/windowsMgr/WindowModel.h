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
@end

NS_ASSUME_NONNULL_END
