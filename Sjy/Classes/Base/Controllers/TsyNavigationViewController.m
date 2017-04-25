//
//  TsyNavigationViewController.m
//  Tsy
//
//  Created by LV-Mac on 16/7/6.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import "TsyNavigationViewController.h"
#import "UIColor+Hex.h"

#import "TsyVideoViewController.h"

@interface TsyNavigationViewController ()

@end

@implementation TsyNavigationViewController

// 执行一次，统一设置导航栏样式
+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 导航栏颜色
    [navBar setBarTintColor:[UIColor colorWithHexString:MAIN_COLOR]];
    
    // 状态栏设置
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 导航栏标题样式设置
    NSDictionary *titleAttr = @{
                                // 颜色
                                NSForegroundColorAttributeName: [UIColor whiteColor],
                                // 字体
                                NSFontAttributeName: [UIFont systemFontOfSize:FONT_SIZE_TITLE]
                                };
    
    [navBar setTitleTextAttributes:titleAttr];
    
    navBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

// 哪些子控制器支持自动转屏
- (BOOL)shouldAutorotate{
    if ([self.topViewController isMemberOfClass:[TsyVideoViewController class]]) {
        return YES;
    }
    
    return YES;
}

// 子控制支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if ([self.topViewController isMemberOfClass:[TsyVideoViewController class]]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  一开始的方向
 *
 *  @return 方向
 */
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if ([self.topViewController isMemberOfClass:[TsyVideoViewController class]]) {
        return UIInterfaceOrientationLandscapeRight;
    }
    
    return UIInterfaceOrientationPortrait;
}

@end
