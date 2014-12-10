//
//  VOKAssetsViewController.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetsViewController.h"

#import "VOKAssetsDataSource.h"

@interface VOKAssetsViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PHAssetCollection *assetCollection;
@property (nonatomic) VOKAssetsDataSource *dataSource;

@end

@implementation VOKAssetsViewController

- (instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection
{
    if (self = [super init]) {
        _assetCollection = assetCollection;
        self.title = _assetCollection.localizedTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[VOKAssetsDataSource alloc] initWithCollectionView:self.collectionView assetCollection:self.assetCollection];
}

@end
