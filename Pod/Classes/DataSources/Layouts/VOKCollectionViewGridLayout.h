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
 *  @return The size of the asset cells.
 */
- (CGSize)itemSize;

@end
