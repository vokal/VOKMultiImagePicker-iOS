//
//  VOKSelectedAssetManager.h
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/11/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//
//  This is singleton object that holds references to
//  selected assets.
//

@import Foundation;

@import Photos;

@interface VOKSelectedAssetManager : NSObject

/**
 *  @return Shared instance containing a reference to selected assets.
 */
+ (instancetype)sharedManager;

/**
 *  Resets the singleton manager to use again.
 */
- (void)resetManager;

/**
 *  Adds an asset to the selected assets array.
 *
 *  @param asset The asset to add.
 */
- (void)addSelectedAsset:(PHAsset *)asset;

/**
 *  Removes an asset from the selected assets array.
 *
 *  @param asset The asset to remove.
 */
- (void)removeSelectedAsset:(PHAsset *)asset;

/**
 *  @return A list of all the assets that were added as selected.
 */
- (NSArray *)selectedAssets;


@end
