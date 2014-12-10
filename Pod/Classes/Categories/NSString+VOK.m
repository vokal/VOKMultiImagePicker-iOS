//
//  NSString+VOK.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "NSString+VOK.h"

@implementation NSString (VOK)

+ (instancetype)vok_selectAnAlbum
{
    return NSLocalizedString(@"Select an Album", @"Select an Album");
}

+ (instancetype)vok_cameraRoll
{
    return NSLocalizedString(@"Camera Roll", @"Camera Roll");
}

@end
