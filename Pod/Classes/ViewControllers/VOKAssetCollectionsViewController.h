//
//  VOKAssetCollectionsViewController.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKBaseViewController.h"

@import Photos;

@interface VOKAssetCollectionsViewController : VOKBaseViewController

- (instancetype)initWithMediaType:(PHAssetMediaType)mediaType;

@end
