//
//  TBNoDataView.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/24.
//

#import "TBNoDataView.h"
#import "UIImage+RTTint.h"

@interface TBNoDataView ()
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UIButton *closeBtn;

@end
@implementation TBNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = UIColor.whiteColor;
    
    _image = [UIImage imageNamed:@"noContent"];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height/6, _image.size.width, _image.size.height)];
    [self addSubview:_imgView];
    _imgView.centerX = self.centerX;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imgView.bottom + 25, self.width, 23)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = UIColor.darkTextColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom + 40, 140, 40)];
    [_confirmButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [_confirmButton setBackgroundImage:[UIImage imageForColor:THEME_COLOR] forState:UIControlStateNormal];
    [_confirmButton bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:20];
    [self addSubview:_confirmButton];
    _confirmButton.centerX = self.centerX;
    
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 45, 15, 30, 30)];
    _closeBtn.backgroundColor = rgba(240, 240, 240, 1);
    [_closeBtn bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:15];
    UIImage *image = [UIImage imageNamed:@"circleCloseButton"];
    [_closeBtn setImage:image forState:UIControlStateNormal];
    [self addSubview:_closeBtn];
    [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNodatImage:(UIImage *)image {
    _image = image;
    _imgView.image = [image rt_tintedImageWithColor:THEME_COLOR];
    _imgView.frame = CGRectMake(0, self.height/6, _image.size.width, _image.size.height);
    _imgView.centerX = self.centerX;
}

- (void)setImgViewTopSpace:(CGFloat)topSpace {
    _imgView.top = topSpace;
}

- (void)close {
    self.hidden = YES;
}

- (void)deviceOrientionChanged:(UIDeviceOrientation)deviceOriention {
    _imgView.frame = CGRectMake(0, self.height/6, _image.size.width, _image.size.height);
    _imgView.centerX = self.centerX;
    _titleLabel.frame = CGRectMake(0, _imgView.bottom + 25, self.width, 23);
    _confirmButton.frame = CGRectMake(0, _titleLabel.bottom + 40, 140, 40);
    _confirmButton.centerX = self.centerX;
    _closeBtn.frame = CGRectMake(self.bounds.size.width - 45, 15, 30, 30);
}

@end
