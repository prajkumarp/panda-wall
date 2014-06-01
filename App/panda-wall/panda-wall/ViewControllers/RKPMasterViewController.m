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
            imageCollection = imagesReceived;
            [[self collectionView] reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    RKPThumbnailCell *thumbnailCell = [self createImageThumbnailCell:indexPath];
    [self setAccessibilityforCell:thumbnailCell atIndexPath:indexPath];
    return thumbnailCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [self createSectionHeaderCell:indexPath];
        return headerView;
    }
    return nil;
}

#pragma mark -
#pragma mark Private convenience methods

- (UICollectionReusableView *)createSectionHeaderCell:(NSIndexPath *)indexPath{
    
    ImageAlbum *album =  [imageCollection objectAtIndex:[indexPath section]];
    
    UICollectionReusableView *headerView = [[self collectionView] dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SecHeader" forIndexPath:indexPath];
    
    if (headerView==nil) {
        headerView=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 30)];
    label.text = [NSString stringWithFormat:@"%@",[album albumName]];
    [headerView addSubview:label];
    
    return headerView;

}

- (RKPThumbnailCell *)createImageThumbnailCell:(NSIndexPath *)indexPath{
    
    RKPThumbnailCell *cell = [[self collectionView]
                                dequeueReusableCellWithReuseIdentifier:@"ThumbNailCell"
                                forIndexPath:indexPath];
    
    ImageAlbum *album = [imageCollection objectAtIndex:[indexPath section]];
    
    ImageInformation *imageInfoAtIndex = [[album imageCollection] objectAtIndex:[indexPath row]];
    [cell setImageDetails:imageInfoAtIndex];
    [[cell thumbnailImage] setImage:[imageInfoAtIndex thumbNail]];
    
    return cell;
}


- (void)setAccessibilityforCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    [cell setAccessibilityTraits:UIAccessibilityTraitButton];
    [cell setIsAccessibilityElement:YES];
    [cell setAccessibilityHint:[NSString stringWithFormat:@"Double tap to open the image number %i",[indexPath row]+1]];
    [cell setAccessibilityLabel:[NSString stringWithFormat:@"Image number %i",[indexPath row]+1]];
}


@end
