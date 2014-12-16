//
//  VOKAssetsViewController.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetsViewController.h"

#import "VOKAssetsDataSource.h"
#import "VOKCollectionViewGridLayout.h"

@interface VOKAssetsViewController ()

@property (nonatomic, readwrite) UICollectionView *collectionView;
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

    // Initialize and configure the collection view, then add it as a subview
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                             collectionViewLayout:[[VOKCollectionViewGridLayout alloc] init]];
    // Use a white background by default. If this isn't set, the background appears black.
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.allowsMultipleSelection = YES;

    [self.view addSubview:self.collectionView];

    // Add constraints to make the collection view fill the main view
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *layoutViews = @{ @"collectionView": self.collectionView };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:layoutViews]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:layoutViews]];

    // Setup the data source for the collection view
    self.dataSource = [[VOKAssetsDataSource alloc] initWithCollectionView:self.collectionView fetchResult:self.fetchResult];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.dataSource.shouldCache = YES;
}

@end
