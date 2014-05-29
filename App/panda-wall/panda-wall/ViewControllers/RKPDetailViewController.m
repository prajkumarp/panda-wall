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
    [_fullSizeImage setImage:[[_passonImageDetails thumbnailImage] image]];
    [_imageTimeStamp setText:[[_passonImageDetails imageDetails] getDateandTime]];
    [self updateImageLocation:[[_passonImageDetails imageDetails] geoTag]];
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

- (void)updateImageLocation:(CLLocation *)geoTag{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:geoTag completionHandler:^(NSArray *placemarks, NSError *error)
     {
     if (!(error))
         {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         NSString *Area = [[NSString alloc]initWithString:placemark.locality];
         NSString *Country = [[NSString alloc]initWithString:placemark.country];
         [_imageGeoTag setText:[NSString stringWithFormat:@"%@, %@",Area,Country]];
         }
     else
         {
         [_imageGeoTag setText:@"Location not found" ];
         }
     }];
}


@end
