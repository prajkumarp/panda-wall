    //
    //  ImageHelper.m
    //  MediaManager
    //
    //  Created by Panneerselvam, Rajkumar on 5/29/14.
    //  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
    //

#import "ImageHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "ImageAlbum.h"
#import "ImageInformation.h"


@implementation ImageHelper

+(void) fetchImages:(imageFetcherCompletion) fetcherCompletionBlock{
    
    NSMutableArray *imageCollection  = [[NSMutableArray alloc] init];
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
        // setup our failure view controller in case enumerateGroupsWithTypes fails
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
    };
    
        // emumerate through our groups and only add groups that contain photos
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
            {
            ImageAlbum *newAlbum = [[ImageAlbum alloc] init];
            [newAlbum setThumbNail: [UIImage imageWithCGImage:[group posterImage]]];
            [newAlbum setAlbumName: [group valueForProperty:ALAssetsGroupPropertyName]];
            
            NSMutableArray *images  = [[NSMutableArray alloc] init];
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result){
                    
                    ALAssetRepresentation* representation = [result defaultRepresentation];
                    CLLocation *imageLoc = [result valueForProperty:ALAssetPropertyLocation];
                    NSDate * date = [result valueForProperty:ALAssetPropertyDate];
                    
                    ImageInformation *tempImageInfo = [[ImageInformation alloc] init];
                    
                    [tempImageInfo setThumbNail:[UIImage imageWithCGImage:[result thumbnail]]];
                    [tempImageInfo setAssetURL:[representation url]];
                    [tempImageInfo setTimeStamp:date];
                    [tempImageInfo setGeoTag:imageLoc];
                    
                    [images addObject:tempImageInfo];
                    
                }
            }];
            
            [newAlbum setImageCollection:images];
            
            [imageCollection addObject:newAlbum];

            }
            fetcherCompletionBlock(imageCollection);
        
    };
    
        // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    
    [assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    

}


@end
