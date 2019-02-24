//
//  WPCaptureSessionCoordinator.h
//  WPPet1718
//
//  Created by tusm on 2017/6/21.
//  Copyright © 2017年 CWP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol WPCaptureSessionCoordinatorDelegate;

@interface WPCaptureSessionCoordinator : NSObject
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDevice *cameraDevice;
@property (nonatomic, strong) dispatch_queue_t delegateCallbackQueue;
@property (nonatomic, weak) id<WPCaptureSessionCoordinatorDelegate> delegate;

- (void)setDelegate:(id<WPCaptureSessionCoordinatorDelegate>)delegate callbackQueue:(dispatch_queue_t)delegateCallbackQueue;

- (BOOL)addInput:(AVCaptureDeviceInput *)input toCaptureSession:(AVCaptureSession *)captureSession;
- (BOOL)addOutput:(AVCaptureOutput *)output toCaptureSession:(AVCaptureSession *)captureSession;

//切换输入设备
- (BOOL)cutCameraDeviceFromeCaptureSession:(AVCaptureSession *)captureSession;

- (void)startRunning;
- (void)stopRunning;

- (void)startRecording;
- (void)stopRecording;

- (AVCaptureVideoPreviewLayer *)previewLayer;





@end

@protocol WPCaptureSessionCoordinatorDelegate <NSObject>

@required

- (void)coordinatorDidBeginRecording:(WPCaptureSessionCoordinator *)coordinator;
- (void)coordinator:(WPCaptureSessionCoordinator *)coordinator didFinishRecordingToOutputFileURL:(NSURL *)outputFileURL captureOutput:(AVCaptureOutput *)captureOutput error:(NSError *)error;
@end
