//
//  PHFetchResult+VOK.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "PHFetchResult+VOK.h"

@implementation PHFetchResult (VOK)

+ (instancetype)vok_fetchResultWithAssetCollection:(PHAssetCollection *)assetCollection mediaType:(PHAssetMediaType)type
{
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    
    if (type != PHAssetMediaTypeUnknown) {
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %@", @(type)];
    }
    
    fetchOptions.sortDescriptors = @[[self vok_creationDateSortDescriptor]];
    return [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
}

+ (instancetype)vok_fetchResultWithAssetsOfType:(PHAssetMediaType)type
{
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    fetchOptions.sortDescriptors = @[[self vok_creationDateSortDescriptor]];
    
    if (type != PHAssetMediaTypeUnknown) {
        return [PHAsset fetchAssetsWithMediaType:type options:fetchOptions];
    }
    return [PHAsset fetchAssetsWithOptions:fetchOptions];
}

+ (NSSortDescriptor *)vok_creationDateSortDescriptor
{
    return [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES];
}

@end
