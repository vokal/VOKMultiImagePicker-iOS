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
@property (nonatomic) PHFetchResult *fetchResult;
@property (nonatomic) VOKAssetsDataSource *dataSource;

@end

@implementation VOKAssetsViewController

- (instancetype)initWithFetchResult:(PHFetchResult *)fetchResult
{
    if (self = [self init]) {
        _fetchResult = fetchResult;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.allowsMultipleSelection = YES;
    
    self.dataSource = [[VOKAssetsDataSource alloc] initWithCollectionView:self.collectionView fetchResult:self.fetchResult];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.dataSource.shouldCache = YES;
}

@end
