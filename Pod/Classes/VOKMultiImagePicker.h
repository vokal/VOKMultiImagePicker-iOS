//
//  VOKMultiImagePicker.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import UIKit;

@protocol VOKMultiImagePickerDelegate <NSObject>

- (void)multiImagePickerSelectedImages:(NSArray *)images;

@end

@interface VOKMultiImagePicker : UINavigationController

@property (nonatomic, weak) id<VOKMultiImagePickerDelegate> imageDelegate;

@end
