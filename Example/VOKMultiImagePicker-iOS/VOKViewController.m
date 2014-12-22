//
//  VOKViewController.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/09/2014.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKViewController.h"

#import "VOKMultiImagePickerExampleAssetCell.h"
#import "VOKMultiImagePickerExampleDataSource.h"
#import "VOKMultiImagePickerExampleLocalizedStrings.h"

#import <VOKMultiImagePicker.h>
#import <NSString+VOK.h>
#import <UIImage+VOK.h>

@interface VOKViewController () <VOKMultiImagePickerExampleDataSourceDelegate, VOKMultiImagePickerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) VOKMultiImagePickerExampleDataSource *dataSource;

@end

@implementation VOKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[VOKMultiImagePickerExampleDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
}

#pragma mark - VOKMultiImagePickerExampleDataSourceDelegate

- (void)dataSource:(VOKMultiImagePickerExampleDataSource *)dataSource selectedRow:(NSInteger)row
{
    //Create the multi image picker.
    VOKMultiImagePicker *multiImagePicker = [[VOKMultiImagePicker alloc] init];
    multiImagePicker.imageDelegate = self;
    
    //Set options on the picker.
    switch (row) {
        case VOKMultiImagePickerExampleDataSourceRowPhotos: {
            multiImagePicker.mediaType = PHAssetMediaTypeImage;
            break;
        }
        case VOKMultiImagePickerExampleDataSourceRowVideos: {
            multiImagePicker.mediaType = PHAssetMediaTypeVideo;
            break;
        }
        case VOKMultiImagePickerExampleDataSourceRowBoth: {
            //No need to do anything here. Defaults to showing both images and
            //videos (as well as PHAssetMediaTypeUnknown and PHAssetMediaTypeAudio types).
            break;
        }
        case VOKMultiImagePickerExampleDataSourceRowPhotosInCameraRoll: {
            multiImagePicker.startPosition = VOKMultiImagePickerStartPositionCameraRoll;
            multiImagePicker.mediaType = PHAssetMediaTypeImage;
            break;
        }
        case VOKMultiImagePickerExampleDataSourceRowVideosInCameraRoll: {
            multiImagePicker.mediaType = PHAssetMediaTypeVideo;
            multiImagePicker.startPosition = VOKMultiImagePickerStartPositionCameraRoll;
            break;
        }
        case VOKMultiImagePickerExampleDataSourceRowUseCustomCollectionViewCell:
            //Put a check mark on the cell using a subclassed cell.
            multiImagePicker.startPosition = VOKMultiImagePickerStartPositionCameraRoll;
            multiImagePicker.assetCollectionViewCellClass = [VOKMultiImagePickerExampleAssetCell class];
            break;
        case VOKMultiImagePickerExampleDataSourceRowOneColumn:
            //Put a check mark on the cell using a subclassed cell.
            multiImagePicker.startPosition = VOKMultiImagePickerStartPositionCameraRoll;
            multiImagePicker.assetCollectionViewColumnCount = 1;
            break;
        case VOKMultiImagePickerExampleDataSourceRowFiveColumns:
            //Put a check mark on the cell using a subclassed cell.
            multiImagePicker.assetCollectionViewColumnCount = 5;
            multiImagePicker.startPosition = VOKMultiImagePickerStartPositionCameraRoll;
            break;
    }
    
    //Customize the add items button.
    CGSize imageSize = CGSizeMake(CGRectGetWidth(multiImagePicker.addItemsButton.frame), CGRectGetHeight(multiImagePicker.addItemsButton.frame));
    
    UIImage *enabledImage = [UIImage vok_imageOfColor:[UIColor redColor] size:imageSize];
    UIImage *disabledImage = [UIImage vok_imageOfColor:[UIColor lightGrayColor] size:imageSize];
    
    [multiImagePicker.addItemsButton setBackgroundImage:enabledImage forState:UIControlStateNormal];
    [multiImagePicker.addItemsButton setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    
    multiImagePicker.addItemsButton.titleLabel.font = [UIFont systemFontOfSize:30];
    
    [self.navigationController presentViewController:multiImagePicker
                                            animated:YES
                                          completion:nil];
}

#pragma mark - VOKMultiImagePickerDelegate

- (void)multiImagePicker:(VOKMultiImagePicker *)multiImagePicker selectedAssets:(NSArray *)assets
{
    //TODO: Show the selected assets in the example instead of logging.
    NSLog(@"%@", @(assets.count));
    for (PHAsset *asset in assets) {
        NSLog(@"%@", asset);
    }
}

- (NSString *)multiImagePicker:(VOKMultiImagePicker *)multiImagePicker addButtonLabelForItemCount:(NSUInteger)itemCount
{
    switch (multiImagePicker.mediaType) {
        case PHAssetMediaTypeUnknown:
            if (itemCount == 0) {
                return [NSString vok_addItems];
            } else if (itemCount == 1) {
                return [NSString vok_addOneItem];
            } else {
                return [NSString stringWithFormat:[NSString vok_addXItemsFormat], @(itemCount)];
            }
        case PHAssetMediaTypeImage:
            if (itemCount == 0) {
                return [VOKMultiImagePickerExampleLocalizedStrings vok_addImages];
            } else if (itemCount == 1) {
                return [VOKMultiImagePickerExampleLocalizedStrings vok_addOneImage];
            } else {
                return [NSString stringWithFormat:[VOKMultiImagePickerExampleLocalizedStrings vok_addXImagesFormat], @(itemCount)];
            }
        case PHAssetMediaTypeVideo:
            if (itemCount == 0) {
                return [VOKMultiImagePickerExampleLocalizedStrings vok_addVideos];
            } else if (itemCount == 1) {
                return [VOKMultiImagePickerExampleLocalizedStrings vok_addOneVideo];
            } else {
                return [NSString stringWithFormat:[VOKMultiImagePickerExampleLocalizedStrings vok_addXVideosFormat], @(itemCount)];
            }
        case PHAssetMediaTypeAudio:
            if (itemCount == 0) {
                return [VOKMultiImagePickerExampleLocalizedStrings vok_addAudioItems];
            } else if (itemCount == 1) {
                return [VOKMultiImagePickerExampleLocalizedStrings vok_addOneAudioItem];
            } else {
                return [NSString stringWithFormat:[VOKMultiImagePickerExampleLocalizedStrings vok_addXAudioItemsFormat], @(itemCount)];
            }
    }
    return nil;
}

@end
