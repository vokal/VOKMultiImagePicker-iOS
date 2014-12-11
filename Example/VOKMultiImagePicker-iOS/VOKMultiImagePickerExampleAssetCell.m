//
//  VOKMultiImagePickerExampleAssetCell.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/11/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKMultiImagePickerExampleAssetCell.h"

@interface VOKMultiImagePickerExampleAssetCell ()

@property (nonatomic) UIImageView *checkmarkImageView;

@end

@implementation VOKMultiImagePickerExampleAssetCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        [self.contentView addSubview:self.checkmarkImageView];
    } else {
        [self.checkmarkImageView removeFromSuperview];
    }
}

- (UIImageView *)checkmarkImageView
{
    if (!_checkmarkImageView) {
        _checkmarkImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _checkmarkImageView.image = [UIImage imageNamed:@"Checkmark"];
    }
    return _checkmarkImageView;
}

@end
