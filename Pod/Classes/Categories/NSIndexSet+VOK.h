//
//  NSIndexSet+VOK.h
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/11/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import Foundation;

@interface NSIndexSet (VOK)

/**
 *  Returns an array of NSIndexPaths with each index in self as the row
 *  and with the specified section.
 *
 *  @param section The section the index paths will be in.
 *
 *  @return An array of NSIndexPaths.
 */
- (NSArray *)vok_indexPathsFromIndexesWithSection:(NSUInteger)section;

@end
