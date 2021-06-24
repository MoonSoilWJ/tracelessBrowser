//
//  WindowListAddNewCell.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/6/24.
//

#import "WindowListAddNewCell.h"
#import "UIImage+RTTint.h"

@implementation WindowListAddNewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-25, frame.size.height/2-25, 50, 50)];
        UIImage *windowAdd = [UIImage imageNamed:@"window_add"];
        windowAdd = [windowAdd rt_tintedImageWithColor:THEME_COLOR];
        imageView.image = windowAdd;
        [self.contentView addSubview:imageView];
        
        [self.contentView bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:5 borderWidth:.5 borderColor:THEME_COLOR];
    }
    return self;
}
@end
