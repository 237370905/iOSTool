//
//  WPCaptureSessionMovieFileOutputCoordinator.m
//  WPPet1718
//
//  Created by tusm on 2017/6/21.
//  Copyright © 2017年 CWP. All rights reserved.
//

#import "WPCaptureSessionMovieFileOutputCoordinator.h"
#import <UIKit/UIKit.h>

@interface WPCaptureSessionMovieFileOutputCoordinator()<AVCaptureFileOutputRecordingDelegate>
@property (nonatomic,strong) AVCaptureMovieFileOutput *movieFileOutput;
@end


@implementation WPCaptureSessionMovieFileOutputCoordinator
- (instancetype)init
{
    self = [super init];
    if(self){
        [self addMovieFileOutputToCaptureSession:self.captureSession];
    }
    return self;
}

#pragma mark -- private methods
- (BOOL)addMovieFileOutputToCaptureSession:(AVCaptureSession *)captureSession
{
    self.movieFileOutput = [AVCaptureMovieFileOutput new];
    
//    [self addNotification];
    
    return [self addOutput:_movieFileOutput toCaptureSession:captureSession];
}
- (AVCaptureVideoOrientation)getCaptureVideoOrientation {
    AVCaptureVideoOrientation result;
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            //如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown，则视频方向和拍摄时的方向是相反的。
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            result = AVCaptureVideoOrientationPortrait;
            break;
    }
    
    return result;
}
#pragma mark -- Recording
- (void)startRecording
{
    //存储地址
    NSURL *tempURL = [NSURL URLWithString:@""];//[NSObject tempFileURL];
    
//    AVCaptureConnection *captureConnection =  [_movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
//    if ([captureConnection isVideoOrientationSupported]) {
//        captureConnection.videoOrientation = [self getCaptureVideoOrientation];
//    }
    
    [_movieFileOutput startRecordingToOutputFileURL:tempURL recordingDelegate:self];
}
- (void)stopRecording
{
    [_movieFileOutput stopRecording];
}

#pragma mark -- AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    [self.delegate coordinatorDidBeginRecording:self];
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    
    [self.delegate coordinator:self didFinishRecordingToOutputFileURL:outputFileURL captureOutput:self.movieFileOutput error:error];
}
#pragma mark -- addNotification
//- (void)addNotification{
//    [self.movieFileOutput addObserver:self forKeyPath:@"recordedDuration" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    DebugLog(@"keyPath:%@,object:%@,change:%@,context:%@",keyPath,object,change,context);
//}
//- (void)dealloc
//{
//    [self.movieFileOutput removeObserver:self forKeyPath:@"recordedDuration"];
//}
@end
