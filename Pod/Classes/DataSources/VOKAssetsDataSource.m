//
//  VOKAssetsDataSource.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetsDataSource.h"

#import "NSIndexSet+VOK.h"
#import "UICollectionView+VOK.h"
#import "VOKAssetCollectionViewCell.h"
#import "VOKCollectionViewGridLayout.h"
#import "VOKSelectedAssetManager.h"

@interface VOKAssetsDataSource () <PHPhotoLibraryChangeObserver, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) PHCachingImageManager *imageManager;
@property (nonatomic) PHFetchResult *results;
@property (nonatomic) CGRect previousPreheatRect;

@end

@implementation VOKAssetsDataSource

static NSString *const VOKAssetsDataSourceCellReuseIdentifier = @"VOKAssetsDataSourceCellReuseIdentifier";

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView fetchResult:(PHFetchResult *)fetchResult
{
    if (self = [self init]) {
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _results = fetchResult;
        
        _imageManager = [[PHCachingImageManager alloc] init];
        [self resetCachedAssets];
        
        [_collectionView registerClass:[VOKSelectedAssetManager sharedManager].assetCollectionViewCellClass forCellWithReuseIdentifier:VOKAssetsDataSourceCellReuseIdentifier];
        [_collectionView reloadData];
        
        [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    }
    return self;
}

- (void)dealloc
{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

#pragma mark - Asset Caching

- (void)resetCachedAssets
{
    [self.imageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets
{
    if (!self.shouldCache) {
        return;
    }
    
    // The preheat window is twice the height of the visible rect
    CGRect preheatRect = self.collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    // If scrolled by a "reasonable" amount...
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(self.collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect
                                   andRect:preheatRect
                            removedHandler:^(CGRect removedRect) {
                                NSArray *indexPaths = [self.collectionView vok_indexPathsForElementsInRect:removedRect];
                                [removedIndexPaths addObjectsFromArray:indexPaths];
                            } addedHandler:^(CGRect addedRect) {
                                NSArray *indexPaths = [self.collectionView vok_indexPathsForElementsInRect:addedRect];
                                [addedIndexPaths addObjectsFromArray:indexPaths];
                            }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        
        CGSize itemSize = [(VOKCollectionViewGridLayout *)self.collectionView.collectionViewLayout itemSize];
        [self.imageManager startCachingImagesForAssets:assetsToStartCaching
                                            targetSize:itemSize
                                           contentMode:PHImageContentModeAspectFill
                                               options:nil];
        [self.imageManager stopCachingImagesForAssets:assetsToStopCaching
                                           targetSize:itemSize
                                          contentMode:PHImageContentModeAspectFill
                                              options:nil];
        
        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect
                             andRect:(CGRect)newRect
                      removedHandler:(void (^)(CGRect removedRect))removedHandler
                        addedHandler:(void (^)(CGRect addedRect))addedHandler
{
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths
{
    if (indexPaths.count == 0) {
        return nil;
    }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        PHAsset *asset = self.results[indexPath.item];
        [assets addObject:asset];
    }
    return assets;
}

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    // Call might come on any background queue. Re-dispatch to the main queue to handle it.
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // check if there are changes to the assets (insertions, deletions, updates)
        PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:self.results];
        if (collectionChanges) {
            
            // get the new fetch result
            self.results = [collectionChanges fetchResultAfterChanges];
            
            UICollectionView *collectionView = self.collectionView;
            
            if (![collectionChanges hasIncrementalChanges] || [collectionChanges hasMoves]) {
                // we need to reload all if the incremental diffs are not available
                [collectionView reloadData];
                
            } else {
                // if we have incremental diffs, tell the collection view to animate insertions and deletions
                [collectionView performBatchUpdates:^{
                    NSIndexSet *removedIndexes = [collectionChanges removedIndexes];
                    if ([removedIndexes count]) {
                        [collectionView deleteItemsAtIndexPaths:[removedIndexes vok_indexPathsFromIndexesWithSection:0]];
                    }
                    NSIndexSet *insertedIndexes = [collectionChanges insertedIndexes];
                    if ([insertedIndexes count]) {
                        [collectionView insertItemsAtIndexPaths:[insertedIndexes vok_indexPathsFromIndexesWithSection:0]];
                    }
                    NSIndexSet *changedIndexes = [collectionChanges changedIndexes];
                    if ([changedIndexes count]) {
                        [collectionView reloadItemsAtIndexPaths:[changedIndexes vok_indexPathsFromIndexesWithSection:0]];
                    }
                } completion:NULL];
            }
            
            [self resetCachedAssets];
        }
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateCachedAssets];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.results.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VOKAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VOKAssetsDataSourceCellReuseIdentifier forIndexPath:indexPath];
    
    PHAsset *asset = self.results[indexPath.row];
    
    UICollectionViewLayoutAttributes *cellAttributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    
    if ([[VOKSelectedAssetManager sharedManager].selectedAssets containsObject:asset]) {
        cell.selected = YES;
        [collectionView selectItemAtIndexPath:indexPath
                                     animated:NO
                               scrollPosition:UICollectionViewScrollPositionNone];
    } else {
        cell.selected = NO;
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    
    cell.tag = indexPath.row;
    [self.imageManager requestImageForAsset:asset
                                 targetSize:cellAttributes.size
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  if (cell.tag == indexPath.row) {
                                      //If the cell hasn't been reused by another indexPath (tag) then we set the image.
                                      cell.imageView.image = result;
                                  }
                              }];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = self.results[indexPath.row];
    [[VOKSelectedAssetManager sharedManager] removeSelectedAsset:asset];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = self.results[indexPath.row];
    if (![[VOKSelectedAssetManager sharedManager] addSelectedAsset:asset]) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.selected  = NO;
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
    }
}

@end
