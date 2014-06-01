//
//  RKPRKPMasterViewControllerTest.m
//  panda-wall
//
//  Created by Rajkumar P on 5/31/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RKPMasterViewController.h"
#import "RKPThumbnailCell.h"


#define ktestAlbum1Name @"testAlbum1"
#define ktestAlbum2Name @"testAlbum2"
#define ktestImageDate @"20140602"



@interface RKPMasterViewController(UnitTests)

- (void)updateSectionHeaderCell:(NSIndexPath *)indexPath SectionHeaderCell:(RKPSectionHeaderCell *)headerView;
- (void)updateImageThumbnailCell:(NSIndexPath *)indexPath ImageThumnailView:(RKPThumbnailCell *)cell;
- (void)setAccessibilityforCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)setImageCollectionInstance:(NSArray *)imagesReceived;

@end

@interface RKPMasterViewControllerTest : XCTestCase{
    RKPMasterViewController *_controller;
}

@end

@implementation RKPMasterViewControllerTest

#pragma mark-
#pragma mark Setup

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    _controller = [storyboard instantiateViewControllerWithIdentifier:@"iPhoneMasterView"];
    [_controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
    [self populateImageCollection];
}

- (void)populateImageCollection{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
//    Test image information
    UIImage *testImagethumbNail =[[UIImage alloc] init];
    NSURL *testURL = [[NSURL alloc] initWithString:@"test url"];
    NSDate *testImagedate = [dateFormat dateFromString:ktestImageDate];
    CLLocation *testLocation = [[CLLocation alloc] initWithLatitude:20.0060893 longitude:-102.7813159];
    
    ImageInformation *testImage1Info = [[ImageInformation alloc] init];
    [testImage1Info setThumbNail:testImagethumbNail];
    [testImage1Info setAssetURL:testURL];
    [testImage1Info setTimeStamp:testImagedate];
    [testImage1Info setGeoTag:testLocation];
    
    ImageInformation *testImage2Info = [[ImageInformation alloc] init];
    [testImage2Info setThumbNail:testImagethumbNail];
    [testImage2Info setAssetURL:testURL];
    [testImage2Info setTimeStamp:testImagedate];
    [testImage2Info setGeoTag:testLocation];

    ImageAlbum *testAlbum1 = [[ImageAlbum alloc] init];
    [testAlbum1 setAlbumName:ktestAlbum1Name];
    [testAlbum1 setImageCollection:[[NSArray alloc] initWithObjects:testImage1Info,testImage2Info, nil]];
    
    ImageAlbum *testAlbum2 = [[ImageAlbum alloc] init];
    [testAlbum2 setAlbumName:ktestAlbum2Name];
    [testAlbum2 setImageCollection:[[NSArray alloc] initWithObjects:testImage1Info,testImage2Info, nil]];
    
     NSMutableArray *testImageCollection = [[NSMutableArray alloc] init];
    [testImageCollection addObject:testAlbum1];
    [testImageCollection addObject:testAlbum2];
    
    [_controller setImageCollectionInstance:testImageCollection];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark-
#pragma mark Unit test

- (void) testHeaderSectionCreations{
    
    NSIndexPath *testIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    RKPSectionHeaderCell *cell = [[RKPSectionHeaderCell alloc] init];
    
    [_controller updateSectionHeaderCell:testIndexPath SectionHeaderCell:cell];
    
    XCTAssertTrue([[[cell sectionHeader] text] isEqualToString:ktestAlbum1Name], @"The album name should match the populated section header");
}


- (void) testThumbnailCellAccessibilty{
    NSIndexPath *testIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    RKPThumbnailCell *cell = [[RKPThumbnailCell alloc] init];
    
    [_controller updateImageThumbnailCell:testIndexPath ImageThumnailView:cell];
    
    XCTAssertEqual([cell accessibilityTraits], UIAccessibilityTraitButton, @"Cell should be treated as button click on accesibilty");
    
    XCTAssertTrue([[cell accessibilityLabel] isEqualToString:@"Image number 1"], @"Cell accessibilty lable to match the index path");
    
    XCTAssertTrue([[cell accessibilityHint] isEqualToString:@"Double tap to open the image number 1"], @"Cell accessibilty hint to match the index path");
    
}


@end
