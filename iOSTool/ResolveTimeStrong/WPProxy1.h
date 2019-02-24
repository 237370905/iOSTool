//
//  WPProxy.h
//  Timer
//
//  Created by wp on 2018/12/23.
//  Copyright © 2018 wp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPProxy1 : NSObject
@property (nonatomic,weak)id target;
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
