//
//  VOKAssetsDataSource.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetsDataSource.h"

@interface VOKAssetsDataSource () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) PHAssetCollection *assetCollection;

@end

@implementation VOKAssetsDataSource

static NSString *const VOKAssetsDataSourceCellReuseIdentifier = @"VOKAssetsDataSourceCellReuseIdentifier";

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView assetCollection:(PHAssetCollection *)assetCollection
{
    if (self = [self init]) {
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _assetCollection = assetCollection;

    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetCollection.estimatedAssetCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VOKAssetsDataSourceCellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
