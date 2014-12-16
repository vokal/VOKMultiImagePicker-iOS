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
#import "VOKSelectedAssetManager.h"

@interface VOKAssetCollectionsViewController () <VOKAssetCollectionsDataSourceDelegate>

@property (nonatomic, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic) VOKAssetCollectionsDataSource *dataSource;

@end

@implementation VOKAssetCollectionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // If it wasn't set in a nib/storyboard: initialize and configure the
    // table view, then add to the main view
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];

        // Add constraints to make the table view fill the main view
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *layoutViews = @{ @"tableView": self.tableView };
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:layoutViews]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:layoutViews]];
    }

    // Setup the data source and other config
    self.dataSource = [[VOKAssetCollectionsDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
    self.title = [NSString vok_selectAnAlbum];
}

#pragma mark - VOKAssetCollectionsDataSourceDelegate

- (void)assetCollectionsDataSource:(VOKAssetCollectionsDataSource *)dataSource selectedAssetCollection:(PHAssetCollection *)assetCollection
{
    PHFetchResult *fetchResult = [PHFetchResult vok_fetchResultWithAssetCollection:assetCollection mediaType:[VOKSelectedAssetManager sharedManager].mediaType];
    VOKAssetsViewController *assetsViewController = [[VOKAssetsViewController alloc] initWithFetchResult:fetchResult];
    assetsViewController.title = assetCollection.localizedTitle;
    [self.navigationController pushViewController:assetsViewController animated:YES];
}

@end
