//
//  TBCreateNewActivity.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/20.
//

#import "TBHistoryActivity.h"
#import <WebKit/WebKit.h>

@implementation TBHistoryActivity

+(UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (UIActivityType)activityType {
    return @"history";
}

- (NSString *)activityTitle {
    return @"浏览记录";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

@end
