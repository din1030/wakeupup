//
//  BrainHoleViewController.h
//  wakeup
//
//  Created by din1030 on 13/5/30.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHOLES 12

@interface BrainHoleViewController : UIViewController
{
    NSTimer *check_timer;
    NSTimer *levelup_timer;
    NSUInteger remain_hole;
}
@property (retain, nonatomic) IBOutlet UIButton *Hole1;
@property (retain, nonatomic) IBOutlet UIButton *Hole2;
@property (retain, nonatomic) IBOutlet UIButton *Hole3;
@property (retain, nonatomic) IBOutlet UIButton *Hole4;

//@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *hole_lv1;
//@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *hole_lv2;
//@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *hole_lv3;
//@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *hole_lv4;

@property (retain, nonatomic)  NSArray *hole_img;


-(IBAction)holeClick:(UIButton*)sender;

@end
