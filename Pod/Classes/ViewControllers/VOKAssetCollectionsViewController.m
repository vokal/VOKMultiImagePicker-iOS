//
//  VOKAssetCollectionsViewController.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetCollectionsViewController.h"

#import "VOKAssetCollectionsDataSource.h"
#import "VOKAssetsViewController.h"
#import "VOKMultiImagePickerLocalizedStrings.h"

@interface VOKAssetCollectionsViewController () <VOKAssetCollectionsDataSourceDelegate>

@property (nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) VOKAssetCollectionsDataSource *dataSource;

@end

@implementation VOKAssetCollectionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [VOKMultiImagePickerLocalizedStrings selectAnAlbum];
    
    self.dataSource = [[VOKAssetCollectionsDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
}

#pragma mark - VOKAssetCollectionsDataSourceDelegate

- (void)assetCollectionsDataSource:(VOKAssetCollectionsDataSource *)dataSource selectedAssetCollection:(PHAssetCollection *)assetCollection
{
    VOKAssetsViewController *assetsViewController = [[VOKAssetsViewController alloc] initWithAssetCollection:assetCollection];
    [self.navigationController pushViewController:assetsViewController animated:YES];
}

@end
