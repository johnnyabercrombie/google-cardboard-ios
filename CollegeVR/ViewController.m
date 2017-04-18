//
//  ViewController.m
//  VR
//
//  Created by Jonathan Abercrombie on 4/7/16.
//  Copyright © 2016 Jonathan Abercrombie. All rights reserved.
//

/*
 * CollegeVR
 */


#import "ViewController.h"
#import "GVRPanoramaView.h"
#import "GVRVideoView.h"

@interface ViewController() <GVRVideoViewDelegate>

@end

@implementation ViewController {
    GVRPanoramaView *_panoView1;
    GVRPanoramaView *_panoView2;
    GVRVideoView *_videoView;
    GVRVideoView *_videoView2;
    GVRVideoView *_videoView3;
    UIScrollView *_scrollView;
    BOOL _isPaused;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"VR";
//    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_scrollView];
    
//    _panoView1 = [[GVRPanoramaView alloc] init];
//    _panoView1.enableFullscreenButton = YES;
//    _panoView1.enableCardboardButton = YES;
//    [_panoView1 loadImage:[UIImage imageNamed:@"IMG_3110.jpg"]
//                   ofType:kGVRPanoramaImageTypeMono];
//    _panoView1.frame = CGRectMake(0,
//                                  0,
//                                  CGRectGetMaxX(self.view.frame)/2,
//                                  kPanoViewHeight);
//    [_scrollView addSubview:_panoView1];
//    
//    _panoView2 = [[GVRPanoramaView alloc] init];
//    _panoView2.enableFullscreenButton = YES;
//    _panoView2.enableCardboardButton = YES;
//    [_panoView2 loadImage:[UIImage imageNamed:@"IMG_3110.JPG"]
//                   ofType:kGVRPanoramaImageTypeMono];
//    _panoView2.frame = CGRectMake(CGRectGetMaxX(self.view.frame)/2,
//                                  0,
//                                  CGRectGetWidth(self.view.bounds)/2,
//                                  kPanoViewHeight);
//    [_scrollView addSubview:_panoView2];
//
//    _panoView2 = [[GCSPanoramaView alloc] init];
//    _panoView2.enableFullscreenButton = YES;
//    _panoView2.enableCardboardButton = YES;
//    [_panoView2 loadImage:[UIImage imageNamed:@"TempPanorama2.jpg"]
//                   ofType:kGCSPanoramaImageTypeStereoOverUnder];
//    _panoView2.frame = CGRectMake(kMargin,
//                                  kMargin * 3 + CGRectGetHeight(self.view.bounds) - 2 * kMargin,
//                                  CGRectGetWidth(self.view.bounds) - 2 * kMargin,
//                                  CGRectGetHeight(self.view.bounds) - 2 * kMargin);
//    [self.view addSubview:_panoView2];
    
    _videoView = [[GVRVideoView alloc]
                   initWithFrame:CGRectMake(0,
                                            0,
                                            self.view.bounds.size.width,
                                            200)];
    _videoView.delegate = self;
    _videoView.enableCardboardButton = YES;
    _videoView.enableFullscreenButton = YES;
    [_scrollView addSubview:_videoView];
    _isPaused = NO;
    _videoView.enableTouchTracking = YES;
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"floss" ofType:@"mov"];
    [_videoView loadFromUrl:[[NSURL alloc] initFileURLWithPath:videoPath]];
    
    
    
    
//    _videoView2 = [[GVRVideoView alloc]
//                  initWithFrame:CGRectMake(0,
//                                           CGRectGetMaxY(_videoView.frame),
//                                           self.view.bounds.size.width,
//                                           200)];
//    _videoView2.delegate = self;
//    _videoView2.enableCardboardButton = YES;
//    _videoView2.enableFullscreenButton = YES;
//    [_scrollView addSubview:_videoView2];
//    _isPaused = NO;
//    _videoView2.enableTouchTracking = YES;
//    NSString *videoPath2 = [[NSBundle mainBundle] pathForResource:@"floss prison riot" ofType:@"mp4"];
//    [_videoView2 loadFromUrl:[[NSURL alloc] initFileURLWithPath:videoPath2]];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),
                                         CGRectGetMaxY(_videoView.frame));
}

#pragma mark - GCSVideoViewDelegate

- (void)widgetViewDidTap:(GVRWidgetView *)widgetView {
    if (_isPaused) {
        widgetView == _videoView ? [_videoView resume] : [_videoView2 resume];
    } else {
        widgetView == _videoView ? [_videoView pause] : [_videoView2 pause];
    }
    _isPaused = !_isPaused;
}

- (void)videoView:(GVRVideoView*)videoView didUpdatePosition:(NSTimeInterval)position {
    // Rewind to beginning of the video when it reaches the end.
    if (position == videoView.duration) {
//        _isPaused = YES;
        if (videoView == _videoView) {
            [_videoView seekTo:0];
            [_videoView resume];
        }
        if (videoView == _videoView2) {
            [_videoView2 seekTo:0];
            [_videoView2 resume];
        }
//        if ([videoView isEqual:_videoView.copy]) {
//            [_videoView seekTo:0];
//            [_videoView resume];
//        }
//        if ([videoView isEqual:_videoView2.copy]) {
//            [_videoView2 seekTo:0];
//            [_videoView2 resume];
//        }
    }
}

@end
