//
//  VOKAlbumViewController.m
//  VOKMultiImagePicker
//
//  Created by Luke Quigley on 12/8/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKAlbumViewController.h"

#import "VOKAlbumDataSource.h"
#import "VOKMultiImagePickerLocalizedStrings.h"

@interface VOKAlbumViewController ()

@property (nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) VOKAlbumDataSource *dataSource;

@end

@implementation VOKAlbumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [VOKMultiImagePickerLocalizedStrings selectAnAlbum];
    
    self.dataSource = [[VOKAlbumDataSource alloc] initWithTableView:self.tableView];
}

@end
