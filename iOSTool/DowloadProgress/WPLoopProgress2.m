//
//  WPLoopProgress2.m
//  DowloadProgress
//
//  Created by tusm on 2017/11/29.
//  Copyright © 2017年 CWP. All rights reserved.
//

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "WPLoopProgress2.h"
@interface WPLoopProgress2()
@property (nonatomic,strong)UIView *progressView;
@property (nonatomic,strong)CAShapeLayer *maskLayer;
@property (nonatomic,strong)CAShapeLayer *progressLayer;
@property (nonatomic,strong)UILabel *progressLabel;
@end
@implementation WPLoopProgress2
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setup];
        [self progressLabel];
    }
    return self;
}
- (void)setup
{
    
    [self progressView];
    CGPoint center = CGPointMake(self.bounds.size.width*.5, self.bounds.size.height*.5);
    CGFloat radius = (self.bounds.size.width - 40)*.5;
    CGFloat start = - M_PI_2;
    //[0-1], (2 * M_PI)/ 1 * self.progress
    CGFloat end = - M_PI_2 + M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];
    
    _maskLayer = [[CAShapeLayer alloc]init];
    _maskLayer.path = path.CGPath;
    _maskLayer.lineWidth = 4;
    _maskLayer.strokeColor = RGBA(231, 231, 231, 1).CGColor;
    _maskLayer.fillColor = [UIColor clearColor].CGColor;
    _maskLayer.lineCap = kCALineCapRound;
    self.progressView.layer.mask = _maskLayer;
    
    _progressLayer = [[CAShapeLayer alloc]init];
    _progressLayer.path = path.CGPath;
    _progressLayer.lineWidth = 4;
    _progressLayer.strokeColor = RGBA(19, 216, 56, 1).CGColor;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeEnd = 0.0;
    [self.progressView.layer addSublayer:_progressLayer];
}
- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [UIView new];
        _progressView.frame = self.bounds;
        _progressView.backgroundColor = RGBA(231, 231, 231, 1);
        [self addSubview:_progressView];
    }
    return _progressView;
}
- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [UILabel new];
        _progressLabel.frame = CGRectMake(0, 0, self.bounds.size.width - 40 - 10, 16);
        _progressLabel.center = CGPointMake(self.bounds.size.width*.5, self.bounds.size.height*.5);
        _progressLabel.font = [UIFont systemFontOfSize:8];
        _progressLabel.text = @"0.0%";
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_progressLabel];
    }
    return _progressLabel;
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _progressLabel.text = [NSString stringWithFormat:@"%.01lf%%",progress*100];
    self.progressLayer.strokeEnd = progress;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
