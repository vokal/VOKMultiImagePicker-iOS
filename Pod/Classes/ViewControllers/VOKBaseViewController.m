//
//  VOKBaseViewController.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKBaseViewController.h"

@implementation VOKBaseViewController

- (instancetype)init
{
    NSURL *bundlePath = [[NSBundle mainBundle] URLForResource:@"VOKMultiImagePicker-iOS" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundlePath];
    
    return [super initWithNibName:NSStringFromClass([self class]) bundle:bundle];
}

@end
