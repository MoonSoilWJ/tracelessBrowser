//
//  UIView+Category.m
//  Tairong
//
//  Created by yuekewei on 2019/7/8.
//

#import "UIView+YKCategory.h"


@implementation UIView (YKCategory)


/**
 返回指定类型superview,没有返回nil
 
 @param classType superview class
 @return 指定类型superview
 */
- (nullable UIView *)yk_superviewOfClassType:(nullable Class)classType{
    if (!classType) return nil;
    
    UIView *superview = self.superview;
    while (superview) {
        if ([superview isKindOfClass:classType]) {
            //If it's UIScrollView, then validating for special cases
            if ([superview isKindOfClass:[UIScrollView class]]) {
                NSString *classNameString = NSStringFromClass([superview class]);
                
                //  If it's not UITableViewWrapperView class, this is internal class which is actually manage in UITableview. The speciality of this class is that it's superview is UITableView.
                //  If it's not UITableViewCellScrollView class, this is internal class which is actually manage in UITableviewCell. The speciality of this class is that it's superview is UITableViewCell.
                //If it's not _UIQueuingScrollView class, actually we validate for _ prefix which usually used by Apple internal classes
                if (![superview.superview isKindOfClass:[UITableView class]] &&
                    ![superview.superview isKindOfClass:[UITableViewCell class]] &&
                    ![classNameString hasPrefix:@"_"]) {
                    return superview;
                }
            }
            else {
                return superview;
            }
        }
        superview = superview.superview;
    }
    
    return nil;
}

/**
 所在单元格，找不到单元格返回nil
 
 @return 所在单元格，找不到单元格返回nil
 */
- (nullable UITableViewCell *)tableViewCell {
    if ([self isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell *)self;
    }
    UIView *cell = [self yk_superviewOfClassType:[UITableViewCell class]];
    return [cell isKindOfClass:[UITableViewCell class]] ? (UITableViewCell *)cell : nil;
}


/**
 所在单元格，找不到单元格返回nil
 
 @return 所在单元格，找不到单元格返回nil
 */
- (nullable UICollectionViewCell *)collectionViewCell {
    if ([self isKindOfClass:[UICollectionViewCell class]]) {
        return (UICollectionViewCell *)self;
    }
    UIView *cell = [self yk_superviewOfClassType:[UICollectionViewCell class]];
    return [cell isKindOfClass:[UICollectionViewCell class]] ? (UICollectionViewCell *)cell : nil;
}

/**
 所在单元格的索引,找不到返回nil
 
 @param cellClass cell Class
 @return 所在单元格的索引,找不到返回nil
 */
- (nullable NSIndexPath *)cellIndexPathOfCellClass:(nullable Class)cellClass{
    NSIndexPath  *indexPath = nil;
    if (cellClass) {
        if ([NSStringFromClass(cellClass) isEqualToString:@"UICollectionViewCell"]) {
            UIView *cell = [self collectionViewCell];
            if (cell) {
                UIView *collectionView = [cell yk_superviewOfClassType:[UICollectionView class]];
                if (collectionView) {
                    indexPath =  [((UICollectionView *)collectionView) indexPathForItemAtPoint:cell.center];
                }
            }
            
        }
        else if ([NSStringFromClass(cellClass) isEqualToString:@"UITableViewCell"]) {
            UIView *cell = [self tableViewCell];
            if (cell) {
                UIView *tableView = [cell yk_superviewOfClassType:[UITableView class]];
                if (tableView) {
                    indexPath =  [((UITableView *)tableView) indexPathForRowAtPoint:cell.center];
                }
            }
        }
    }
    return indexPath;
}

@end
