//
//  BadgeCollectionLayout.h
//  wakeup
//
//  Created by din1030 on 13/6/2.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeCollectionLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) CGFloat titleHeight;

@end
