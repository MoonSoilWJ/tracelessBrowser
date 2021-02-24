//
//  NSArray+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (ShortCut)


/**
 *  返回数组中第一个object
 *
 *  @return 如果数组是空数组,返回nil.
 */
- (id)firstObject;


/**
 *  随机输出一个数组中的object
 *
 *  @return 如果数组是空数组,返回nil.
 */
- (id)randomObject;



/**
 *  判断该object是否在数组中,nil为找不到,和objectAtIndex相似,但是不会抛出异常
 *
 *  @param index
 *
 *  @return id
 */
- (id)objectOrNilAtIndex:(NSUInteger)index;


@end


@interface NSMutableArray (ShortCut)

/**
 *   在数组的最后插入获得的object,如果object是空,直接返回不会抛出异常
 *
 *  @param anObject 如果object是空,直接返回不会抛出异常
 */
- (void)addObjectOrNil:(id)anObject;



/**
 *   移除第一个object
 */
- (void)removeFirstObject;


/**
 *  将数组倒序   Before @[@1,@2,@3 ] After @[ @3, @2, @1 ]
 */
- (void)reverse;


/**
 *   将对象随机排序
 */
- (void)shuffle;
@end