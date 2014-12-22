//
//  NSString+Localized.m
//  Pods
//
//  Created by Luke Quigley on 12/22/14.
//
//

#import "NSString+Localized.h"

@implementation NSString (Localized)

+ (instancetype)vok_addXImagesFormat
{
    return NSLocalizedString(@"Add %@ Images", @"Add %@ Images");
}

+ (instancetype)vok_addOneImage
{
    return NSLocalizedString(@"Add 1 Image", @"Add 1 Image");
}

+ (instancetype)vok_addImages
{
    return NSLocalizedString(@"Add Images", @"Add Images");
}

+ (instancetype)vok_addXVideosFormat
{
    return NSLocalizedString(@"Add %@ Videos", @"Add %@ Videos");
}

+ (instancetype)vok_addOneVideo
{
    return NSLocalizedString(@"Add 1 Video", @"Add 1 Video");
}

+ (instancetype)vok_addVideos
{
    return NSLocalizedString(@"Add Videos", @"Add Videos");
}

+ (instancetype)vok_addXAudioItemsFormat
{
    return NSLocalizedString(@"Add %@ Audio Items", @"Add %@ Audio Items");
}

+ (instancetype)vok_addOneAudioItem
{
    return NSLocalizedString(@"Add 1 Audio Item", @"Add 1 Audio Item");
}

+ (instancetype)vok_addAudioItems
{
    return NSLocalizedString(@"Add Audio Items", @"Add Audio Items");
}
                             

@end
