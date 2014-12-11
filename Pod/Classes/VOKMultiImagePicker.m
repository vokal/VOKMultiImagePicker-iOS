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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle vok_multiImageSelectBundle]];
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
    
    VOKAssetCollectionsViewController *albumViewController = [[VOKAssetCollectionsViewController alloc] initWithMediaType:self.mediaType];
    
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

- (IBAction)doneSelectingAssets
{
    [self.imageDelegate multiImagePickerSelectedAssets:[[VOKSelectedAssetManager sharedManager] selectedAssets]];
    [self dismissViewControllerAnimated:YES completion:^{
        [[VOKSelectedAssetManager sharedManager] resetManager];
    }];
}

@end
