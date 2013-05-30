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
    self.hole_img = [NSArray arrayWithObjects:@"brainhole1.png",@"brainhole2.png",@"brainhole3.png",@"brainhole4.png",nil];
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
    for (id obj in self.view.subviews)
    {
        if ([obj isKindOfClass:[UIButton class]])
        { 
            UIButton *oldHole = (UIButton*) obj;
            //UIButton *newHole = [[UIButton alloc] initWithFrame:oldHole.frame];
            switch (oldHole.tag) {  // 判斷下個 level 的圖
                case 1:
                    [oldHole setBackgroundImage:[UIImage imageNamed:@"brainhole2.png"] forState:UIControlStateNormal];
                    //[newHole setBackgroundImage:[UIImage imageNamed:@"brainhole2.png"] forState:UIControlStateNormal];
                    //newHole.tag = 2;
                    oldHole.tag++;
                    //[self.view addSubview:newHole];
                    NSLog(@"new hole 2");
                    break;
                case 2:
                    [oldHole setBackgroundImage:[UIImage imageNamed:@"brainhole3.png"] forState:UIControlStateNormal];
                    //newHole.tag = 3;
                    oldHole.tag++;
                    //[self.view addSubview:newHole];
                    NSLog(@"new hole 3");
                    break;
                case 3:
                    [oldHole setBackgroundImage:[UIImage imageNamed:@"brainhole4.png"] forState:UIControlStateNormal];
                    //newHole.tag = 4;
                    oldHole.tag++;
                    //[self.view addSubview:newHole];
                    NSLog(@"new hole 4");
                    break;
                default:
                    oldHole.hidden = NO;
                    oldHole.tag++;
                    break;
            }
            // 接 action ＆ 放回 view
            //[oldHole addTarget:self action:@selector(holeClick:) forControlEvents:UIControlEventTouchUpInside];
            //[self.view addSubview:newHole];
        }
    }

}

- (IBAction)holeClick:(UIButton*)sender
{
    UIButton *thisHole = (UIButton*) sender;
    //thisHole.tag--;
    if (thisHole.tag == 1) {
        thisHole.tag--;
        thisHole.hidden = YES;
    }
    else {
        thisHole.tag--;
        NSLog(@"%d",thisHole.tag);
        [thisHole setBackgroundImage:[UIImage imageNamed:[self.hole_img objectAtIndex:(thisHole.tag-1)]] forState:UIControlStateNormal];
    }
}
@end
