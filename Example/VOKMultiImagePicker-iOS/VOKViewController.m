//
//  VOKViewController.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/09/2014.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKViewController.h"

#import "VOKMultiImagePickerExampleDataSource.h"

#import <VOKMultiImagePicker.h>

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
            multiImagePicker.mediaType = PHAssetMediaTypeImage;
            multiImagePicker.startPosition = VOKMultiImagePickerStartPositionCameraRoll;
            break;
        }
        case VOKMultiImagePickerExampleDataSourceRowVideosInCameraRoll: {
            multiImagePicker.mediaType = PHAssetMediaTypeVideo;
            multiImagePicker.startPosition = VOKMultiImagePickerStartPositionCameraRoll;
            break;
        }
    }
    
    [self.navigationController presentViewController:multiImagePicker
                                            animated:YES
                                          completion:nil];
}

#pragma mark - VOKMultiImagePickerDelegate

- (void)multiImagePickerSelectedAssets:(NSArray *)assets
{
#warning TODO: Show the assets.
}

@end
