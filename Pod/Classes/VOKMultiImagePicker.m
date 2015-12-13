//
//  VOKMultiImagePicker.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKMultiImagePicker.h"

#import "PHFetchResult+VOK.h"
#import "UIImage+VOK.h"
#import "VOKAssetCollectionsViewController.h"
#import "VOKAssetCollectionViewCell.h"
#import "VOKAssetsViewController.h"
#import "VOKMultiImagePickerConstants.h"
#import "VOKMultiImagePickerLocalizedStrings.h"
#import "VOKSelectedAssetManager.h"

@interface VOKMultiImagePicker ()

@property (nonatomic, weak) UIView *containerView;

@end

@implementation VOKMultiImagePicker

static CGFloat const VOKMultiImagePickerViewDefaultWidth = 600.0f;
static CGFloat const VOKMultiImagePickerAddItemsButtonHeight = 60.0f;

- (instancetype)init
{
    if (self = [super init]) {
        [[VOKSelectedAssetManager sharedManager] resetManager];
        _addItemsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addItemsButton.frame = CGRectMake(0.0f,
                                           0.0f,
                                           VOKMultiImagePickerViewDefaultWidth,
                                           VOKMultiImagePickerAddItemsButtonHeight);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationReceived:)
                                                 name:VOKMultiImagePickerNotifications.assetsChanged
                                               object:nil];
}

- (void)setupView
{
    //Setup container view.
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                     0.0f,
                                                                     CGRectGetWidth(self.view.frame),
                                                                     CGRectGetHeight(self.view.frame) - VOKMultiImagePickerAddItemsButtonHeight)];
    self.containerView = containerView;
    [self.view addSubview:self.containerView];
    
    //Setup add items button.
    [self.addItemsButton addTarget:self action:@selector(doneSelectingAssets) forControlEvents:UIControlEventTouchUpInside];
    self.addItemsButton.frame = CGRectMake(0.0f,
                                           CGRectGetMaxY(self.containerView.frame),
                                           CGRectGetWidth(self.view.frame),
                                           VOKMultiImagePickerAddItemsButtonHeight);
    
    CGSize imageSize = CGSizeMake(CGRectGetWidth(self.addItemsButton.frame), VOKMultiImagePickerAddItemsButtonHeight);
    if (![self.addItemsButton backgroundImageForState:UIControlStateNormal]) {
        UIImage *enabledImage = [UIImage vok_imageOfColor:[UIColor greenColor] size:imageSize];
        [self.addItemsButton setBackgroundImage:enabledImage forState:UIControlStateNormal];
    }
    if (![self.addItemsButton backgroundImageForState:UIControlStateDisabled]) {
        UIImage *disabledImage = [UIImage vok_imageOfColor:[UIColor lightGrayColor] size:imageSize];
        [self.addItemsButton setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    }
    
    if (![self.addItemsButton titleForState:UIControlStateNormal]) {
        [self.addItemsButton setTitle:[VOKMultiImagePickerLocalizedStrings addItems] forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.addItemsButton];
    
    self.containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.addItemsButton.autoresizingMask = (UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleTopMargin);
    
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
            cameraRollViewController.title = [VOKMultiImagePickerLocalizedStrings cameraRoll];
            containerNavigationController.viewControllers = @[albumViewController, cameraRollViewController];
            break;
        }
    }
    
    [self updateAddItemsButton];
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
        if ([self.imageDelegate respondsToSelector:@selector(multiImagePicker:addButtonLabelForItemCount:)]) {
            titleString = [self.imageDelegate multiImagePicker:self addButtonLabelForItemCount:assetCount];
        } else if (assetCount == 1) {
            titleString = [VOKMultiImagePickerLocalizedStrings addOneItem];
        } else {
            titleString = [NSString stringWithFormat:[VOKMultiImagePickerLocalizedStrings addXItemsFormat], @(assetCount)];
        }
        [self.addItemsButton setTitle:titleString forState:UIControlStateNormal];
    } else {
        self.addItemsButton.enabled = NO;
        
        NSString *titleString;
        if ([self.imageDelegate respondsToSelector:@selector(multiImagePicker:addButtonLabelForItemCount:)]) {
            titleString = [self.imageDelegate multiImagePicker:self addButtonLabelForItemCount:assetCount];
        } else {
            titleString = [VOKMultiImagePickerLocalizedStrings addItems];
        }
        [self.addItemsButton setTitle:titleString forState:UIControlStateNormal];
    }
}

#pragma mark - Values passed to the manager.

- (void)setMaxNumberOfAssets:(NSUInteger)maxNumberOfAssets
{
    _maxNumberOfAssets = maxNumberOfAssets;
    [VOKSelectedAssetManager sharedManager].maxNumberOfAssets = maxNumberOfAssets;
}

- (void)setMediaType:(PHAssetMediaType)mediaType
{
    _mediaType = mediaType;
    
    [VOKSelectedAssetManager sharedManager].mediaType = mediaType;
}

- (void)setAssetCollectionViewCellClass:(Class)assetCollectionViewCellClass
{
    if ([assetCollectionViewCellClass isSubclassOfClass:[VOKAssetCollectionViewCell class]]) {
        _assetCollectionViewCellClass = assetCollectionViewCellClass;
        
        [VOKSelectedAssetManager sharedManager].assetCollectionViewCellClass = assetCollectionViewCellClass;
    } else {
        NSAssert(NO, @"You must use a subclass of VOKAssetCollectionViewCell.");
    }
}

- (void)setAssetCollectionViewColumnCount:(NSInteger)assetCollectionViewColumnCount
{
    _assetCollectionViewColumnCount = assetCollectionViewColumnCount;
    
    [VOKSelectedAssetManager sharedManager].assetCollectionViewColumnCount = assetCollectionViewColumnCount;
}

#pragma mark - Actions

- (IBAction)doneSelectingAssets
{
    [self.imageDelegate multiImagePicker:self selectedAssets:[[VOKSelectedAssetManager sharedManager] selectedAssets]];
    [self dismissViewControllerAnimated:YES completion:^{
        [[VOKSelectedAssetManager sharedManager] resetManager];
    }];
}

@end
