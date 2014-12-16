//
//  VOKCollectionViewGridLayout.m
//  VOKMultiImagePicker
//
//  Created by Brock Boland on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKCollectionViewGridLayout.h"

#import "VOKSelectedAssetManager.h"

NSUInteger const VOKCollectionViewGridLayoutDefaultColumns = 3;

@interface VOKCollectionViewGridLayout ()

/**
 *  Set number of columns to appear in the grid view.
 */
@property (nonatomic) NSUInteger numberOfColumns;

@end

@implementation VOKCollectionViewGridLayout

static CGFloat const VOKCollectionViewGridLayoutDefaultSpacing = 2.0f;

- (instancetype)init
{
    if (self = [super init]) {
        [self setupDefaults];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupDefaults];
}

- (void)setupDefaults
{
    _numberOfColumns = [VOKSelectedAssetManager sharedManager].assetCollectionViewColumnCount;

    self.minimumInteritemSpacing = VOKCollectionViewGridLayoutDefaultSpacing;
    self.minimumLineSpacing = VOKCollectionViewGridLayoutDefaultSpacing;
}

- (CGSize)itemSize
{
    CGFloat totalWidth = CGRectGetWidth(self.collectionView.frame);
    // Account for padding
    totalWidth -= (self.minimumInteritemSpacing * (self.numberOfColumns - 1));
    // Divide for columns
    CGFloat cellDimension = totalWidth / self.numberOfColumns;
    return CGSizeMake(cellDimension, cellDimension);
}

@end
