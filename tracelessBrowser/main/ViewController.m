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

@interface ViewController ()<iCarouselDelegate,iCarouselDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIButton *_settingBtn;
    
    UIImageView *_headImageView;
    UIImageView *_bottomImageView;
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
    [self.goButton setImage:[UIImage imageNamed:@"sou_btn"] forState:UIControlStateNormal];
    [self.goButton setImage:[UIImage imageNamed:@"sou_btn"] forState:UIControlStateHighlighted];
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
    [_settingBtn addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_settingBtn];
    
    // 自定义图片
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), beginFrame().origin.y)];
    _headImageView.backgroundColor = UIColor.redColor;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.backgroundView insertSubview:_headImageView atIndex:1];
    
    _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight()-beginFrame().origin.y)];
    _bottomImageView.backgroundColor = UIColor.yellowColor;
    _bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_pop.whiteView insertSubview:_bottomImageView atIndex:1];
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
//    if (self.pop.isShowing) {
//        return;
//    }
//    [self.pop addSubview:self.pop.whiteView];
//    __weak typeof(self) ws = self;
//    [self.pop showFrom:self.backgroundView animations:^{
//        __strong typeof(ws) strong = ws;
//        strong.textView.top = 50;
//        [strong.textView becomeFirstResponder];
//    } completion:^{
//
//    }];
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
    TBBrowserViewController *searchVC = [TBBrowserViewController new];
    searchVC.url = urlStr;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)endEdit{
    [self.view endEditing:YES];
}

- (void)chooseImage {
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pick.delegate = self;
    pick.allowsEditing = YES;
    [self.navigationController presentViewController:pick animated:YES completion:nil];
}

#pragma mark - image Pciker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _headImageView.image = image;
    _bottomImageView.image = image;
    
//    NSString * path =NSHomeDirectory();
//    
//    NSString * Pathimg =[path stringByAppendingString:@"/Documents/111.png"];
//
//    [UIImagePNGRepresentation(imgsave) writeToFile:Pathimg atomically:YES];
//
//    NSLog(@"%@",path);//这是沙盒路径
//
//
//    NSString * PATH =[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),@"text"];
//
//    image.image=[[UIImage alloc]initWithContentsOfFile:PATH];

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
        [whiteView bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:10 borderWidth:4 borderColor:THEME_COLOR];
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

//MARK: - deviceOrientionChangedProtocol
- (void)deviceOrientionChanged:(UIDeviceOrientation)deviceOrientation {
    self.backgroundView.frame  = self.view.bounds;
    self.myCarousel.frame = CGRectMake(0, STATUS_BAR_HEIGHT + 20, ScreenWidth(), 80);
    self.goButton.frame = CGRectMake(ScreenWidth()/2 - 25, ScreenHeight() - TAB_BAR_HEIGHT - self.view.height/7, 60, 60);
    self.layer.frame = self.goButton.frame;
    self.pop.frame = UIScreen.mainScreen.bounds;
    [self.pop deviceOrientionChanged:deviceOrientation];
    
    self.textView.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, self.view.height/3);
}

@end
