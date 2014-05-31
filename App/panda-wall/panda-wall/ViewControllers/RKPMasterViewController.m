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
            NSLog(@"%@",imageCollection);
            [[self collectionView] reloadData];
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    
//    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc]init];
//    
//    if ((toInterfaceOrientation == UIDeviceOrientationPortrait) || (toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown)){
//        myLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    }else{
//        myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    }
//    
//    [self.collectionView setCollectionViewLayout:myLayout animated:YES];
//}


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
#pragma mark UICollectionViewImplementation

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [imageCollection count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ImageAlbum *album = [imageCollection objectAtIndex:section];
    return [[album imageCollection]count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKPThumbnailCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"ThumbNailCell"
                                    forIndexPath:indexPath];
    
    
    
    ImageAlbum *album = [imageCollection objectAtIndex:[indexPath section]];
    
    ImageInformation *imageInfoAtIndex = [[album imageCollection] objectAtIndex:[indexPath row]];
    [myCell setImageDetails:imageInfoAtIndex];
    [[myCell thumbnailImage] setImage:[imageInfoAtIndex thumbNail]];

    
    return myCell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets=UIEdgeInsetsMake(10, 10, 10, 10);
    return insets;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        ImageAlbum *album =  [imageCollection objectAtIndex:[indexPath section]];
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SecHeader" forIndexPath:indexPath];
        
        if (headerView==nil) {
            headerView=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 30)];
        label.text = [NSString stringWithFormat:@"%@",[album albumName]];
        [headerView addSubview:label];
        
        return headerView;
        
    }
    return nil;
}



@end
