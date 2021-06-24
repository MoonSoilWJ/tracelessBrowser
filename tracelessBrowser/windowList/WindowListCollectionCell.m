//
//  WindowListCollectionCell.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/4/1.
//

#import "WindowListCollectionCell.h"
#import "UIImage+RTTint.h"

@interface WindowListCollectionCell()
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation WindowListCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        [self.contentView bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:5 borderWidth:.5 borderColor:THEME_COLOR];

        
        UIImage *windowDel = [UIImage imageNamed:@"window_cross"];
        windowDel = [windowDel rt_tintedImageWithColor:THEME_COLOR];
        UIButton *windowDelBtn = [UIButton btnWithBgImg:windowDel];
        windowDelBtn.frame = CGRectMake(frame.size.width - 20 - 30, 5, 25, 25);
        [windowDelBtn addTarget:self action:@selector(windowDelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:windowDelBtn];
    }
    return self;
}

- (void)setModel:(WindowModel *)model {
    self.imageView.image = model.imageSnap;
}

- (void)windowDelAction {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}
@end
