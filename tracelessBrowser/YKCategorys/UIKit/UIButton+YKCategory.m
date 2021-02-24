//
//  UIButton+YKCategory.m
//  xiaolancang
//
//  Created by yuekewei on 2019/12/17.
//  Copyright © 2019 yeqiang. All rights reserved.
//

#import "UIButton+YKCategory.h"

@implementation UIButton (YKCategory)

- (void)yk_startTimerWithTime:(NSInteger)time
                normalTitle:(NSString *)normalTitle
       countDownTitle:(NSString *)countDownTitle
            normalColor:(UIColor *)normalColor
           countDownColor:(UIColor *)countDownColor {
//    //    开启后台短暂任务
//    __block    UIBackgroundTaskIdentifier bgTask;
//    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    });

    __block NSInteger timeOut = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0* NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:normalTitle forState:UIControlStateNormal];
                [self setTitleColor:normalColor forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%.2lds %@",(long)timeOut,countDownTitle] forState:UIControlStateNormal];
                [self setTitleColor:countDownColor forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
@end
