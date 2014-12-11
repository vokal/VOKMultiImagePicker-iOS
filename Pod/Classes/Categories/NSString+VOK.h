//
//  NSString+VOK.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import Foundation;

@interface NSString (VOK)

+ (instancetype)vok_selectAnAlbum;
+ (instancetype)vok_cameraRoll;
+ (instancetype)vok_addItems;
+ (instancetype)vok_addOneItem;
+ (instancetype)vok_addXItemsFormat;

@end
