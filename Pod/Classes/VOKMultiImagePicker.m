//
//  VOKMultiImagePicker.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKMultiImagePicker.h"

#import "VOKAssetCollectionsViewController.h"

@implementation VOKMultiImagePicker

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    VOKAssetCollectionsViewController *albumViewController = [[VOKAssetCollectionsViewController alloc] init];
    self.viewControllers = @[albumViewController];
}

@end
