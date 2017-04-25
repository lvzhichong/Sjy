//
//  TsyVideoViewController.h
//  Tsy
//
//  Created by LV-Mac on 16/7/6.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface TsyVideoViewController : UIViewController

@property (nonatomic, strong) Video* video;
@property (assign, nonatomic) BOOL isPresented;

@end
