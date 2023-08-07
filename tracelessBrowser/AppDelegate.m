//
//  AppDelegate.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2020/12/17.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UMCommon/MobClick.h>
#import <UMCommon/UMCommon.h>
//#import <AppTrackingTransparency/AppTrackingTransparency.h>
//#import <AdSupport/AdSupport.h>
#ifdef FREE
#import <BUAdSDK/BUAdSDKManager.h>
#else
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)requestIDFA {
    if (@available(iOS 14, *)) {
//        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//            // Tracking authorization completed. Start loading ads here.
//            // [self loadAd];
//        }];
    } else {
        // Fallback on earlier versions
    }
}

-(void)configUSharePlatforms {
    //设置为自动采集页面
    [MobClick setAutoPageEnabled:YES];
    [UMConfigure initWithAppkey:@"64d0f19da1a164591b64d475" channel:@"App Store"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef FREE
    [BUAdSDKManager setAppID:@"5186009"];
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
//    [BUAdSDKManager setIsPaidApp:NO];
#else
#endif
    // 友盟
    [self configUSharePlatforms];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
