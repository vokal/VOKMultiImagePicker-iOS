//
//  VOKMultiImagePicker.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKMultiImagePicker.h"

#import "NSBundle+VOK.h"
#import "NSString+VOK.h"
#import "PHFetchResult+VOK.h"
#import "UIImage+VOK.h"
#import "VOKAssetCollectionsViewController.h"
#import "VOKAssetsViewController.h"
#import "VOKMultiImagePickerConstants.h"
#import "VOKSelectedAssetManager.h"

@interface VOKMultiImagePicker ()

@property (nonatomic, weak) IBOutlet UIView *containerView;

@end

@implementation VOKMultiImagePicker

- (instancetype)init
{
    [[VOKSelectedAssetManager sharedManager] resetManager];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:VOKMultiImagePickerStoryboardNames.storyboard bundle:[NSBundle vok_multiImageSelectBundle]];
    return [storyboard instantiateInitialViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationController *containerNavigationController = [[UINavigationController alloc] init];
    containerNavigationController.view.frame = self.containerView.bounds;
    
    [self addChildViewController:containerNavigationController];
    [self.containerView addSubview:containerNavigationController.view];
    [containerNavigationController didMoveToParentViewController:self];
    
    VOKAssetCollectionsViewController *albumViewController = [[VOKAssetCollectionsViewController alloc] init];
    
    switch (self.startPosition) {
        case VOKMultiImagePickerStartPositionAlbums:
            containerNavigationController.viewControllers = @[albumViewController];
            break;
        case VOKMultiImagePickerStartPositionCameraRoll: {
            PHFetchResult *fetchResult = [PHFetchResult vok_fetchResultWithAssetsOfType:self.mediaType];
            VOKAssetsViewController *cameraRollViewController = [[VOKAssetsViewController alloc] initWithFetchResult:fetchResult];
            cameraRollViewController.title = [NSString vok_cameraRoll];
            containerNavigationController.viewControllers = @[albumViewController, cameraRollViewController];
            break;
        }
    }
    
    CGSize imageSize = CGSizeMake(CGRectGetWidth(self.addItemsButton.frame), CGRectGetHeight(self.addItemsButton.frame));
    
    UIImage *enabledImage = [UIImage vok_imageOfColor:[UIColor greenColor] size:imageSize];
    UIImage *disabledImage = [UIImage vok_imageOfColor:[UIColor lightGrayColor] size:imageSize];
    
    [self.addItemsButton setBackgroundImage:enabledImage forState:UIControlStateNormal];
    [self.addItemsButton setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    [self updateAddItemsButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationReceived:)
                                                 name:VOKMultiImagePickerNotifications.assetsChanged
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notificationReceived:(NSNotification *)notification
{
    [self updateAddItemsButton];
}

- (void)updateAddItemsButton
{
    NSArray *selectedAssetsArray = [[VOKSelectedAssetManager sharedManager] selectedAssets];
    NSInteger assetCount = selectedAssetsArray.count;
    if (assetCount) {
        self.addItemsButton.enabled = YES;
        
        NSString *titleString;
        if (assetCount == 1) {
            titleString = [NSString vok_addOneItem];
        } else {
            titleString = [NSString stringWithFormat:[NSString vok_addXItemsFormat], @(assetCount)];
        }
        [self.addItemsButton setTitle:titleString forState:UIControlStateNormal];
    } else {
        self.addItemsButton.enabled = NO;
        [self.addItemsButton setTitle:[NSString vok_addItems] forState:UIControlStateNormal];
    }
}

- (void)setMediaType:(PHAssetMediaType)mediaType
{
    _mediaType = mediaType;
    
    [VOKSelectedAssetManager sharedManager].mediaType = mediaType;
}

#pragma mark - Actions

- (IBAction)doneSelectingAssets
{
    [self.imageDelegate multiImagePickerSelectedAssets:[[VOKSelectedAssetManager sharedManager] selectedAssets]];
    [self dismissViewControllerAnimated:YES completion:^{
        [[VOKSelectedAssetManager sharedManager] resetManager];
    }];
}

@end
