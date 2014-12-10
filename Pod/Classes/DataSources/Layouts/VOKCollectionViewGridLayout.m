//
//  VOKCollectionViewGridLayout.m
//  VOKMultiImagePicker
//
//  Created by Brock Boland on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKCollectionViewGridLayout.h"

const NSUInteger VOKCollectionViewGridLayoutDefaultColumns = 3;

@implementation VOKCollectionViewGridLayout

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (!(self.numberOfColumns > 0)) {
        self.numberOfColumns = VOKCollectionViewGridLayoutDefaultColumns;
    }
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
