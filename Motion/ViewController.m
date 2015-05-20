//
//  ViewController.m
//  Motion
//
//  Created by Zhaoyu Li on 5/19/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "ViewController.h"
#import "ArcView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ArcView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animation:(id)sender {
    [self.containerView startAnimation];
}

@end
