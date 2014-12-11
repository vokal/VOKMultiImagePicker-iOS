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

/**
 *  Initializes to show only the specific media type sent in in subsequent asset views.
 *
 *  @param mediaType The media type to show.
 *
 *  @return An instance of an asset collection view controller.
 */
- (instancetype)initWithMediaType:(PHAssetMediaType)mediaType;

@end
