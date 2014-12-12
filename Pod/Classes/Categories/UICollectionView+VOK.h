//
//  UICollectionView+VOK.h
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/11/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import UIKit;

@interface UICollectionView (VOK)

/**
 *  Returns NSIndexPaths for the items that are in a certain rect.
 *
 *  @param rect The rect to find index paths in.
 *
 *  @return An array of NSIndexPaths of elements in the specified rect.
 */
- (NSArray *)vok_indexPathsForElementsInRect:(CGRect)rect;

@end
