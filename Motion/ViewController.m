//
//  ViewController.m
//  Motion
//
//  Created by Zhaoyu Li on 5/19/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "ViewController.h"
#import "ArcView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ArcView *containerView;
@property (weak, nonatomic) IBOutlet UIView *tempView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransformLayer *layer1 = [CATransformLayer layer];
    layer1.bounds = self.tempView.bounds;
    layer1.position = self.tempView.layer.position;
    
    CALayer *redLayer = [CALayer layer];
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    redLayer.bounds = self.tempView.bounds;
    redLayer.position = self.tempView.layer.position;
    
    [self.tempView.layer addSublayer:layer1];
    [layer1 addSublayer:redLayer];
    
    CATransform3D transform = layer1.transform;
    transform.m34 = 1.0/200;
//    transform = CATransform3DMakeRotation(M_PI_4, 1.0, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI*2/5, 1.0, 0, 0);

    
    layer1.transform = transform;
    
    self.tempView.layer.backgroundColor = [UIColor grayColor].CGColor;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animation:(id)sender {
    [self.containerView startAnimation];
}
- (IBAction)changeImage:(id)sender {
    [self.containerView changeImage];
}

@end
