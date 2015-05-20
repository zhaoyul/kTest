//
//  ArcView.m
//  Motion
//
//  Created by Zhaoyu Li on 5/20/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "ArcView.h"

@interface ArcView ()
@property (nonatomic, strong) CAShapeLayer *pathLayer;
@property (nonatomic, strong) CATransformLayer *parentLayer;
@property (nonatomic, strong) CALayer *imageLayer;
@end

@implementation ArcView


- (void)addImageLayer {
    //    CALayer *green = [ArcView createLayerWithColor:[UIColor greenColor] withPosition:self.layer.position withFrame:self.frame];
    //    
    //    [self.parentLayer addSublayer:green];
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = self.bounds;
    UIImage *image = [UIImage imageNamed:@"test.png"];
    self.imageLayer.contents = (__bridge id)image.CGImage;
    [self.layer insertSublayer:self.imageLayer above:self.parentLayer];
}

- (void)drawRect:(CGRect)rect {
    [ArcView drawToLayer:self.layer TextAtTopLeftWithText:@"主页面"];
    
    self.parentLayer = [CATransformLayer layer];
    {
        self.parentLayer.position = self.layer.position;
        self.parentLayer.bounds = self.bounds;
        [self.layer addSublayer:self.parentLayer];
    }
    CATransform3D transform = self.layer.transform;
    transform.m34 = 1.0 / 500.0;
    transform = CATransform3DRotate(transform, -M_PI*2/5, 1.0, 0, 0);
    self.parentLayer.transform = transform;
    
    
}

+(void)drawToLayer:(CALayer*)layer TextAtTopLeftWithText:(NSString*) str{
    CATextLayer *label = [[CATextLayer alloc] init];
    [label setFont:@"Helvetica-Bold"];
    [label setFontSize:20];
    [label setFrame:CGRectMake(0, 0, 100, 40)];
    [label setString:str];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor purpleColor] CGColor]];
    [layer addSublayer:label];
}

+ (CALayer *)createLayerWithColor:(UIColor*) color
                     withPosition:(CGPoint) position
                        withFrame:(CGRect) bounds
{
    CALayer *green = [[CALayer alloc] init];
    green.cornerRadius = 5;
    green.bounds = bounds;
    green.position = position;
    green.backgroundColor = [color CGColor];
    return green;
}

- (UIBezierPath *)samplePath
{
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0 + 30, 0 + 30, self.bounds.size.width -60, self.bounds.size.height -60)];

    
    // build the path here
    
    return ovalPath;
}

- (void)startAnimation
{
    if (self.pathLayer == nil)
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = [[self samplePath] CGPath];
        shapeLayer.strokeColor = [[UIColor grayColor] CGColor];
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = 5.0f;
        shapeLayer.lineJoin = kCALineJoinBevel;
        
        [self.parentLayer addSublayer:shapeLayer];
        
        self.pathLayer = shapeLayer;
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    [self addImageLayer];
}
@end
