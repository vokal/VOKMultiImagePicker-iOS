//
//  VOKMultiImagePicker.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import UIKit;

@import Photos;

NS_ENUM(NSInteger, VOKMultiImagePickerStartPosition) {
    VOKMultiImagePickerStartPositionAlbums,
    VOKMultiImagePickerStartPositionCameraRoll,
};

@protocol VOKMultiImagePickerDelegate <NSObject>

- (void)multiImagePickerSelectedAssets:(NSArray *)assets;

@end

@interface VOKMultiImagePicker : UIViewController

@property (nonatomic, weak) id<VOKMultiImagePickerDelegate> imageDelegate;
@property (nonatomic, weak) IBOutlet UIButton *addItemsButton;
@property (nonatomic) PHAssetMediaType mediaType;
@property (nonatomic) enum VOKMultiImagePickerStartPosition startPosition;

@end
