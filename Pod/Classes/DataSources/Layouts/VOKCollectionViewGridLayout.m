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

@implementation VOKCollectionViewGridLayout

static CGFloat const VOKCollectionViewGridLayoutDefaultSpacing = 2.0f;

- (instancetype)init
{
    if (self = [super init]) {
        _numberOfColumns = [VOKSelectedAssetManager sharedManager].assetCollectionViewColumnCount;

        self.minimumInteritemSpacing = VOKCollectionViewGridLayoutDefaultSpacing;
        self.minimumLineSpacing = VOKCollectionViewGridLayoutDefaultSpacing;
    }
    return self;
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
