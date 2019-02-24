//
//  WPProxy1.m
//  Timer
//
//  Created by wp on 2018/12/23.
//  Copyright © 2018 wp. All rights reserved.
//

#import "WPProxy1.h"

@implementation WPProxy1

+ (instancetype)proxyWithTarget:(id)target
{
    WPProxy1 *proxy = [[WPProxy1 alloc]init];
    proxy.target = target;
    return proxy;
}
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}
@end
