//
//  VOKMultiImagePickerExampleLocalizedStrings.h
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOKMultiImagePickerExampleLocalizedStrings : NSObject

+ (NSString *)vok_selectPhotos;
+ (NSString *)vok_selectVideos;
+ (NSString *)vok_selectBoth;
+ (NSString *)vok_selectPhotosInCameraRoll;
+ (NSString *)vok_selectVideosInCameraRoll;
+ (NSString *)vok_useCustomCollectionViewCell;
+ (NSString *)vok_oneColumn;
+ (NSString *)vok_fiveColumns;

//Localized strings referring to images.
+ (NSString *)vok_addXImagesFormat;
+ (NSString *)vok_addOneImage;
+ (NSString *)vok_addImages;

//Localized strings referring to videos.
+ (NSString *)vok_addXVideosFormat;
+ (NSString *)vok_addOneVideo;
+ (NSString *)vok_addVideos;

//Localized strings referring to audio.
+ (NSString *)vok_addXAudioItemsFormat;
+ (NSString *)vok_addOneAudioItem;
+ (NSString *)vok_addAudioItems;

@end
