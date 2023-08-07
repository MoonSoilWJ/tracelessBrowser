//
//  TBNoDataView.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBNoDataView : UIView

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *confirmButton;

- (void)setNodatImage:(UIImage *)image;

- (void)setImgViewTopSpace:(CGFloat )topSpace;

- (void)deviceOrientionChanged;

@end

NS_ASSUME_NONNULL_END
