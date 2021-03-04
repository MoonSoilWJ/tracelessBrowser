//
//  TBEnginsManager.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/2/3.
//

#import "TBEnginsManager.h"


NSString *kCurrentEnginUrlKey = @"engineUrl";

@implementation TBEnginsManager

+ (NSString *)currentEngineUrl {
   NSString *currentEngineUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentEnginUrlKey];
    if (!currentEngineUrl) {
        currentEngineUrl = [self enginesArr][2][@"url"];
    }
    return currentEngineUrl;
}

+ (void)saveCurrentEngineUrl:(NSString *)currentEngineUrlStr {
    [[NSUserDefaults standardUserDefaults] setObject:currentEngineUrlStr forKey:kCurrentEnginUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)currentEngineIndex {
    NSInteger index = 2;
    for (NSDictionary *dic in self.enginesArr) {
        if ([dic[@"url"] isEqualToString:self.currentEngineUrl]) {
            index = [self.enginesArr indexOfObject:dic];
        }
    }
    return index;
}

+ (UIImage *)iconImageforIndex:(NSInteger)index {
    return [UIImage imageNamed:[self enginesArr][index][@"image"]];
}

+ (NSArray *)enginesArr {
    NSArray *enginesArr = @[
        @{@"image" : @"bing_icon", @"url" : @"https://cn.bing.com/search?q="},
        @{@"image" : @"360_icon", @"url" : @"https://www.so.com/s?q="},
        @{@"image" : @"baidu_icon", @"url" : @"https://www.baidu.com/s?wd="},
        @{@"image" : @"sougou_icon", @"url" : @"https://www.sogou.com/web?query="},
        @{@"image" : @"google_icon", @"url" : @"https://www.google.com/search?q="},
        @{@"image" : @"youdao_icon", @"url" : @"http://www.youdao.com/w/eng/"},
    ];
    return enginesArr;
}


//MARK: =========首页照片=======
/**
*parm fileName
*image 图片文件
*将图片命名为XXX保存包项目沙盒类
*/

+ (BOOL)saveImage:(NSData*)imageData ToDocmentWithFileName:(NSString*)fileName{
    //2.保存到对应的沙盒目录中，具体代码如下：
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];   // 保存文件的名称
    BOOL result = [imageData writeToFile: filePath atomically:YES]; // 保存成功会返回YES
    if (result) {
        return YES;
    }else{
        return NO;
    }
}

+(UIImage *)getImageWithFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    UIImage *result = [UIImage imageWithContentsOfFile:filePath];
    return result;
}

@end
