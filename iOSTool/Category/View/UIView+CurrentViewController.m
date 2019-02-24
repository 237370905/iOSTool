//
//  UIView+CurrentViewController.m
//  iOSTool
//
//  Created by wp on 2019/2/24.
//  Copyright © 2019 wp. All rights reserved.
//

#import "UIView+CurrentViewController.h"

@implementation UIView (CurrentViewController)

- (UIViewController *)currentViewController
{
    id next = self;
    for (; next; next = [next superview]) {
        UIResponder *responder = [next nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
