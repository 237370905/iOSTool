//
//  WPProxy.m
//  Timer
//
//  Created by wp on 2018/12/23.
//  Copyright © 2018 wp. All rights reserved.
//

#import "WPProxy.h"

@implementation WPProxy
+ (instancetype)proxyWithTarget:(id)target
{
    WPProxy *proxy = [WPProxy alloc];
    proxy.target = target;
    return proxy;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}
@end
