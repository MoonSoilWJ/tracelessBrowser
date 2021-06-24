//
//  WindowListCollectionCell.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WindowModel;
@interface WindowListCollectionCell : UICollectionViewCell
@property (nonatomic, retain) WindowModel *model;

@property (nonatomic, copy) void(^deleteBlock)(void);

@end

NS_ASSUME_NONNULL_END
