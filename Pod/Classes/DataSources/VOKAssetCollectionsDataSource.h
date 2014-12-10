//
//  VOKAssetCollectionsDataSource.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import Foundation;

@import Photos;

@class VOKAssetCollectionsDataSource;

@protocol VOKAssetCollectionsDataSourceDelegate <NSObject>

- (void)assetCollectionsDataSource:(VOKAssetCollectionsDataSource *)dataSource selectedAssetCollection:(PHAssetCollection *)assetCollection;

@end

@interface VOKAssetCollectionsDataSource : NSObject

@property (nonatomic, weak) id<VOKAssetCollectionsDataSourceDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end
