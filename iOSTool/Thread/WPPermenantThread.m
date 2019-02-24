//
//  WPPermenantThread.m
//  ThreadTool
//
//  Created by 陈文鹏 on 2019/2/21.
//  Copyright © 2019 陈文鹏. All rights reserved.
//

#import "WPPermenantThread.h"
#import "WPThread.h"
@interface WPPermenantThread()
@property (nonatomic, strong)NSThread *innerThread;
@property (nonatomic, assign, getter=isStopped)BOOL stopped;
@end

@implementation WPPermenantThread
- (instancetype)init
{
    if (self =[super init]) {
        self.stopped = NO;
        __weak typeof(self) weakSelf = self;
        self.innerThread = [[NSThread alloc]initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.isStopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                
            }
        }];
    }
    return self;
}
- (void)run
{
    if (!self.innerThread) return;
    [self.innerThread start];
}
- (void)stop
{
    if (!self.innerThread) return;
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}
- (void)executeTask:(PermenantTask)task
{
    if (!self.innerThread || !task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}
- (void)__stop
{
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}
- (void)__executeTask:(PermenantTask)task
{
    task();
}
- (void)dealloc
{
    [self stop];
}
@end
