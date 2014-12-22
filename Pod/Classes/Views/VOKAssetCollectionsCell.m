//
//  VOKAssetCollectionsCell.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/22/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetCollectionsCell.h"

NSString *const VOKAssetCollectionsCellReuseIdentifier = @"VOKAlbumDataSourceCellReuseIdentifier";

@implementation VOKAssetCollectionsCell

static CGFloat const VOKAssetCollectionCellRowHeight = 60.0f;
static CGFloat const VOKAssetCollectionCellImageMargin = 5.0f;

- (instancetype)init
{
    if (self = [super init]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(VOKAssetCollectionCellImageMargin,
                                      VOKAssetCollectionCellImageMargin,
                                      VOKAssetCollectionCellRowHeight - 2 * VOKAssetCollectionCellImageMargin,
                                      VOKAssetCollectionCellRowHeight - 2 * VOKAssetCollectionCellImageMargin);
}

+ (CGFloat)height
{
    return VOKAssetCollectionCellRowHeight;
}

@end
