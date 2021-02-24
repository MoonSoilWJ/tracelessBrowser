//
//  TBTextView.h
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBTextView : UITextView

@property (nonatomic, copy) void(^searchTappedBlock)(NSString *);
@property (nonatomic, copy) void(^searchUrlLinkTappedBlock)(NSURL *);

@property (nonatomic, copy) NSString *placeholderStr;

- (NSRange)rangeOfUrlInText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
