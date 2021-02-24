//
//  UIView+Category.h
//  Tairong
//
//  Created by yuekewei on 2019/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface UIView (YKCategory)





/**
 返回指定类型superview,没有返回nil
 @param classType superview class
 @return 指定类型superview
 */
- (nullable UIView *)yk_superviewOfClassType:(nullable Class)classType;

/**
 所在单元格，找不到单元格返回nil
 @return 所在单元格，找不到单元格返回nil
 */
- (nullable UITableViewCell *)tableViewCell;

/**
 所在单元格的索引,找不到返回nil
 @param cellClass cell Class
 @return 所在单元格的索引,找不到返回nil
 */
- (nullable NSIndexPath *)cellIndexPathOfCellClass:(nullable Class)cellClass;
@end

NS_ASSUME_NONNULL_END
