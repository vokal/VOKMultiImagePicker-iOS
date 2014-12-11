//
//  VOKSelectedAssetManager.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/11/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKSelectedAssetManager.h"

#import "VOKAssetCollectionViewCell.h"
#import "VOKMultiImagePickerConstants.h"

@interface VOKSelectedAssetManager ()

@property (nonatomic) NSMutableArray *selectedAssetsMutableArray;

@end

@implementation VOKSelectedAssetManager

+ (instancetype)sharedManager
{
    static VOKSelectedAssetManager *SharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedManager = [[self alloc] init];
    });
    
    return SharedManager;
}

- (void)resetManager
{
    self.selectedAssetsMutableArray = [NSMutableArray array];
    self.mediaType = PHAssetMediaTypeUnknown;
    self.assetCollectionViewCellClass = [VOKAssetCollectionViewCell class];
}

- (Class)assetCollectionViewCellClass
{
    if (!_assetCollectionViewCellClass) {
        _assetCollectionViewCellClass = [VOKAssetCollectionViewCell class];
    }
    return _assetCollectionViewCellClass;
}

- (BOOL)addSelectedAsset:(PHAsset *)asset
{
    if ([self assetIsInMediaType:asset]) {
        if (![self.selectedAssetsMutableArray containsObject:asset]) {
            [self.selectedAssetsMutableArray addObject:asset];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VOKMultiImagePickerNotifications.assetsChanged object:asset];
        return YES;
    }
    return NO;
}

- (void)removeSelectedAsset:(PHAsset *)asset
{
    [self.selectedAssetsMutableArray removeObject:asset];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:VOKMultiImagePickerNotifications.assetsChanged object:asset];
}

- (NSArray *)selectedAssets
{
    return [self.selectedAssetsArray copy];
}

- (NSMutableArray *)selectedAssetsArray
{
    if (!_selectedAssetsMutableArray) {
        _selectedAssetsMutableArray = [NSMutableArray array];
    }
    return _selectedAssetsMutableArray;
}

#pragma mark - Helpers

- (BOOL)assetIsInMediaType:(PHAsset *)asset;
{
    if (self.mediaType == PHAssetMediaTypeUnknown) {
        return YES;
    } else if (asset.mediaType == self.mediaType) {
        return YES;
    }
    return NO;
}

@end
