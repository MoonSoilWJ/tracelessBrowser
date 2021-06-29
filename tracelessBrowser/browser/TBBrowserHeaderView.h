//
//  TBBrowserHeaderView.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BrowserHeadBtnProtocol <NSObject>

- (void)backBtnTapped;

- (void)windowBtnTapped;

- (void)homeBtnTapped;

- (void)menuRefreshAction;

- (void)menuBtnTapped;

- (void)searchTapped:(NSString *)urlStr;

@end

@interface TBBrowserHeaderView : UIView
@property (nonatomic, retain) UIButton *menuBtn;

@property (nonatomic, retain) UILabel *titleLab;

@property (nonatomic, weak) id<BrowserHeadBtnProtocol> delegate;

- (void)deviceOrientionChanged:(UIDeviceOrientation)deviceOriention;

@end

NS_ASSUME_NONNULL_END
