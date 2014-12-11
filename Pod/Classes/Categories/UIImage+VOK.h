//
//  UIImage+VOK.h
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/11/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (VOK)

/**
 *  Creates an image of just a single color.
 *
 *  @param color The color to use.
 *  @param size  The size of the image to return.
 *
 *  @return An image of a solid color with the specified size.
 */
+ (UIImage *)vok_imageOfColor:(UIColor *)color size:(CGSize)size;

@end
