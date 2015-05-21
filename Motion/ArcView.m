//
//  ArcView.m
//  Motion
//
//  Created by Zhaoyu Li on 5/20/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "ArcView.h"

@interface ArcView ()
@property (nonatomic, strong) CAShapeLayer *pathLayerFirstHalf;
@property (nonatomic, strong) CAShapeLayer *pathLayerLastHalf;

@property (nonatomic, strong) CATransformLayer *parentLayer;
@property (nonatomic, strong) CALayer *imageLayer;
@end

@implementation ArcView

-(CAShapeLayer *)pathLayerFirstHalf{
    if (_pathLayerFirstHalf == nil)
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = [[self samplePathFirstHalf] CGPath];
        shapeLayer.strokeColor = [[UIColor grayColor] CGColor];
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = 5.0f;
        shapeLayer.lineJoin = kCALineJoinBevel;
        
        _pathLayerFirstHalf = shapeLayer;
    }
    return _pathLayerFirstHalf;

}

-(CAShapeLayer *)pathLayerLastHalf{
    if (_pathLayerLastHalf == nil)
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = [[self samplePathLastHalf] CGPath];
        shapeLayer.strokeColor = [[UIColor grayColor] CGColor];
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = 5.0f;
        shapeLayer.lineJoin = kCALineJoinBevel;
        
        [self.parentLayer addSublayer:shapeLayer];
        
        _pathLayerLastHalf = shapeLayer;
    }
    return _pathLayerLastHalf;
    
}



- (void)addImageLayer {
    //    CALayer *green = [ArcView createLayerWithColor:[UIColor greenColor] withPosition:self.layer.position withFrame:self.frame];
    //    
    //    [self.parentLayer addSublayer:green];
    UIImage *image = [UIImage imageNamed:@"test.png"];
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = CGRectMake(0, 0, image.size.width,  image.size.height);
    self.imageLayer.position = self.layer.position;
    self.imageLayer.contents = (__bridge id)image.CGImage;
    [self.layer insertSublayer:self.imageLayer above:self.parentLayer];
    self.imageLayer.shadowColor = [[UIColor grayColor] CGColor];
    self.imageLayer.shadowOpacity = 0.5;
    self.imageLayer.shadowRadius = 10.0;
    CGRect ovalRect = CGRectMake(0.0f, self.imageLayer.bounds.size.height + 5, self.imageLayer.bounds.size.width, 50);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    self.imageLayer.shadowPath = path.CGPath;
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

- (UIBezierPath *)samplePathFirstHalf
{
//    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0 + 30, 0 + 30, self.bounds.size.width -60, self.bounds.size.height -60)];
    UIBezierPath* ovalPath  = [UIBezierPath bezierPathWithArcCenter:self.layer.position radius:self.layer.bounds.size.width/2 - 30 startAngle:0 endAngle:M_PI clockwise:YES];
    
    return ovalPath;
}

- (UIBezierPath *)samplePathLastHalf
{
    //    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0 + 30, 0 + 30, self.bounds.size.width -60, self.bounds.size.height -60)];
    UIBezierPath* ovalPath  = [UIBezierPath bezierPathWithArcCenter:self.layer.position radius:self.layer.bounds.size.width/2 - 30 startAngle:M_PI endAngle:2 * M_PI clockwise:YES];
    
    return ovalPath;
}

- (void)startAnimation
{
    
    [self.parentLayer addSublayer:self.pathLayerFirstHalf];

    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
    [self.pathLayerFirstHalf addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
    [self addImageLayer];
    
//    [self.parentLayer addSublayer:self.pathLayerLastHalf];

    
    
}

-(void)changeImage{
    UIImage *image = [UIImage imageNamed:@"test1.png"];
    self.imageLayer.contents = (__bridge id)(image.CGImage);
    [self.layer setNeedsDisplay];
}
@end
