//
//  VOKAssetsDataSource.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import Foundation;

@import Photos;

@interface VOKAssetsDataSource : NSObject

/**
 *  Tell the data source when it is ok to start caching. This is mostly
 *  for caching purposes to make sure the view has layed out the proper
 *  size to calculate the size of images that should be cached based on
 *  columns.
 */
@property (nonatomic) BOOL shouldCache;

/**
 *  Initialize an assets data source to display in a specific collection view with specific results.
 *
 *  @param collectionView The collection view to display the information into.
 *  @param fetchResult    The fetch result of the assets that will be displayed.
 *
 *  @return An instance of an asset data source connected to the specified collection view with the
 *          specified fetched results.
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView fetchResult:(PHFetchResult *)fetchResult;

@end
