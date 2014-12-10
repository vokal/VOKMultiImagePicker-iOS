//
//  VOKViewController.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/09/2014.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKViewController.h"

#import <VOKMultiImagePicker.h>

@implementation VOKViewController

- (IBAction)showImagePicker
{
    VOKMultiImagePicker *multiImagePicker = [[VOKMultiImagePicker alloc] init];
    [self.navigationController presentViewController:multiImagePicker
                                            animated:YES
                                          completion:nil];
}

@end
