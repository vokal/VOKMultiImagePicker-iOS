//
//  NSBundle+VOK.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "NSBundle+VOK.h"

#import "VOKMultiImagePickerConstants.h"

@implementation NSBundle (VOK)

+ (instancetype)vok_multiImageSelectBundle
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleName = [info objectForKey:@"CFBundleDisplayName"];
    NSURL *bundlePath = [[NSBundle mainBundle] URLForResource:bundleName withExtension:VOKMultiImagePickerTypeNames.bundle];
    return [NSBundle bundleWithURL:bundlePath];
}

@end
