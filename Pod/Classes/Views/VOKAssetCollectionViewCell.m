//
//  VOKAssetCollectionViewCell.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetCollectionViewCell.h"

@interface VOKAssetCollectionViewCell ()

@property (nonatomic) UIView *shadeView;

@end

@implementation VOKAssetCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        [self.contentView addSubview:self.shadeView];
    } else {
        [self.shadeView removeFromSuperview];
    }
}

- (UIView *)shadeView
{
    if (!_shadeView) {
        _shadeView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _shadeView.backgroundColor = [UIColor blackColor];
        _shadeView.alpha = 0.4f;
    }
    return _shadeView;
}

@end
