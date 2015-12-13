//
//  VOKAssetCollectionsDataSource.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@import Foundation;
@import Photos;

@class VOKAssetCollectionsDataSource;

@protocol VOKAssetCollectionsDataSourceDelegate <NSObject>

/**
 *  Delegate selector called when a user selects an asset collection in the table.
 *
 *  @param dataSource      The data source that was accessed.
 *  @param assetCollection The asset collection that was selected.
 */
- (void)assetCollectionsDataSource:(VOKAssetCollectionsDataSource *)dataSource selectedAssetCollection:(PHAssetCollection *)assetCollection;

@end

@interface VOKAssetCollectionsDataSource : NSObject

@property (nullable, nonatomic, weak) id<VOKAssetCollectionsDataSourceDelegate> delegate;

/**
 *  Initializes to use the table view sent in for displaying information.
 *
 *  @param tableView The table view that will display the information from the data source.
 *
 *  @return The instance of the data source that has been created.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
