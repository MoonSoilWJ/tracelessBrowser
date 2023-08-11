//
//  BaseViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/3.
//

#import "BaseViewController.h"
#import "TBEnginsManager.h"
#import "UIViewController+DeviceOriention.h"

@interface BaseViewController ()
@property (nonatomic, retain) UIImageView *imageView;
//@property (nonatomic, retain) UIVisualEffectView *blurEffectView1;
@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    if (self.navigationController.viewControllers.count > 1){
        UIBarButtonItem *leftBarButtonItem  =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction:)];
        leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"#1A1A1A"];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    
//    [self addChangeSkinToView:self.view];
}

- (void)leftBarAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)addChangeSkinToView:(UIView *)view{
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight())];
//    _imageView.hidden = YES;
//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
//    _imageView.clipsToBounds = YES;
//    [view addSubview:_imageView];
//
////    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
////    _blurEffectView1 = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
////    _blurEffectView1.frame = _imageView.bounds;
////    _blurEffectView1.alpha = .95;
////    [_imageView addSubview:_blurEffectView1];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSkin:) name:@"changeSkin" object:nil];
//}
//
//- (void)initSkin{
//
//    NSDictionary *changeSkinDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"changeSkin"];
//    NSDictionary *info_close = changeSkinDic[@"type_close"];
//    [self resetSkin:info_close];
//    NSDictionary *info_blur = changeSkinDic[@"type_blur"];
//    [self resetSkin:info_blur];
//    NSDictionary *info_image = changeSkinDic[@"type_image"];
//    [self resetSkin:info_image];
//}
//
//- (void)changeSkin:(NSNotification *)noti {
//    NSDictionary *info = noti.userInfo;
//    [self resetSkin:info];
//}
//
//- (void)resetSkin:(NSDictionary *)info {
//    if (!info) {
//        return;
//    }
//
//    NSInteger type = [info[@"type"] integerValue];
//    if (type == 0) { //关闭
//        bool close = [info[@"close"] boolValue];
//        if (close) {
//            self.imageView.hidden = YES;
//        }else {
//            self.imageView.alpha = 0;
//            self.imageView.hidden = NO;
//            [UIView animateWithDuration:.5 animations:^{
//                self.imageView.alpha = 1;
//            }];
//        }
//    }else if (type == 1) { // blur
//        bool close = [info[@"close"] boolValue];
//        if (close) {
////            self.blurEffectView1.hidden = YES;
//        }else {
////            self.blurEffectView1.hidden = NO;
//        }
//    }else if (type == 2) {
//        UIImage *img = [TBEnginsManager getImageWithFileName:@"changeSkin"];
//        self.imageView.image = img;
//    }
//
//    if ([self conformsToProtocol:@protocol(SkinDidChangedProtocol)]) {
//        if ([self respondsToSelector:@selector(skinDidChanged:)]) {
//            [self skinDidChanged:info];
//        }
//    }
//}
//
//- (void)changeSkinDealloc {
//    [self changeSkinDealloc];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//-(void)deviceOrientionChanged:(UIDeviceOrientation)deviceOrientation {
//    self.imageView.frame = CGRectMake(0, 0, ScreenWidth(), ScreenHeight());
////    _blurEffectView1.frame = _imageView.bounds;
//}

@end
