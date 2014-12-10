//
//  VOKBaseViewController.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Quigley on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKBaseViewController.h"

#import "NSBundle+VOK.h"

@implementation VOKBaseViewController

- (instancetype)init
{
    return [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle vok_multiImageSelectBundle]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                         target:self
                                                                                         action:@selector(close)];
    self.navigationItem.rightBarButtonItem = cancelBarButtonItem;
}

- (void)close
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
