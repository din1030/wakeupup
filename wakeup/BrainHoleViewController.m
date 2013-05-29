//
//  BrainHoleViewController.m
//  wakeup
//
//  Created by din1030 on 13/5/30.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "BrainHoleViewController.h"

@interface BrainHoleViewController ()

@end

@implementation BrainHoleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    timer = [NSTimer scheduledTimerWithTimeInterval:6
                                           target:self
                                         selector:@selector(generateHole)
                                         userInfo:nil
                                          repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
    [_Hole1 dealloc];
    [_Hole2 dealloc];
    [_Hole3 dealloc];
    [_Hole4 dealloc];
}

- (void) generateHole
{
    UIButton *newHole = [[UIButton alloc] initWithFrame:CGRectMake(100.0, 100.0, 30.0, 28.0)];
                         [newHole setBackgroundImage:[UIImage imageNamed:@"brainhole2.png"] forState:UIControlStateNormal];
    [newHole addTarget:self action:@selector(holeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newHole];
    NSLog(@"new hole");
}

- (IBAction)holeClick:(UIButton*)sender
{
    sender.hidden = YES;
}
@end
