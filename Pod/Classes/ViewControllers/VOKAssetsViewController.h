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

- (instancetype)initWithFetchResult:(PHFetchResult *)fetchResult;

@end
