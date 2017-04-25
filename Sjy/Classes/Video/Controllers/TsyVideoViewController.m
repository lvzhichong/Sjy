//
//  TsyVideoViewController.m
//  Tsy
//
//  Created by LV-Mac on 16/7/6.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import "TsyVideoViewController.h"
#import "SkinVideoViewController.h"
#import "PvVideo.h"
#import "PolyvSettings.h"
#import "TsyHTTPManager.h"

@import AVFoundation;

@interface TsyVideoViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong)  SkinVideoViewController *videoPlayer;

// 存储当前的vid
@property (nonatomic, assign) NSString *currentVid;
@property (nonatomic, assign) BOOL isShouldPause;

@end

@implementation TsyVideoViewController

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    //NSLog(@"finished");
}

- (void)movieLoadStateDidChange:(NSNotification *)notification {
    
    //NSLog(@"LoadStateDidChange");
}

- (void)moviePlaybackIsPreparedToPlayDidChange:(NSNotification *)notification {
    
    /* 演示代码示例
     if (_isShouldPause) {
     [self.videoPlayer pause];
     [self.videoPlayer monitorVideoPlayback];
     _isShouldPause = NO;
     } */
}

- (void)viewDidDisappear:(BOOL)animated {
    // 记录本视频播放时间,记录播放进度需要执行此操作
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:[ [NSUserDefaults standardUserDefaults] dictionaryForKey:@"dict"]];
    if (!self.videoPlayer.isWatchCompleted) {
        [mDict setValue:@(self.videoPlayer.currentPlaybackTime) forKey:@"0aec715c1efb8e2d2b63e040668853ac_0"];
        [[NSUserDefaults standardUserDefaults] setObject:mDict forKey:@"dict"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.isPresented = YES;
    self.videoPlayer.contentURL = nil;
    [self.videoPlayer stop];
    [self.videoPlayer cancel];
    [self.videoPlayer cancelObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    // 摄像头关闭
    [self.videoPlayer stopCamera];
    
    [super viewDidDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isPresented = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.videoPlayer configObserver];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieLoadStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlaybackIsPreparedToPlayDidChange:) name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    
    // 如果摄像头显示状态，先隐藏
    [self.videoPlayer hidenCamera];
    
    // 横屏
    [self.videoPlayer setFullScreen];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化View
    [self initView];
}

- (void)initView {
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    // 状态栏设置
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 加载播放器
    [self initVideo];
}

// 加载播放器
- (void)initVideo {
    CGFloat width = self.view.bounds.size.width;
    
    // 初始化播放器
    if (!self.videoPlayer) {
        self.videoPlayer = [[SkinVideoViewController alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, width, width*(9.0/16.0))];
    }
    
    // 添加播放器
    [self.view addSubview:self.videoPlayer.view];
    
    // 播放器设置
    // 是否保留导航栏
    [self.videoPlayer keepNavigationBar:NO];
    [self.videoPlayer setNavigationController: self.navigationController];
    // 弹屏
    [self.videoPlayer setEnableDanmuDisplay:NO];
    // 倍速
    [self.videoPlayer setEnableRateDisplay:NO];
    // 问答
    [self.videoPlayer setEnableExam:NO];
    // 是否自动播放
    [self.videoPlayer setAutoplay:YES];
    // 视频信息
    // 标题
    [self.videoPlayer setHeadTitle:[NSString stringWithFormat:@"您已学习%@分钟，课程最小学习时间为%@分钟！", self.video.learnTime, self.video.minLearnTime]];
    // 视频播放Id
    [self.videoPlayer setVid:self.video.vid];
    
    // 播放器事件
    __weak typeof(self) weakSelf = self;
    
    [self.videoPlayer setWatchCompletedBlock:^{
        // 播放完成时调用
        _isShouldPause = YES;
        
        NSLog(@"播放完成！");
        
        [weakSelf.videoPlayer stopTask];
        
        // 播放完成后，返回
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadWebView" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:weakSelf name:@"ReloadWebView" object:nil];
    }];
    
    // 未调用摄像头之前，可以返回
    self.videoPlayer.isCanBack = YES;
    
    // 注册监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startCameraAndTakePhoto) name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
}

- (void)startCameraAndTakePhoto {
    [self.videoPlayer pause];
    // 先启动相机
    [self.videoPlayer startCamera];
    // 三秒后开始拍照
    [self performSelector:@selector(takePhoto) withObject:nil afterDelay:3.0f];
}

- (void)takePhoto {
    if (self.videoPlayer.isPreparedToPlay) {
        [self.videoPlayer takePhoto:self.video];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated {
    // 取消网络请求
    [TsyHTTPManager cancelAllRequest];
    
    NSLog(@"已执行请求销毁");
    
    [super viewWillDisappear:animated];
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
