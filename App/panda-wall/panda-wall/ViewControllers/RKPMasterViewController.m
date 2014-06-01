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
    
    imageCollection = [[NSArray alloc] init];
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (RKPDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [MediaManager fetchImages:^(NSArray *imagesReceived) {
        if(imagesReceived){
            [self setImageCollectionInstance:imagesReceived];
            [[self collectionView] reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"iphonePicDetails"]) {
        if ([sender isKindOfClass:[RKPThumbnailCell class]]) {
            RKPThumbnailCell *senderCell = (RKPThumbnailCell *)sender;
            [[segue destinationViewController] setPassonImageDetails:senderCell];
        }
        
    }
}

#pragma mark -
#pragma mark UICollectionView layout configs

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [imageCollection count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ImageAlbum *album = [imageCollection objectAtIndex:section];
    return [[album imageCollection]count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 70);
}

#pragma mark UICollectionView cell creations

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKPThumbnailCell *thumbnailCell = [[self collectionView]
                              dequeueReusableCellWithReuseIdentifier:@"ThumbNailCell"
                              forIndexPath:indexPath];
    
    [self updateImageThumbnailCell:indexPath ImageThumnailView:thumbnailCell];
    return thumbnailCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        RKPSectionHeaderCell *headerView = [[self collectionView] dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SecHeader" forIndexPath:indexPath];
        [self updateSectionHeaderCell:indexPath SectionHeaderCell:headerView];
        return headerView;
    }
    return nil;
}

#pragma mark -
#pragma mark Private convenience methods

- (void)setImageCollectionInstance:(NSArray *)imagesReceived{
    imageCollection = imagesReceived;
}

- (void)updateSectionHeaderCell:(NSIndexPath *)indexPath SectionHeaderCell:(RKPSectionHeaderCell *)headerView {
    ImageAlbum *album =  [imageCollection objectAtIndex:[indexPath section]];
    [headerView initialize];
    [[headerView sectionHeader] setText:[NSString stringWithFormat:@"%@",[album albumName]]];

}

- (void)updateImageThumbnailCell:(NSIndexPath *)indexPath ImageThumnailView:(RKPThumbnailCell *)cell{
    
    ImageAlbum *album = [imageCollection objectAtIndex:[indexPath section]];
    ImageInformation *imageInfoAtIndex = [[album imageCollection] objectAtIndex:[indexPath row]];
    [cell setImageDetails:imageInfoAtIndex];
    [[cell thumbnailImage] setImage:[imageInfoAtIndex thumbNail]];
    
    [self setAccessibilityforCell:cell atIndexPath:indexPath];
}


- (void)setAccessibilityforCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    [cell setAccessibilityTraits:UIAccessibilityTraitButton];
    [cell setIsAccessibilityElement:YES];
    [cell setAccessibilityHint:[NSString stringWithFormat:@"Double tap to open the image number %i",[indexPath row]+1]];
    [cell setAccessibilityLabel:[NSString stringWithFormat:@"Image number %i",[indexPath row]+1]];
}


@end
