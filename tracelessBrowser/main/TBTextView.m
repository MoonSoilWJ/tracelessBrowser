//
//  TBTextView.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/18.
//

#import "TBTextView.h"

@interface TBTextView()<UITextViewDelegate>{
}
@end
@implementation TBTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.font = [UIFont systemFontOfSize:20];
        self.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 20);
        self.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
        self.placeholderStr = NSLocalizedString(@"请输入要搜索的内容或网址", @"");
        self.editable = YES;
        self.returnKeyType = UIReturnKeySearch;
        self.delegate = self;
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setPlaceholderStr:(NSString *)placeholderStr {
    _placeholderStr = placeholderStr;
    
    self.placeholder  = placeholderStr;
    self.placeholderColor = UIColor.systemGrayColor;
}

// MARK: delegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if (self.searchUrlLinkTappedBlock) {
        self.searchUrlLinkTappedBlock(URL);
    }
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        // 去搜索
        NSRange urlRange = [self rangeOfUrlInText:textView.text];
        if (urlRange.location<=0 && urlRange.length > 0) {
            if (self.searchUrlLinkTappedBlock) {
                self.searchUrlLinkTappedBlock([NSURL URLWithString:[textView.text substringWithRange:urlRange]]);
            }
        }else {
            if (self.searchTappedBlock) {
                self.searchTappedBlock(textView.text);
            }
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    UITextPosition *position = [textView positionFromPosition:[textView markedTextRange].start offset:0];
    if (!position) { //没有预输入的时候再做正则匹配
        NSRange range = textView.selectedRange;
        NSRange urlRange = [self rangeOfUrlInText:textView.text];
        NSString *urlStr = @"";
        
        bool has = NO;
        if (urlRange.location < textView.text.length && urlRange.length > 0) {
            urlStr = [textView.text substringWithRange:urlRange];
            NSURL *url = [NSURL URLWithString:urlStr];
            if (url) {
                NSDictionary *linkDic = @{ NSLinkAttributeName : url};
                NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc] initWithString:textView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
                
                [mutAtt addAttributes:linkDic range:urlRange];
                textView.attributedText = mutAtt;
                textView.selectedRange = range;
                
                has = YES;
            }
        }
        
        if (!has) {
            NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc] initWithString:textView.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:25]}];
            textView.attributedText = mutAtt;
        }
        
        textView.selectedRange = range;
    }
}

- (NSRange)rangeOfUrlInText:(NSString *)text {
    return [text rangeOfString:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|([a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:NSRegularExpressionSearch];
}


@end
