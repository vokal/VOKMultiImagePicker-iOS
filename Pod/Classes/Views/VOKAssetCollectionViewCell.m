//
//  VOKAssetCollectionViewCell.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAssetCollectionViewCell.h"

@interface VOKAssetCollectionViewCell ()

@property (nonatomic) UIImageView *checkmarkImageView;
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
        [self.contentView addSubview:self.checkmarkImageView];
    } else {
        [self.shadeView removeFromSuperview];
        [self.checkmarkImageView removeFromSuperview];
    }
}

- (UIImageView *)checkmarkImageView
{
    if (!_checkmarkImageView) {
        _checkmarkImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _checkmarkImageView.image = [UIImage imageNamed:@""];
    }
    return _checkmarkImageView;
}

- (UIView *)shadeView
{
    if (!_shadeView) {
        _shadeView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _shadeView.backgroundColor = [UIColor blackColor];
        _shadeView.alpha = 0.6f;
    }
    return _shadeView;
}

@end
