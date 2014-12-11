//
//  VOKAssetCollectionsViewController.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetCollectionsViewController.h"

#import "NSString+VOK.h"
#import "PHFetchResult+VOK.h"
#import "VOKAssetCollectionsDataSource.h"
#import "VOKAssetsViewController.h"

@interface VOKAssetCollectionsViewController () <VOKAssetCollectionsDataSourceDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) VOKAssetCollectionsDataSource *dataSource;
@property (nonatomic) PHAssetMediaType mediaType;

@end

@implementation VOKAssetCollectionsViewController

- (instancetype)initWithMediaType:(PHAssetMediaType)mediaType
{
    if (self = [self init]) {
        _mediaType = mediaType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[VOKAssetCollectionsDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
    
    self.title = [NSString vok_selectAnAlbum];
}

#pragma mark - VOKAssetCollectionsDataSourceDelegate

- (void)assetCollectionsDataSource:(VOKAssetCollectionsDataSource *)dataSource selectedAssetCollection:(PHAssetCollection *)assetCollection
{
    PHFetchResult *fetchResult = [PHFetchResult vok_fetchResultWithAssetCollection:assetCollection mediaType:self.mediaType];
    VOKAssetsViewController *assetsViewController = [[VOKAssetsViewController alloc] initWithFetchResult:fetchResult];
    assetsViewController.title = assetCollection.localizedTitle;
    [self.navigationController pushViewController:assetsViewController animated:YES];
}

@end
