//
//  NSIndexSet+VOK.h
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/11/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

@import Foundation;

@interface NSIndexSet (VOK)

- (NSArray *)vok_indexPathsFromIndexesWithSection:(NSUInteger)section;

@end
