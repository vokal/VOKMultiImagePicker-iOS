//
//  VOKAssetsDataSource.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import Foundation;

@import Photos;

@class VOKAssetsDataSource;

@protocol VOKAssetsDataSourceDelegate <NSObject>

- (void)assetDataSource:(VOKAssetsDataSource *)dataSource selectedAsset:(PHAsset *)asset;
- (void)assetDataSource:(VOKAssetsDataSource *)dataSource deselectedAsset:(PHAsset *)asset;

@end

@interface VOKAssetsDataSource : NSObject

@property (nonatomic, weak) id<VOKAssetsDataSourceDelegate> delegate;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView fetchResult:(PHFetchResult *)fetchResult;

@end
