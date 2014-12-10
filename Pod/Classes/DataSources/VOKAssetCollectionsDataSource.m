//
//  VOKAssetCollectionsDataSource.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetCollectionsDataSource.h"

@interface VOKAssetCollectionsDataSource () <PHPhotoLibraryChangeObserver, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *collectionFetchResults;

@end

@implementation VOKAssetCollectionsDataSource

NS_ENUM(NSInteger, VOKAlbumDataSourceType) {
    VOKAlbumDataSourceTypeAlbums = 0,
    VOKAlbumDataSourceTypeTopLevelUserCollections,
    
    VOKAlbumDataSourceTypeCount
};

static NSString *const VOKAlbumDataSourceCellReuseIdentifier = @"VOKAlbumDataSourceCellReuseIdentifier";

- (instancetype)initWithTableView:(UITableView *)tableView
{
    if (self = [super init]) {
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:VOKAlbumDataSourceCellReuseIdentifier];
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                PHFetchOptions *fetchOptions = [PHFetchOptions new];
                //fetchOptions.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
                PHFetchResult *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                                 subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                                 options:fetchOptions];
                
                PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
                
                _collectionFetchResults = @[albums, topLevelUserCollections];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView reloadData];
                });
                
                [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
            }
        }];
    }
    return self;
}

- (void)dealloc
{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (PHAssetCollection *)assetCollectionForIndexPath:(NSIndexPath *)indexPath
{
    PHFetchResult *fetchResult = self.collectionFetchResults[indexPath.section];
    return fetchResult[indexPath.row];
}

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    // Call might come on any background queue. Re-dispatch to the main queue to handle it.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *updatedCollectionsFetchResults = nil;
        
        for (PHFetchResult *collectionsFetchResult in self.collectionFetchResults) {
            PHFetchResultChangeDetails *changeDetails = [changeInstance changeDetailsForFetchResult:collectionsFetchResult];
            if (changeDetails) {
                if (!updatedCollectionsFetchResults) {
                    updatedCollectionsFetchResults = [self.collectionFetchResults mutableCopy];
                }
                [updatedCollectionsFetchResults replaceObjectAtIndex:[self.collectionFetchResults indexOfObject:collectionsFetchResult] withObject:[changeDetails fetchResultAfterChanges]];
            }
        }
        
        if (updatedCollectionsFetchResults) {
            self.collectionFetchResults = updatedCollectionsFetchResults;
            [self.tableView reloadData];
        }
        
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PHFetchResult *fetchResult = self.collectionFetchResults[section];
    return fetchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VOKAlbumDataSourceCellReuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    PHAssetCollection *collection = [self assetCollectionForIndexPath:indexPath];
    
    //Get last image
    PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    if (assets.lastObject) {
        PHAsset *asset = assets.lastObject;
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:CGSizeMake(self.tableView.rowHeight, self.tableView.rowHeight)
                                                  contentMode:PHImageContentModeAspectFill
                                                      options:nil
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    cell.imageView.image = result;
                                                    [cell layoutSubviews];
                                                }];
    }
    
    //Get album name
    cell.textLabel.text = collection.localizedTitle;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return VOKAlbumDataSourceTypeCount;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PHAssetCollection *assetCollection = [self assetCollectionForIndexPath:indexPath];
    [self.delegate assetCollectionsDataSource:self selectedAssetCollection:assetCollection];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
