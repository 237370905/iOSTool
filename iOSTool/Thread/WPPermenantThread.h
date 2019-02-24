//
//  WPPermenantThread.h
//  ThreadTool
//
//  Created by 陈文鹏 on 2019/2/21.
//  Copyright © 2019 陈文鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PermenantTask)(void);
NS_ASSUME_NONNULL_BEGIN

@interface WPPermenantThread : NSObject
- (void)run;
- (void)stop;
- (void)executeTask:(PermenantTask)task;
@end

NS_ASSUME_NONNULL_END
