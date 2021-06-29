//
//  TBScreenShotActivity.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/7.
//

#import "TBScreenShotActivity.h"
#import "UIView+ShortCut.h"
#import <Photos/Photos.h>
#import <WebKit/WebKit.h>
#import "UIView+Toast.h"

@interface TBScreenShotActivity(){
    WKWebView *_web;
}
@end
@implementation TBScreenShotActivity

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

//- (UIImage *)activityImage {
//    return [UIImage imageNamed:@"logo_alpha"];
//}

- (NSString *)activityTitle {
    return @"截长图";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}
/*
判断当前这个UIActivity是否需要显示。

上文也提到，如果是系统的服务，会自动根据硬件支持以及activityItems的类型去判断该显示哪些内容，如果是自定义，这些事情就要我们自己做了。
比如微信分享，要判断是否安装了微信。还有就是判断activityItems里的参数是否支持
*/

- (void)prepareWithActivityItems:(NSArray *)activityItems{
    
    [self Web:_web ContentCaptureCompletionHandler:^(UIImage *image) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                XYWKLog(@"success = %d, error = %@", success, error);
                [self->_web.viewController.view  makeToast:@"保存成功，请到相册中查看"];
            });
        }];
    }];
}
//点击动作即将执行的准备阶段，可以用来处理一下值或者逻辑。


- (void)performActivity{
    
}
//点击UIActivity的动作消息，处理点击后的相应逻辑


- (void)activityDidFinish:(BOOL)completed{
    
}
//完成处理


//==================截图=================
//
- (void)Web:(WKWebView *)web ContentCaptureCompletionHandler:(void(^)(UIImage *image))completionHandler{
    CGPoint offset = web.scrollView.contentOffset;
    CGRect originFrame = web.frame;
    CGSize s = web.scrollView.contentSize;
    s.height = s.height + 100;

    web.frame = CGRectMake(0, web.top, s.width, s.height);
    [UIView animateWithDuration:.4 * s.height/originFrame.size.height delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        web.top = web.top - (s.height - originFrame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(s.width, s.height-100), YES, UIScreen.mainScreen.scale);
            [web.scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            completionHandler(image);
            
            web.frame = originFrame;
            web.scrollView.contentOffset = offset;
        }
    }];


}

@end
