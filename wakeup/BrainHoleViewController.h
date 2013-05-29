//
//  BrainHoleViewController.h
//  wakeup
//
//  Created by din1030 on 13/5/30.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrainHoleViewController : UIViewController
{
    NSTimer *timer;
}
@property (retain, nonatomic) IBOutlet UIButton *Hole1;
@property (retain, nonatomic) IBOutlet UIButton *Hole2;
@property (retain, nonatomic) IBOutlet UIButton *Hole3;
@property (retain, nonatomic) IBOutlet UIButton *Hole4;

//@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *hole;

-(IBAction)holeClick:(UIButton*)sender;

@end
