//
//  VOKMultiImagePickerConstants.h
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@import Foundation;

@interface VOKMultiImagePickerConstants : NSObject

//Names of things associated with bundles, etc.
FOUNDATION_EXPORT const struct VOKMultiImagePickerTypeNames {
    //The string representing the bundle type;
    __unsafe_unretained NSString *bundle;
} VOKMultiImagePickerTypeNames;

//Names of things associated with storyboards.
FOUNDATION_EXPORT const struct VOKMultiImagePickerStoryboardNames {
    //The string representing the main storyboard.
    __unsafe_unretained NSString *storyboard;
} VOKMultiImagePickerStoryboardNames;

//Names of things associated with notifications
FOUNDATION_EXPORT const struct VOKMultiImagePickerNotifications {
    //The string representing when an asset has been added or removed.
    __unsafe_unretained NSString *assetsChanged;
} VOKMultiImagePickerNotifications;

@end

NS_ASSUME_NONNULL_END
