//
//  RKPDetailViewController.m
//  panda-wall
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import "RKPDetailViewController.h"
#import <ImageIO/ImageIO.h>

@interface RKPDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation RKPDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [_fullSizeImage setImage:_passonImage];
    
    NSDictionary *metaData = [self extractImageMetaData:_passonImage];
    
    NSLog(@"Metadata %@",metaData);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (NSDictionary*) extractImageMetaData:(UIImage*)image
{
    NSData *jpeg = [NSData dataWithData:UIImagePNGRepresentation(image)];
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)jpeg, NULL);
    CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
    NSLog (@"imageMetaData %@",imageMetaData);
    return (__bridge NSDictionary *)(imageMetaData);
}

- (void) logMetaDataFromAssetLibrary:(NSDictionary*)info
{
    
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:assetURL
             resultBlock:^(ALAsset *asset)  {
                 NSDictionary *imageMetaData = asset.defaultRepresentation.metadata;
                 NSLog (@"imageMetaData %@",imageMetadata);
             }
            failureBlock:nil];
}


@end
