//
//  NSDictionary+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface NSDictionary (ShortCut)


/**
 *  返回一个新的数组,包含字典的 键排序 ,如果键是NSString,会升序排序
 *
 *  @return 如果为空数组,可能是字典禁止访问.
 */
- (NSArray *)allKeysSorted;


/**
 *  返回一个新的数组,其中包含字典的 键值进行排序 。数组中的值的顺序是由键定义的。钥匙是NSString,他们将升序排序
 *
 *  @return 返回一个新的数组
 */
- (NSArray *)allValuesSortedByKeys;


/**
 *   判断键是否存在字典里
 *
 *  @param key 要查找的key
 *
 *  @return yes 或者 no
 */
- (BOOL)containsObjectForKey:(id)key;



/**
 *   返回一个和被给的键有关的CGPoint
 *
 *  @param key 关联的键
 *
 *  @return 如果返回nil,是没有与这个键有关的值.
 */
- (CGPoint)pointForKey:(NSString *)key;


/**
 *   返回一个和被给的键有关的CGSize
 *
 *  @param key 关联的key
 *
 *  @return 如果返回nil,是没有与这个键有关的值.
 */
- (CGSize)sizeForKey:(NSString *)key;


/**
 *   返回一个和被给的键有关的CGRect
 *
 *  @param key 关联的key
 *
 *  @return 如果返回nil,是没有与这个键有关的值.
 */
- (CGRect)rectForKey:(NSString *)key;
@end




@interface NSMutableDictionary (ShortCut)

/**
 *   给字典添加一个键值对,值必须是CGPoint
 *
 *  @param value 这里的CGPoint结构会被复制为object.
 *  @param key   与value关联的key
 */
- (void)setPoint:(CGPoint)value forKey:(NSString *)key;


/**
 *   给字典添加一个键值对,值必须是CGSize
 *
 *  @param value 这里的CGPoint结构会被复制为object.
 *  @param key   与value关联的key
 */
- (void)setSize:(CGSize)value forKey:(NSString *)key;


/**
 *   给字典添加一个键值对,值必须是CGRext
 *
 *  @param value 这里的CGPoint结构会被复制为object.
 *  @param key   与value关联的key
 */
- (void)setRect:(CGRect)value forKey:(NSString *)key;
@end




