//
//  TBAboutUsViewController.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBAboutUsViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UILabel *versionLab;

@end

NS_ASSUME_NONNULL_END
