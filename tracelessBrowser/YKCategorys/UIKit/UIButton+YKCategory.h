//
//  UIButton+YKCategory.h
//  xiaolancang
//
//  Created by yuekewei on 2019/12/17.
//  Copyright © 2019 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YKCategory)

/**
 验证码倒计时

 @param time 倒计时时间
 @param normalTitle normalTitle
 @param countDownTitle countDownTitle
 @param normalColor normalColor
 @param countDownColor countDownColor
 */
- (void)yk_startTimerWithTime:(NSInteger)time
          normalTitle:(NSString *)normalTitle
       countDownTitle:(NSString *)countDownTitle
          normalColor:(UIColor *)normalColor
       countDownColor:(UIColor *)countDownColor;
@end

NS_ASSUME_NONNULL_END
