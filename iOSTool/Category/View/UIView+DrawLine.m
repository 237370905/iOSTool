//
//  UIView+DrawLine.m
//  iOSTool
//
//  Created by wp on 2019/2/24.
//  Copyright © 2019 wp. All rights reserved.
//

#import "UIView+DrawLine.h"

@implementation UIView (DrawLine)

- (void)drawDeshLineWithColor:(UIColor *)color andWidth:(CGFloat)width andBeginPoint:(CGPoint)beginPoint andEndPoint:(CGPoint)endPoint
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //设置虚线颜色
    [shapeLayer setStrokeColor:color.CGColor];
    //设置虚线宽度
    [shapeLayer setLineWidth:width];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineCap:kCALineCapRound];
    //设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:@[@4,@10]];
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置虚线绘制路径起点
    CGPathMoveToPoint(path, NULL, beginPoint.x, beginPoint.y);
    //设置虚线绘制路径终点
    CGPathAddLineToPoint(path, NULL, endPoint.x,endPoint.y);
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //添加虚线
    [self.layer addSublayer:shapeLayer];
}

- (void)drawBorderWithColor:(UIColor *)color width:(CGFloat)width roundingCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornerRadii
{
    //UIRectCornerBottomLeft | UIRectCornerTopRight | UIRectCornerBottomRight
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    CAShapeLayer *borderLayer = nil;
    if (!color || width != 0.0) {
        borderLayer = [[CAShapeLayer alloc]init];
        borderLayer.frame = self.bounds;
        borderLayer.lineWidth = width;
        borderLayer.strokeColor = color.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.path = maskPath.CGPath;
    }
    
    //防止cell复用时导致多个相同功能Layer
    CALayer *subLayer = nil;
    for (subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAShapeLayer class]]) {
            break;
        }
    }
    
    if (subLayer && borderLayer) {
        [self.layer replaceSublayer:subLayer with:borderLayer];
    }else if(!subLayer && borderLayer){
        [self.layer insertSublayer:borderLayer atIndex:0];
    }
    
    self.layer.mask = maskLayer;
}

@end
