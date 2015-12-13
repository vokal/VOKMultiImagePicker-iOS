//
//  VOKCollectionViewGridLayout.h
//  VOKMultiImagePicker
//
//  Created by Brock Boland on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@import UIKit;

FOUNDATION_EXPORT NSUInteger const VOKCollectionViewGridLayoutDefaultColumns;

@interface VOKCollectionViewGridLayout : UICollectionViewFlowLayout

/**
 *  @return The size of the asset cells.
 */
- (CGSize)itemSize;

@end

NS_ASSUME_NONNULL_END
