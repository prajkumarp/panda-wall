//
//  RKPMasterViewController.m
//  panda-wall
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import "RKPMasterViewController.h"

#import "RKPDetailViewController.h"


@interface RKPMasterViewController () {
    NSMutableArray *_objects;
    NSString *selectedImage;
}
@end

@implementation RKPMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (RKPDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc]init];
    
    if ((toInterfaceOrientation == UIDeviceOrientationPortrait) || (toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown)){
        myLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }else{
        myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    [self.collectionView setCollectionViewLayout:myLayout animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"iphonePicDetails"]) {
        [[segue destinationViewController] setPassonImage:[UIImage imageNamed:selectedImage]];
    }
}

#pragma mark -
#pragma mark UICollectionViewImplementation

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKPThumbnailCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"ThumbNailCell"
                                    forIndexPath:indexPath];
    
    UIImage *image;
    image = [UIImage imageNamed:@"vcard"];
    
    myCell.thumbnailImage.image = image;
    
    return myCell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(30, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedImage = @"vcard";
}


@end
