//
//  VOKAssetCollectionsViewController.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@import Photos;

@interface VOKAssetCollectionsViewController : VOKBaseViewController

@property (nonatomic, readonly) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
