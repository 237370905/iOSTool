//
//  WPLoopProgress.m
//  DowloadProgress
//
//  Created by tusm on 2017/11/29.
//  Copyright © 2017年 CWP. All rights reserved.
//

#import "WPLoopProgress.h"

@implementation WPLoopProgress
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGPoint center = CGPointMake(self.bounds.size.width*.5, self.bounds.size.height*.5);
    CGFloat radius = (self.bounds.size.width - 40)*.5;
    CGFloat start = - M_PI_2;
    //[0-1], (2 * M_PI)/ 1 * self.progress
    CGFloat end = - M_PI_2 + M_PI * 2 * self.progress;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];
    CGContextSetLineWidth(ctx, 4); //设置线条宽度
    [[UIColor redColor] set]; //设置描边颜
    [path stroke];
    CGContextAddPath(ctx, path.CGPath); //把路径添加到上下文
    
    CGContextStrokePath(ctx);
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}
@end
