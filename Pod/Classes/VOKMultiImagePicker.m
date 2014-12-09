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
    
    NSURL *bundlePath = [[NSBundle mainBundle] URLForResource:@"VOKMultiImagePicker-iOS" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundlePath];
    
    VOKAlbumViewController *albumViewController = [[VOKAlbumViewController alloc] initWithNibName:NSStringFromClass([VOKAlbumViewController class]) bundle:bundle];
    self.viewControllers = @[albumViewController];
}

@end
