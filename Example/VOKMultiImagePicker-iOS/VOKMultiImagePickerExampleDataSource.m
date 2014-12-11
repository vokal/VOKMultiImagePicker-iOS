//
//  VOKExampleDataSource.m
//  VOKMultiImagePicker-iOS
//
//  Created by Luke Q on 12/10/14.
//  Copyright (c) 2014 VOKAL LLC. All rights reserved.
//

#import "VOKMultiImagePickerExampleDataSource.h"

#import "VOKMultiImagePickerExampleLocalizedStrings.h"

@interface VOKMultiImagePickerExampleDataSource () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation VOKMultiImagePickerExampleDataSource

static NSString *const VOKMultiImagePickerExampleDataSourceRowIdentifier = @"ExampleDataSourceRowIdentifier";

- (instancetype)initWithTableView:(UITableView *)tableView
{
    if (self = [super init]) {
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:VOKMultiImagePickerExampleDataSourceRowIdentifier];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return VOKMultiImagePickerExampleDataSourceRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VOKMultiImagePickerExampleDataSourceRowIdentifier forIndexPath:indexPath];
    
    NSString *title;
    switch (indexPath.row) {
        case VOKMultiImagePickerExampleDataSourceRowPhotos:
            title = [VOKMultiImagePickerExampleLocalizedStrings vok_selectPhotos];
            break;
        case VOKMultiImagePickerExampleDataSourceRowVideos:
            title = [VOKMultiImagePickerExampleLocalizedStrings vok_selectVideos];
            break;
        case VOKMultiImagePickerExampleDataSourceRowBoth:
            title = [VOKMultiImagePickerExampleLocalizedStrings vok_selectBoth];
            break;
        case VOKMultiImagePickerExampleDataSourceRowPhotosInCameraRoll:
            title = [VOKMultiImagePickerExampleLocalizedStrings vok_selectPhotosInCameraRoll];
            break;
        case VOKMultiImagePickerExampleDataSourceRowVideosInCameraRoll:
            title = [VOKMultiImagePickerExampleLocalizedStrings vok_selectVideosInCameraRoll];
            break;
    }
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate dataSource:self selectedRow:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
