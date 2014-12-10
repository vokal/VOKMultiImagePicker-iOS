//
//  NSBundle+VOK.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "NSBundle+VOK.h"

@implementation NSBundle (VOK)

+ (instancetype)vok_multiImageSelectBundle
{
    NSURL *bundlePath = [[NSBundle mainBundle] URLForResource:@"VOKMultiImagePicker-iOS" withExtension:@"bundle"];
    return [NSBundle bundleWithURL:bundlePath];
}

@end
