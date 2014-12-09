//
//  ViewController.m
//  VOKMultiImagePickerExample
//
//  Created by Luke Quigley on 12/9/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "ViewController.h"

#import "VOKMultiImagePicker.h"

@implementation ViewController

- (IBAction)showImagePicker
{
    VOKMultiImagePicker *multiImagePicker = [[VOKMultiImagePicker alloc] init];
    [self.navigationController presentViewController:multiImagePicker
                                            animated:YES
                                          completion:nil];
}

@end
