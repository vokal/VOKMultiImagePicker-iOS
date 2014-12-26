//
//  VOKAssetCollectionsDataSource.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetCollectionsDataSource.h"

#import "VOKAssetCollectionsCell.h"
#import "VOKSelectedAssetManager.h"
#import "PHFetchResult+VOK.h"

@interface VOKAssetCollectionsDataSource () <PHPhotoLibraryChangeObserver, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *collectionFetchResults;
@property (nonatomic) NSArray *collectionArrays;

@end

@implementation VOKAssetCollectionsDataSource

NS_ENUM(NSInteger, VOKAlbumDataSourceType) {
    VOKAlbumDataSourceTypeAlbums = 0,
    VOKAlbumDataSourceTypeTopLevelUserCollections,
    
    VOKAlbumDataSourceTypeCount
};

- (instancetype)initWithTableView:(UITableView *)tableView
{
    if (self = [super init]) {
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = [VOKAssetCollectionsCell height];
        
        [_tableView registerClass:[VOKAssetCollectionsCell class] forCellReuseIdentifier:VOKAssetCollectionsCellReuseIdentifier];
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                //This doesn't seem to work because they all return NSNotFound for estimatedAssetCount. Had to enumerate through them below.
                //PHFetchOptions *fetchOptions = [PHFetchOptions new];
                //fetchOptions.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0 AND estimatedAssetCount < %@", @(NSNotFound)];
                PHFetchResult *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                                 subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                                 options:nil];
                
                //Fetch top level user collections
                PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
                
                _collectionFetchResults = @[albums, topLevelUserCollections];
                
                [self updateCollectionArrays];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView reloadData];
                });
                
                [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
            } else {
                //TODO: Handle no access.
            }
        }];
    }
    return self;
}

- (void)updateCollectionArrays
{
    PHFetchResult *albums = self.collectionFetchResults[VOKAlbumDataSourceTypeAlbums];
    NSMutableArray *albumsWithAssetsArray = [NSMutableArray arrayWithCapacity:albums.count];
    [albums enumerateObjectsUsingBlock:^(PHAssetCollection *obj, NSUInteger idx, BOOL *stop) {
        PHFetchResult *assetsInCollection = [PHFetchResult vok_fetchResultWithAssetCollection:obj mediaType:[VOKSelectedAssetManager sharedManager].mediaType];
        if (assetsInCollection.count > 0 && assetsInCollection.count < NSNotFound) {
            [albumsWithAssetsArray addObject:obj];
        }
    }];
    
    PHFetchResult *topLevelUserCollections = self.collectionFetchResults[VOKAlbumDataSourceTypeTopLevelUserCollections];
    NSMutableArray *topLevelUserCollectionsWithAssetsArray = [NSMutableArray arrayWithCapacity:topLevelUserCollections.count];
    [topLevelUserCollectionsWithAssetsArray enumerateObjectsUsingBlock:^(PHAssetCollection *obj, NSUInteger idx, BOOL *stop) {
        PHFetchResult *assetsInCollection = [PHFetchResult vok_fetchResultWithAssetCollection:obj mediaType:[VOKSelectedAssetManager sharedManager].mediaType];
        if (assetsInCollection.count > 0 && assetsInCollection.count < NSNotFound) {
            [topLevelUserCollectionsWithAssetsArray addObject:obj];
        }
    }];
    
    self.collectionArrays = @[albumsWithAssetsArray, topLevelUserCollectionsWithAssetsArray];
}

- (void)dealloc
{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (PHAssetCollection *)assetCollectionForIndexPath:(NSIndexPath *)indexPath
{
    NSArray *fetchResults = self.collectionArrays[indexPath.section];
    return fetchResults[indexPath.row];
}

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    // Call might come on any background queue. Re-dispatch to the main queue to handle it.
    dispatch_block_t dispatchBlock = ^{
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
            [self updateCollectionArrays];
            [self.tableView reloadData];
        }
    };
    
    if ([NSThread currentThread] != [NSThread mainThread]) {
        dispatch_async(dispatch_get_main_queue(), dispatchBlock);
    } else {
        dispatchBlock();
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PHFetchResult *fetchResult = self.collectionArrays[section];
    return fetchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VOKAssetCollectionsCell *cell = [tableView dequeueReusableCellWithIdentifier:VOKAssetCollectionsCellReuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = nil;
    
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
    if (collection.estimatedAssetCount == NSNotFound) {
        cell.detailTextLabel.text = nil;
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(collection.estimatedAssetCount)];
    }
    
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
