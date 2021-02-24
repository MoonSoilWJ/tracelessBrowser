//
//  NSDate+ShortCut.h
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ShortCut)
@property (nonatomic,readonly) NSInteger year;//年
@property (nonatomic,readonly) NSInteger month;//月
@property (nonatomic,readonly) NSInteger day;//日
@property (nonatomic,readonly) NSInteger hour;//时
@property (nonatomic,readonly) NSInteger minute;//分
@property (nonatomic,readonly) NSInteger second;//秒
@property (nonatomic,readonly) NSInteger week;//周
@property (nonatomic,readonly) NSInteger weekday;//工作日
@property (nonatomic,readonly) NSInteger weekdayOrdinal;//工作日序数
@property (nonatomic,readonly) NSInteger weekOfMonth;//月的周数
@property (nonatomic,readonly) NSInteger weekOfYear;//年的周数
@property (nonatomic,readonly) NSInteger yearForWeekOfYear;
@property (nonatomic,readonly) NSInteger quarter;//季度
@property(nonatomic,assign,readonly)BOOL isLeapYear;//是否是润年



/*!
 *  生成日期
 */
+(id)shortDateWithYear:(NSInteger)year
             Month:(NSInteger)month
               Day:(NSInteger)day
              Hour:(NSInteger)hour
            Minute:(NSInteger)minute
            Second:(NSInteger)second;



/**
 *  根据dateFormatter得到时间字符串
 *
 *  @param dateFormatter dateFormatter
 *
 *  @return
 */
- (NSString *)shortCutStringWithDateFormatter:(NSDateFormatter *)dateFormatter;


/**
 *  根据strFormatter得到时间字符串
 *
 *  @param strFormatter strFormatter
 *
 *  @return
 */
- (NSString *)shortCutStringWithStrFormatter:(NSString *)strFormatter;



/**
 *  根据日期和时间格式,返回时间字符串
 *
 *  @param dateStyle dateStyle
 *  @param timeStyle timeStyle
 *
 *  @return
 */
- (NSString *)shortCutStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;


/**
 *  生成时间
 *
 *  @param dateStr       dateStr
 *  @param dateFormatter dateFormatter
 *
 *  @return
 */
+ (NSDate *)shortCutDateWithString:(NSString *)dateStr dateFormatter:(NSDateFormatter *)dateFormatter;


/**
 *  生成时间
 *
 *  @param dateStr      dateStr
 *  @param strFormatter strFormatter
 *
 *  @return
 */
+ (NSDate *)shortCutDateWithString:(NSString *)dateStr strFormatter:(NSString *)strFormatter;



/**
 *  根据毫秒级时间戳得到时间
 *
 *  @param timeMSForSince1970 timeMSForSince1970
 *
 *  @return
 */
+ (NSDate *)shortCutDateWithSince1970TimeMS:(long long int)timeMSForSince1970;




/**
 *  month个月后的日期
 *
 *  @param month
 *
 *  @return 
 */
- (NSDate *)shortDateAfterMonth:(int)month;


/**
 *  返回day天后的日期(若day为负数,则为|day|天前的日期)
 *
 *  @param day
 *
 *  @return
 */
- (NSDate *)shortDateAfterDay:(int)day;



/**
 *  返回该月的开始第一天
 *
 *  @return
 */
- (NSDate *)shortDateBeginningOfMonth;


/**
 *  该月的最后一天
 *
 *  @return
 */
- (NSDate *)shortDateEndOfMonth;




/**
 *  返回当前周的周末
 *
 *  @return
 */
- (NSDate *)shortDateEndOfWeek;





/**
 *  该日期是该年的第几周
 *
 *  @return
 */
- (int)shortIndexWeekOfYear;



/**
 *  与某个日期相差几天
 *
 *  @param aDate
 *
 *  @return
 */
- (NSUInteger)shortDaysAgoFromDate:(NSDate *)aDate;



/**
 *  返回当前月一共有几周(可能为4,5,6)
 *
 *  @return
 */
- (NSUInteger)shortCountForWeekOfMonth;




/**
 *  当月总共多少天(可能为28,29,30,31)
 *
 *  @return
 */
-(NSUInteger)shortCountForDayOfMonth;




/**
 *  某年某月有多少天(可能为28,29,30,31)
 *
 *  @param month 月
 *  @param year  年
 *
 *  @return
 */
+(NSUInteger)shortCountForDayOfMonth:(NSInteger)month OfYear:(NSInteger)year;
@end
