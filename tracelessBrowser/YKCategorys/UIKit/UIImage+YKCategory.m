//
//  UIImage+Category.m
//  Tairong
//
//  Created by yuekewei on 2019/7/8.
//

#import "UIImage+YKCategory.h"

@implementation UIImage (YKCategory)

/**
 改变图片的缩放倍率
 
 @param targetWidth 目标Width
 @param filePah 图片路径
 @return 改变缩放倍率的图片
 */
+ (UIImage *)imageChangeScaleForTargetWidth:(CGFloat)targetWidth filePath:(NSString *)filePah {
    UIImage *image = [UIImage imageWithContentsOfFile:filePah];
    UIImage *newImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePah] scale:image.size.width * image.scale / targetWidth];
    return newImage;
}

/**
 渐变色UIImage实例
 
 @param colors colors
 @param rect rect
 @param isVertical 是否垂直渐变
 @return 渐变色UIImage实例
 */
+ (UIImage *)imageForGradientWithColors:(NSArray <UIColor *>*)colors andRect:(CGRect)rect orientationIsVertical:(BOOL)isVertical{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    start = CGPointMake(0.0, 0.0);
    if (isVertical) {
        end = CGPointMake( 0.0 , rect.size.height);
    }
    else {
        end = CGPointMake(rect.size.width, 0.0);
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return image;
}


/**
 获取指定颜色图片
 
 @param color color
 @return 指定颜色UIImage实例
 */
+ (UIImage *)imageForColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ellipseImageWithRect:(CGRect)rect color:(UIColor *)color {
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.height));
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(gc, [color CGColor]);
    CGContextAddEllipseInRect(gc, rect);
    CGContextDrawPath(gc, kCGPathFill);
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImg;
}

/**
 *  获取图片主色调
 *
 *  @param image image
 *
 *  @return UIColor
 */
+ (UIColor*)imageMostColor:(UIImage *)image{
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        CGContextRelease(context);
        return [UIColor new];
    }
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
            
        }
    }
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

/**
 获取app启动图
 
 @return app启动图
 */
+ (UIImage *)appLaunchImage {
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    NSString *launchImagePath = @"";
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    UIWindow *currentWindow = [[UIApplication sharedApplication].windows firstObject];
    CGSize viewSize = currentWindow.bounds.size;
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImagePath = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageWithContentsOfFile:launchImagePath];
}
@end
