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


NS_ASSUME_NONNULL_BEGIN

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
 *  The media type that can only be added to the selected asssets list.
 */
@property (nonatomic) PHAssetMediaType mediaType;

/**
 *  The class used to display assets with.
 *  You can subclass VOKAssetCollectionViewCell.
 */
@property (nullable, nonatomic) Class assetCollectionViewCellClass;

/**
 *  The number of columns in the asset collection view grid.
 */
@property (nonatomic) NSInteger assetCollectionViewColumnCount;

/**
 *  Enforces a maximum number of assets which can be selected if set to anything other than 0.
 *  Defaults to 0.
 */
@property (nonatomic) NSUInteger maxNumberOfAssets;

/**
 *  Adds an asset to the selected assets array IF it matches the media type.
 *
 *  @param asset The asset to add.
 *
 *  @return YES if it was added, NO if it wasn't.
 */
- (BOOL)addSelectedAsset:(PHAsset *)asset;

/**
 *  Removes an asset from the selected assets array.
 *
 *  @param asset The asset to remove.
 */
- (void)removeSelectedAsset:(PHAsset *)asset;

/**
 *  @return A list of all the assets that were added as selected.
 */
- (NSArray<PHAsset *> *)selectedAssets;

@end

NS_ASSUME_NONNULL_END
