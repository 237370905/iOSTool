//
//  UIView+DrawLine.h
//  iOSTool
//
//  Created by wp on 2019/2/24.
//  Copyright © 2019 wp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DrawLine)
/*
 *绘制虚线
 */
- (void)drawDeshLineWithColor:(UIColor *)color andWidth:(CGFloat) width andBeginPoint:(CGPoint)beginPoint andEndPoint:(CGPoint)endPoint;

/*
 *画边框
 */
- (void)drawBorderWithColor:(UIColor *)color width:(CGFloat)width roundingCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornerRadii;
@end

NS_ASSUME_NONNULL_END
