//
//  TBCreateNewActivity.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/20.
//

#import "TBCreateNewActivity.h"
#import <WebKit/WebKit.h>

@implementation TBCreateNewActivity

+(UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (UIActivityType)activityType {
    return @"createNew";
}

- (NSString *)activityTitle {
    return @"新建窗口";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

@end
