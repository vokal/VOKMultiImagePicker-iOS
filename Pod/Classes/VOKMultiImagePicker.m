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

@interface VOKMultiImagePicker ()

@property (nonatomic) NSMutableArray *selectedAssets;
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
                                                 name:VOKMultiImagePickerNotifications.assetSelected
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationReceived:)
                                                 name:VOKMultiImagePickerNotifications.assetDeselected
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notificationReceived:(NSNotification *)notification
{
    PHAsset *asset = notification.object;
    if ([notification.name isEqualToString:VOKMultiImagePickerNotifications.assetSelected]) {
        if (![self.selectedAssets containsObject:asset]) {
            [self.selectedAssets addObject:asset];
        }
    } else if ([notification.name isEqualToString:VOKMultiImagePickerNotifications.assetDeselected]) {
        [self.selectedAssets removeObject:asset];
    }
    [self updateAddItemsButton];
}

- (NSMutableArray *)selectedAssets
{
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray new];
    }
    return _selectedAssets;
}

- (void)updateAddItemsButton
{
    if (self.selectedAssets.count) {
        self.addItemsButton.enabled = YES;
        
        NSString *titleString;
        if (self.selectedAssets.count == 1) {
            titleString = [NSString vok_addOneItem];
        } else {
            titleString = [NSString stringWithFormat:[NSString vok_addXItemsFormat], @(self.selectedAssets.count)];
        }
        [self.addItemsButton setTitle:titleString forState:UIControlStateNormal];
    } else {
        self.addItemsButton.enabled = NO;
        [self.addItemsButton setTitle:[NSString vok_addItems] forState:UIControlStateNormal];
    }
}

- (IBAction)doneSelectingAssets
{
    [self.imageDelegate multiImagePickerSelectedAssets:[self.selectedAssets copy]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
