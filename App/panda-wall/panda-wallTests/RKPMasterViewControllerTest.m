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

@interface RKPMasterViewController(UnitTests)

- (UICollectionReusableView *)createSectionHeaderCell:(NSIndexPath *)indexPath;
- (RKPThumbnailCell *)createImageThumbnailCell:(NSIndexPath *)indexPath;
- (void)setAccessibilityforCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@interface RKPMasterViewControllerTest : XCTestCase{
    RKPMasterViewController *_controller;
}

@end

@implementation RKPMasterViewControllerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    _controller = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    [_controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)testImageGeneration{
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
