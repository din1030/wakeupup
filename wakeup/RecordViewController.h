//
//  RecordViewController.h
//  wakeup
//
//  Created by din1030 on 13/5/9.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UIViewController <UIScrollViewDelegate> {
    BOOL pageControlIsChangingPage;
}

- (IBAction)combinePagine:(id)sender;
- (void)setupPage;
@end


