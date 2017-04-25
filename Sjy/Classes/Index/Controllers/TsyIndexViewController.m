//
//  TsyIndexViewController.m
//  Tsy
//
//  Created by LV-Mac on 16/7/6.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import "TsyIndexViewController.h"

//
#import "TsyVideoViewController.h"

#import "UIColor+Hex.h"

#import "MJRefresh.h"

@interface TsyIndexViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation TsyIndexViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    
    [super viewWillAppear:animated];
    
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNotificationCenter *defaultCenter = NSNotificationCenter.defaultCenter;
    [defaultCenter addObserverForName:NSHTTPCookieManagerCookiesChangedNotification
                               object:nil
                                queue:nil
                           usingBlock:^(NSNotification *notification) {
                               // 是否包含session_id
                               BOOL isContainSeesionId = NO;
                               
                               NSHTTPCookieStorage *cookieStorage = notification.object;
                               // do something with cookieStorage
                               for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
                                   // 查看是否包含session_id
                                   if ([@"session_id" isEqualToString:cookie.name]) {
                                       isContainSeesionId = YES;
                                   }
                               }
                               
                               if (!isContainSeesionId) {
                                   // 清除cookie
                                   NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                                   NSHTTPCookie *cookie;
                                   for(cookie in [storage cookies])
                                   {
                                       //NSLog(@"cookie to be deleted:%@", cookie);
                                       [storage deleteCookie:cookie];
                                   }
                                   [[NSUserDefaults standardUserDefaults] synchronize];
                               }
                           }];
    
    // 初始化页面
    [self initView];
}

// 初始化页面
- (void)initView {
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    
    // 设置WKWebView
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    config.preferences.javaScriptEnabled = YES;
    
    // webView 创建
    CGRect webRect = self.view.bounds;
    
    self.webView = [[WKWebView alloc] initWithFrame:webRect configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.webView reload];
    }];
    
    [self.view addSubview:self.webView];
    
    // 初始化url
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:INDEX_URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    [self.webView loadRequest:request];
}

- (void)reloadWebView {
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
    
    // 请求地址
    NSString *requestStr = navigationAction.request.URL.absoluteString;
    
    // isout=1
    if ([requestStr containsString:@"isout=1"]) {
        // 如果包含该字符，则是退出，直接清除cookie
        [userDefauls setValue:@"0" forKey:@"IsOut"];
        [userDefauls synchronize];
    }
    
    NSString *js_getCookies = @"document.cookie;";
    
    // 通过JS获取cookie
    [webView evaluateJavaScript:js_getCookies completionHandler:^(id object, NSError *error) {
        NSString *strCookies = object;
        
        // 获取是否是登录时退出的
        NSString *isOut = [userDefauls valueForKey:@"IsOut"];
        
        NSLog(@"是否是登录时退出的：%@", isOut);
        
        // 日志
        NSLog(@"请求Cookie：%@", strCookies);
        
        if (nil == strCookies || (nil != isOut && isOut.length > 0 && [@"1" isEqualToString:isOut])) {
            // 两个都为空时，查看内存中是否有值
            NSString *userUid = [userDefauls valueForKey:@"Cookie-Uid"];
            
            if (nil != userUid && userUid.length > 0) {
                NSString *js_setCookie = [NSString stringWithFormat:@"setCookie('uid', '%@', 365);", userUid];
                
                [webView evaluateJavaScript:js_setCookie completionHandler:nil];
            }
        }
        else {
            NSString *sessionId = @"";
            NSString *uid = @"";
            
            // 获取Cookie：session_id的值
            NSArray *arrayCookies = [strCookies componentsSeparatedByString:@";"];
            
            for (NSString *cookie in arrayCookies) {
                NSArray *params = [cookie componentsSeparatedByString:@"="];
                
                if (params.count == 2) {
                    // key
                    NSString *strKey = params.firstObject;
                    
                    strKey = [strKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    
                    if ([@"session_id" isEqualToString:strKey]) {
                        sessionId = params.lastObject;
                    }
                    
                    if ([@"uid" isEqualToString:strKey]) {
                        uid = params.lastObject;
                    }
                }
            }
            
            if (nil == uid || 0 == uid.length) {
                // 清除内存中的Cookie
                [userDefauls setValue:@"" forKey:@"Cookie-Uid"];
                [userDefauls setValue:@"0" forKey:@"IsOut"];
                [userDefauls synchronize];
            }
            else if (nil != uid && uid.length > 0) {
                // 如果不为空，且uid也不为空，则写入内存中
                [userDefauls setValue:uid forKey:@"Cookie-Uid"];
                [userDefauls setValue:@"1" forKey:@"IsOut"];
                [userDefauls synchronize];
            }
        }
        
        NSString *url = @"http://studycourse/?";
        
        if ([requestStr hasPrefix:url]) {
            NSString *strParams = [requestStr stringByReplacingOccurrencesOfString:url withString:@""];
            
            NSArray *arrayParams = [strParams componentsSeparatedByString:@"&"];
            
            Video *video = [[Video alloc] init];
            
            for (NSString *param in arrayParams) {
                NSArray *params = [param componentsSeparatedByString:@"="];
                
                if (params.count == 2) {
                    if ([@"u" isEqualToString:params.firstObject]) {
                        video.userId = params.lastObject;
                    }
                    if ([@"c" isEqualToString:params.firstObject]) {
                        video.courseId = params.lastObject;
                    }
                    if ([@"ctime" isEqualToString:params.firstObject]) {
                        video.minLearnTime = params.lastObject;
                    }
                    if ([@"s" isEqualToString:params.firstObject]) {
                        video.sessionId = params.lastObject;
                    }
                    if ([@"t" isEqualToString:params.firstObject]) {
                        video.learnTime = params.lastObject;
                    }
                    if ([@"v" isEqualToString:params.firstObject]) {
                        video.vid = params.lastObject;
                    }
                    if ([@"studytimetotal" isEqualToString:params.firstObject]) {
                        video.learnTime = params.lastObject;
                    }
                    if ([@"cid" isEqualToString:params.firstObject]) {
                        video.returnId = params.lastObject;
                    }
                }
            }
            
            // 添加监听事件，当视频播放页面返回时，刷新页面
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadWebView) name:@"ReloadWebView" object:nil];
            
            // 弹出视频播放
            TsyVideoViewController *videoView = [[TsyVideoViewController alloc] init];
            videoView.video = video;
            
            // 弹出视频界面
            [self.navigationController pushViewController:videoView animated:YES];
            
            
            decisionHandler(WKNavigationActionPolicyCancel);
        }
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView.scrollView.mj_header endRefreshing];
    
    NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
    NSString *userUid = [userDefauls valueForKey:@"Cookie-Uid"];
    
    if (nil != userUid && userUid.length > 0) {
        NSString *js_setCookie = [NSString stringWithFormat:@"setCookie('uid', '%@', 365);", userUid];
        
        [webView evaluateJavaScript:js_setCookie completionHandler:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
