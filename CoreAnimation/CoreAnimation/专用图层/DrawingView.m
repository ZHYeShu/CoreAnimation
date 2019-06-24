//
//  DrawingView.m
//  CoreAnimation
//
//  Created by dw_zhouheng on 2019/6/14.
//  Copyright © 2019年 ZHYeShu. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView ()
@property (nonatomic, strong)UIBezierPath *path;
@end

//绘图用CAShapeLayer比Core Graphics性能优异。
@implementation DrawingView

+(Class)layerClass
{
    return [CAShapeLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.path = [[UIBezierPath alloc] init];
//        self.path.lineJoinStyle = kCGLineJoinRound;
//        self.path.lineCapStyle = kCGLineCapRound;
//        self.path.lineWidth = 5;
        
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 5;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint startPoint = [[touches anyObject] locationInView:self];
    [self.path moveToPoint:startPoint];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:currentPoint];
    
    //redraw the view
//    [self setNeedsDisplay];
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
    
}

//-(void)drawRect:(CGRect)rect
//{
//    [[UIColor clearColor] setFill];
//    [[UIColor redColor] setStroke];
//    [self.path stroke];
//}

@end
