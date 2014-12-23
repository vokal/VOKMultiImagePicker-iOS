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
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
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
