//
//  VOKCollectionViewGridLayout.h
//  VOKMultiImagePicker
//
//  Created by Brock Boland on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import UIKit;

FOUNDATION_EXPORT NSUInteger const VOKCollectionViewGridLayoutDefaultColumns;

@interface VOKCollectionViewGridLayout : UICollectionViewFlowLayout

/**
 *  Set number of columns to appear in the grid view.
 */
@property (nonatomic) IBInspectable NSUInteger numberOfColumns;

/**
 *  @return The size of the asset cells.
 */
- (CGSize)itemSize;

@end
