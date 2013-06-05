//
//  CalendarCollectionViewController.m
//  wakeup
//
//  Created by din1030 on 13/6/5.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "CalendarCollectionViewController.h"

@interface CalendarCollectionViewController ()

@end

@implementation CalendarCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 設定 nav bar
        UINavigationBar *navBar = [self.navigationController navigationBar];
        [navBar setBackgroundImage:[UIImage imageNamed:@"set_alarm_bar.png"] forBarMetrics:UIBarMetricsDefault];
        
        // 設定透明
        //navBar.translucent = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
