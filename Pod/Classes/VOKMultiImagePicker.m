//
//  VOKMultiImagePicker.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKMultiImagePicker.h"

#import "NSBundle+VOK.h"
#import "PHFetchResult+VOK.h"
#import "VOKAssetCollectionsViewController.h"
#import "VOKAssetsViewController.h"

@interface VOKMultiImagePicker ()

@property (nonatomic) NSArray *selectedAssets;

@end

@implementation VOKMultiImagePicker

- (instancetype)init
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle vok_multiImageSelectBundle]];
    return [storyboard instantiateInitialViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    VOKAssetCollectionsViewController *albumViewController = [[VOKAssetCollectionsViewController alloc] initWithMediaType:self.mediaType];
    
    switch (self.startPosition) {
        case VOKMultiImagePickerStartPositionAlbums:
            self.viewControllers = @[albumViewController];
            break;
        case VOKMultiImagePickerStartPositionCameraRoll: {
            PHFetchResult *fetchResult = [PHFetchResult vok_fetchResultWithAssetsOfType:self.mediaType];
            VOKAssetsViewController *cameraRollViewController = [[VOKAssetsViewController alloc] initWithFetchResult:fetchResult];
            self.viewControllers = @[albumViewController, cameraRollViewController];
            break;
        }
    }
}

- (void)doneSelectingAssets
{
    [self.imageDelegate multiImagePickerSelectedAssets:self.selectedAssets];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
