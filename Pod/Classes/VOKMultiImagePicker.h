//
//  VOKMultiImagePicker.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import UIKit;

@import Photos;

/**
 *  What's the first thing we want the user to see when the
 *  mult image picker is displayed to them?
 */
NS_ENUM(NSInteger, VOKMultiImagePickerStartPosition){
    /**
     *  The user should see albums first when the picker is displayed.
     */
    VOKMultiImagePickerStartPositionAlbums,
    /**
     *  The user should see their camera roll when the picker is displayed.
     */
    VOKMultiImagePickerStartPositionCameraRoll,
};

/**
 *  The protocol your code should handle to receive the assets selected
 *  within the multi image picker.
 */
@protocol VOKMultiImagePickerDelegate <NSObject>
/**
 *  When the user finishes selecting images the assets are returned in
 *  this method call.
 *
 *  @param assets An array of PHAsset objects that the user selected.
 */
- (void)multiImagePickerSelectedAssets:(NSArray *)assets;
@end

@interface VOKMultiImagePicker : UIViewController

/**
 *  The object that will retrieve the selected objects once finished.
 */
@property (nonatomic, weak) id<VOKMultiImagePickerDelegate> imageDelegate;

/**
 *  The button the user will select to finish selecting assets.
 *  This button can be customized.
 */
@property (nonatomic, weak) IBOutlet UIButton *addItemsButton;

/**
 *  The media type of assets to display. All other assets will not
 *  be shown.
 *
 *  PHAssetMediaTypeUnknown - Will just display all.
 *  PHAssetMediaTypeImage - Will display just images.
 *  PHAssetMediaTypeVideo - Will display just videos.
 *  PHAssetMediaTypeAudio - Will display just audio items.
 */
@property (nonatomic) PHAssetMediaType mediaType;

/**
 *  Set the start position the user will see first once the image picker
 *  is displayed on screen.
 */
@property (nonatomic) enum VOKMultiImagePickerStartPosition startPosition;

/**
 *  The class used to display assets with.
 *  You can subclass VOKAssetCollectionViewCell.
 *  Default is VOKAssetCollectionViewCell.
 */
@property (nonatomic) Class assetCollectionViewCellClass;

@end
