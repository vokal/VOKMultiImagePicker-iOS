//
//  VOKAssetsDataSource.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetsDataSource.h"

#import "VOKAssetCollectionViewCell.h"

@interface VOKAssetsDataSource () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) PHFetchResult *results;

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
        
        [_collectionView registerClass:[VOKAssetCollectionViewCell class] forCellWithReuseIdentifier:VOKAssetsDataSourceCellReuseIdentifier];
        [_collectionView reloadData];
    }
    return self;
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
    
    cell.tag = indexPath.row;
    [[PHImageManager defaultManager] requestImageForAsset:asset
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
    [self.delegate assetDataSource:self deselectedAsset:asset];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = self.results[indexPath.row];
    [self.delegate assetDataSource:self selectedAsset:asset];
}

@end
