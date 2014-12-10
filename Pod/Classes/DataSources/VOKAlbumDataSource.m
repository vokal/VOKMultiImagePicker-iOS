//
//  VOKAlbumDataSource.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAlbumDataSource.h"

@import Photos;

@interface VOKAlbumDataSource () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) PHFetchResult *albums;

@end

@implementation VOKAlbumDataSource

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
                _albums = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
                NSLog(@"%@", @(self.albums.count));
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }
        }];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VOKAlbumDataSourceCellReuseIdentifier forIndexPath:indexPath];
    
    //Get first image
    PHAssetCollection *collection = self.albums[indexPath.row];
    PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    if (assets.count) {
        PHAsset *asset = assets[0];
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:CGSizeMake(80, 80)
                                                  contentMode:PHImageContentModeAspectFit
                                                      options:nil
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    cell.imageView.image = result;
                                                    [cell layoutSubviews];
                                                }];
    }
    
    //Get album name
    if (collection.localizedLocationNames.count) {
        cell.textLabel.text = collection.localizedLocationNames[0];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
