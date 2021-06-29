//
//  WindowModel.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/30.
//

#import "WindowModel.h"

@implementation WindowModel
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.uuid = [NSUUID UUID].UUIDString;
    }
    return self;
}
//property (nonatomic, retain, nullable) WKWebView *webView;
//@property (nonatomic, retain, nullable) NSURL *url;
//@property (nonatomic, retain) UIImage *imageSnap;
//
/////是否是首页
//@property (nonatomic, assign) BOOL isHome;
/////首页搜索框内容
//@property (nonatomic, retain, nullable) NSString *homeSearchString;
//
///// 窗口VC中 所在cell的偏移量
//@property (nonatomic, assign) CGPoint windowOffSet;

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.imageSnap forKey:@"imageSnap"];
    [coder encodeBool:self.isHome forKey:@"isHome"];
    [coder encodeObject:self.homeSearchString forKey:@"homeSearchString"];
    [coder encodeCGPoint:self.windowOffSet forKey:@"windowOffSet"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        
        self.url = [coder decodeObjectForKey:@"url"];
        self.imageSnap = [coder decodeObjectForKey:@"imageSnap"];
        self.isHome = [coder decodeBoolForKey:@"isHome"];
        self.homeSearchString = [coder decodeObjectForKey:@"homeSearchString"];
        self.windowOffSet = [coder decodeCGPointForKey:@"windowOffSet"];
    }
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}
@end
