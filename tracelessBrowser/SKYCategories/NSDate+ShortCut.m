//
//  NSDate+ShortCut.m
//  ShourCut
//
//  Created by mac  on 14-1-14.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "NSDate+ShortCut.h"

@implementation NSDate (ShortCut)

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)week
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekdayOrdinal
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)quarter
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(BOOL)isLeapYear
{
    NSInteger year = [self year];
    return ((year%4 == 0 && year%100 != 0) || year%400 == 0);
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(id)shortDateWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:components];
    return date;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)shortCutStringWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSString * str = nil;
    if (!dateFormatter)
    {
        NSDateFormatter * dateFormatterDefault = [[NSDateFormatter alloc]init];
        [dateFormatterDefault setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        str = [dateFormatterDefault stringFromDate:self];
        str = [dateFormatter stringFromDate:self];
    }
    return str;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSString *)shortCutStringWithStrFormatter:(NSString *)strFormatter
{
    NSString * str = nil;
    if (!strFormatter)
    {
        strFormatter =@"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter * dateFormatterDefault = [[NSDateFormatter alloc]init];
    [dateFormatterDefault setDateFormat:strFormatter];
    str = [dateFormatterDefault stringFromDate:self];
    return str;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSString *)shortCutStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSDate *)shortCutDateWithString:(NSString *)dateStr dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSDate * date = nil;
    if (!dateStr || !dateStr.length)
    {
        return nil;
    }
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    date = [dateFormatter dateFromString:dateStr];
    return date;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSDate *)shortCutDateWithString:(NSString *)dateStr strFormatter:(NSString *)strFormatter
{
    NSDate * date = nil;
    if (!dateStr || !dateStr.length)
    {
        return nil;
    }
    
    if (!strFormatter.length ||!strFormatter)
    {
        strFormatter = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:strFormatter];
    date = [[self class] shortCutDateWithString:dateStr dateFormatter:dateFormatter];
    return date;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSDate *)shortCutDateWithSince1970TimeMS:(long long)timeMSForSince1970
{
   return [NSDate dateWithTimeIntervalSince1970:timeMSForSince1970/1000];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateAfterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterMonth;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateBeginningOfMonth
{
    return [self shortDateAfterDay:-(int)[self year] + 1];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateEndOfMonth
{
        return [[[self shortDateBeginningOfMonth] shortDateAfterMonth:1] shortDateAfterDay:-1];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateEndOfWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return endOfWeek;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(int)shortIndexWeekOfYear
{
    int i;
    NSUInteger year = [self year];
    NSDate * date = [self shortDateEndOfWeek];
    for (i = 1;[[date shortDateAfterDay:-7 * i] year] == year;i++)
    {
        
    }
    return i;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSUInteger)shortDaysAgoFromDate:(NSDate *)aDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:self
                                                 toDate:aDate
                                                options:0];
    return [components day];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSUInteger)shortCountForWeekOfMonth
{
    return [[self shortDateEndOfMonth] shortIndexWeekOfYear] - [[self shortDateBeginningOfMonth] shortIndexWeekOfYear] + 1;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSUInteger)shortCountForDayOfMonth
{
    NSInteger nthMonth = [self month];
    NSInteger days[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if ([self isLeapYear])
    {
        return nthMonth == 2 ? 29 : 28;
    }
    return days[nthMonth - 1];
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSUInteger)shortCountForDayOfMonth:(NSInteger)month OfYear:(NSInteger)year
{
    NSDate * date = [self shortDateWithYear:year Month:month Day:0 Hour:0 Minute:0 Second:0];
    return [date shortCountForDayOfMonth];;
}
@end
