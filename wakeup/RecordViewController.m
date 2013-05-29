//
//  RecordViewController.m
//  wakeup
//
//  Created by din1030 on 13/5/9.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation RecordViewController


- (void)viewDidLoad
{
    [self setupPage];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //UIPageControl設定
    [self.pageControl setNumberOfPages:4];
    [self.pageControl setCurrentPage:0];
    
    //UIScrollView設定
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setScrollsToTop:NO];
    [self.scrollView setDelegate:self];
    
////
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupPage
{
    self.scrollView.delegate = self;
    [self.scrollView setCanCancelContentTouches:NO];
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;

    
    CGFloat width, height;
    width = self.scrollView.frame.size.width;
    height = self.scrollView.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(width * 5, height)];
    
    //製作ScrollView的內容
    for (int i=0; i!=self.pageControl.numberOfPages; i++) {
        CGRect frame = CGRectMake(width*i, 0, width, height);
        UIView *view = [[UIView alloc]initWithFrame:frame];
        
        CGFloat r, g ,b;
        r = (arc4random() % 10) / 10.0;
        g = (arc4random() % 10) / 10.0;
        b = (arc4random() % 10) / 10.0;
        [view setBackgroundColor:[UIColor colorWithRed:r green:g blue:b alpha:0.3]];
        
        [self.scrollView addSubview:view];
    }
    
//    CGFloat cx = 0;
//    for (int i = 0; i < _arrActivityImage.count; i++)
//    {
//        NSString *imageName = [NSString stringWithFormat:@"%@", [_arrActivityImage objectAtIndex:i]];
//        UIImage *immagine = [UIImage imageNamed:imageName];
//        
//        if (immagine == nil)
//        {
//            break;
//        }
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:immagine];
//        CGRect rect = imageView.frame;
//        rect.size.width = immagine.size.width;
//        rect.size.height = immagine.size.height;
//        rect.origin.x = self.scrollView.frame.size.height * i + cx;
//        rect.origin.y = 0;
//        
//        imageView.frame = rect;
//        
//        [self.scrollView addSubview:imageView];
//        //[imageView release];
//        
//        cx += imageView.frame.size.width;
//    }
    
//    self.pageControl.numberOfPages = 4;
//    self.pageControl.currentPage = 0;
//    [self.scrollView setContentSize:CGSizeMake(cx, [self.scrollView bounds].size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pageControlIsChangingPage)
    {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlIsChangingPage = NO;
}

- (IBAction)combinePagine:(id)sender
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlIsChangingPage = YES;
}


@end
