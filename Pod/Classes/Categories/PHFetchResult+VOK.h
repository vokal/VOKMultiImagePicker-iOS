//
//  PHFetchResult+VOK.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import Photos;

@interface PHFetchResult (VOK)

/**
 *  Returns a fetch result of all the assets of a specified type in a specified asset collection.
 *  Items are sorted by createdDate.
 *
 *  @param assetCollection The asset collection to pull assets from.
 *  @param type            The asset type to return from the asset collection and discard all else.
 *
 *  @return The fetch result of the assets requested sorted by createdDate.
 */
+ (instancetype)vok_fetchResultWithAssetCollection:(PHAssetCollection *)assetCollection mediaType:(PHAssetMediaType)type;

/**
 *  Returns a fetch result of all the assets of a specified type, sorted by createdDate.
 *
 *  @param type The asset type to return and discard all else.
 *
 *  @return The fetch result of the assets requested sorted by createdDate.
 */
+ (instancetype)vok_fetchResultWithAssetsOfType:(PHAssetMediaType)type;

@end
