//
//  VOKMultiImagePicker.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKMultiImagePicker.h"

#import "VOKAlbumViewController.h"

@implementation VOKMultiImagePicker

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    VOKAlbumViewController *albumViewController = [[VOKAlbumViewController alloc] initWithNibName:NSStringFromClass([VOKAlbumViewController class]) bundle:nil];
    self.viewControllers = @[albumViewController];
}

@end
