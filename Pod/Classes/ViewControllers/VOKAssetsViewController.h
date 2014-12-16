//
//  VOKAssetsViewController.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKBaseViewController.h"

@import Photos;

@interface VOKAssetsViewController : VOKBaseViewController

@property (nonatomic, readonly) UICollectionView *collectionView;

/**
 *  Initializes an assets view controller with specific fetch results.
 *
 *  @param fetchResult The fetch result object needed to be displayed.
 *
 *  @return An instance of an assets view controller with specific fetch results.
 */
- (instancetype)initWithFetchResult:(PHFetchResult *)fetchResult;

@end
