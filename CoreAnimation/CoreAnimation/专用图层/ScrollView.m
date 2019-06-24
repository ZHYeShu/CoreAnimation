//
//  ScrollView.m
//  CoreAnimation
//
//  Created by dw_zhouheng on 2019/5/22.
//  Copyright © 2019年 ZHYeShu. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

+ (Class)layerClass
{
    return [CAScrollLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp
{
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panRecognizer];
}

- (void)pan:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint offset = self.bounds.origin;
    offset.x -= [panRecognizer translationInView:self].x;
    offset.y -= [panRecognizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    [panRecognizer setTranslation:CGPointZero inView:self];
}

@end
