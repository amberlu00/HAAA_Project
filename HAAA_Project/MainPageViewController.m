//
//  MainPageViewController.m
//  HAAA_Project
//
//  Created by Amber Lu on 10/22/18.
//  Copyright © 2018 Amber Lu. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Setting up the video for the main page
    NSString *mainPageVideoPath = [[NSBundle mainBundle] pathForResource:@"MainPageVideo" ofType:@"mp4"];
    NSURL *mainPageVideoURL = [NSURL fileURLWithPath:mainPageVideoPath];
    AVPlayerViewController *mainPageVideoController = [[AVPlayerViewController alloc] init];
    [self addChildViewController:mainPageVideoController];
    [self.view addSubview:mainPageVideoController.view];
    mainPageVideoController.view.frame = CGRectMake(0, 60, CGRectGetWidth([[UIScreen mainScreen] bounds]), 300);
    AVPlayer *mainPageVideoPlayer = [[AVPlayer alloc] initWithURL:mainPageVideoURL];
    [mainPageVideoController setPlayer:mainPageVideoPlayer];
    
    [mainPageVideoPlayer pause];
    
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
