//
//  BadgeCollectionLayout.m
//  wakeup
//
//  Created by din1030 on 13/6/2.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "BadgeCollectionLayout.h"

//static NSUInteger const RotationCount = 32;
//static NSUInteger const RotationStride = 3;
//static NSUInteger const PhotoCellBaseZIndex = 100;

static NSString * const BHPhotoAlbumLayoutPhotoCellKind = @"mission_cell";
NSString * const BHPhotoAlbumLayoutAlbumTitleKind = @"AlbumTitle";

@interface BadgeCollectionLayout ()

@property (nonatomic, strong) NSDictionary *layoutInfo;
@property (nonatomic, strong) NSArray *rotations;

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath;
- (CGRect)frameForAlbumTitleAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BadgeCollectionLayout

#pragma mark - Properties

- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize
{
    if (CGSizeEqualToSize(_itemSize, itemSize)) return;
    
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
    if (_numberOfColumns == numberOfColumns) return;
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}

- (void)setTitleHeight:(CGFloat)titleHeight
{
    if (_titleHeight == titleHeight) return;
    
    _titleHeight = titleHeight;
    
    [self invalidateLayout];
}


#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(10.0f, 10.0f, 5.0f, 10.0f);
    self.itemSize = CGSizeMake(80.0f, 80.0f);
    self.interItemSpacingY = 20.0f;
    self.numberOfColumns = 3;
    self.titleHeight = 26.0f;
}


#pragma mark - Layout

- (void)prepareLayout
{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *titleLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = CGRectMake(10* (item+1) + (item %3)* self.itemSize.width , 10*(item+1) + ((floor(item / 3)))* self.itemSize.height, self.itemSize.width, self.itemSize.height);
            //[self frameForAlbumPhotoAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
            
            if (indexPath.item == 0) {
                UICollectionViewLayoutAttributes *titleAttributes =
                [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:BHPhotoAlbumLayoutAlbumTitleKind withIndexPath:indexPath];
                titleAttributes.frame = [self frameForAlbumTitleAtIndexPath:indexPath];
                
                titleLayoutInfo[indexPath] = titleAttributes;
            }
        }
    }
    
    newLayoutInfo[BHPhotoAlbumLayoutPhotoCellKind] = cellLayoutInfo;
    newLayoutInfo[BHPhotoAlbumLayoutAlbumTitleKind] = titleLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

- (CGSize)collectionViewContentSize
{
    NSInteger rowCount = [self.collectionView numberOfItemsInSection:0] / 2;
    // make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfItemsInSection:0] % 2) rowCount++;
    
    CGFloat height = self.itemInsets.top +
    rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    rowCount * self.titleHeight +
    self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier, NSDictionary *elementsInfo, BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[BHPhotoAlbumLayoutPhotoCellKind][indexPath];
}


#pragma mark - Private

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row / 2;
    

    NSInteger column = indexPath.row % 5;
    
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (column * self.itemSize.width);
    
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    
    CGFloat originY = floor(self.itemInsets.top +
                            (self.itemSize.height + self.titleHeight + self.interItemSpacingY) * row);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

- (CGRect)frameForAlbumTitleAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
    frame.origin.y += frame.size.height;
    frame.size.height = self.titleHeight;
    
    return frame;
}



@end
