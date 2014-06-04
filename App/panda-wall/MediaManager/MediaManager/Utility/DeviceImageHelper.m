    //
    //  ImageHelper.m
    //  MediaManager
    //
    //  Created by Panneerselvam, Rajkumar on 5/29/14.
    //  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
    //

#import "DeviceImageHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "ImageAlbum.h"
#import "ImageInformation.h"


@implementation DeviceImageHelper

+(void) fetchImagesFromDevice:(imageFetcherCompletion) fetcherCompletionBlock failureBlock:(imageFetcherFailed) fetcherfailureBlock{
    
    NSMutableArray *imageCollection  = [[NSMutableArray alloc] init];
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
        // setup our failure view controller in case enumerateGroupsWithTypes fails
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                break;
            default:
                break;
        }
        fetcherfailureBlock(error);
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
                    UIImage *thumbNail =[[UIImage alloc] initWithCGImage:[result thumbnail]];
                    
                    [tempImageInfo setThumbNail:thumbNail];
                    [tempImageInfo setAssetURL:[representation url]];
                    [tempImageInfo setTimeStamp:date];
                    [tempImageInfo setGeoTag:imageLoc];
                    
                    [images addObject:tempImageInfo];
                    
                    thumbNail = nil;
                    tempImageInfo = nil;
                    representation = nil;
                    
                }
            }];
            
            [newAlbum setImageCollection:images];
            
            [imageCollection addObject:newAlbum];
                
                newAlbum = nil;

            }
            fetcherCompletionBlock(imageCollection);
        
    };
    
        // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    
    [assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    

}


@end
