//
//  AppDelegate.m
//  Tsy
//
//  Created by LV-Mac on 16/7/6.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import "AppDelegate.h"

#import "libpolyvSDK/PolyvUtil.h"
#import "libpolyvSDK/PolyvSettings.h"

#import "TsyNavigationViewController.h"
#import "TsyIndexViewController.h"
#import "TsyVideoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 加载cookie
    [self loadHTTPCookies];
    
    // 配置sdk加密串
    NSString *appKey = @"6gts3ABVSq73xSUB/McKCHmR41UDP0A0wKrJYZwJtwFc4eaj9l1jTEMBCW/fT2NKIt76f4BuQoE2u/1ghNp0zML+ejWRjmbOADkTTFyXtKa9HUV6fPRYwHwGMKIfchD6dD8y+RKSC9kPrcPntiLQxA==";
    NSData *data = [appKey dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *config =[PolyvUtil decryptUserConfig:data];
    // 设置下载目录
    [[PolyvSettings sharedInstance] setDownloadDir:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/plvideo/a"]];
    [[PolyvSettings sharedInstance] initVideoSettings:[config objectAtIndex:1] Readtoken:[config objectAtIndex:2] Writetoken:[config objectAtIndex:3] UserId:[config objectAtIndex:0]];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 显示首页
    TsyIndexViewController *indexView = [[TsyIndexViewController alloc] init];
    
    TsyNavigationViewController *rootNav = [[TsyNavigationViewController alloc] initWithRootViewController:indexView];
    
    // 设置根页面
    self.window.rootViewController = rootNav;
    
    // 显示window
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveHTTPCookies];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self loadHTTPCookies];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //重载设置
    [[PolyvSettings sharedInstance]  reloadSettings];
    
    // 显示首页
    //TsyIndexViewController *indexView = [[TsyIndexViewController alloc] init];
    
    //TsyNavigationViewController *rootNav = [[TsyNavigationViewController alloc] initWithRootViewController:indexView];
    
    // 设置根页面
    //self.window.rootViewController = rootNav;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveHTTPCookies];
}

-(void)loadHTTPCookies {
    NSMutableArray* cookieDictionary = [[NSUserDefaults standardUserDefaults] valueForKey:@"cookieArray"];
    
    for (int i=0; i < cookieDictionary.count; i++)
    {
        NSMutableDictionary* cookieDictionary1 = [[NSUserDefaults standardUserDefaults] valueForKey:[cookieDictionary objectAtIndex:i]];
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDictionary1];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}

-(void)saveHTTPCookies {
    NSMutableArray *cookieArray = [[NSMutableArray alloc] init];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookieArray addObject:cookie.name];
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:cookie.name forKey:NSHTTPCookieName];
        [cookieProperties setObject:cookie.value forKey:NSHTTPCookieValue];
        [cookieProperties setObject:cookie.domain forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:cookie.path forKey:NSHTTPCookiePath];
        [cookieProperties setObject:[NSNumber numberWithUnsignedInteger:cookie.version] forKey:NSHTTPCookieVersion];
        [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
        
        [[NSUserDefaults standardUserDefaults] setValue:cookieProperties forKey:cookie.name];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:cookieArray forKey:@"cookieArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 如果当前用户在登录状态，退出时要保存一个值1，如果未登录，则保存0
    NSString *userUid = [[NSUserDefaults standardUserDefaults] valueForKey:@"Cookie-Uid"];
    
    if (nil != userUid && userUid.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"IsOut"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"IsOut"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
