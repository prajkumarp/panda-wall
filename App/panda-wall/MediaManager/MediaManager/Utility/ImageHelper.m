    //
    //  ImageHelper.m
    //  MediaManager
    //
    //  Created by Panneerselvam, Rajkumar on 5/29/14.
    //  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
    //

#import "ImageHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation ImageHelper

+(void) fetchImages:(imageFetcherCompletion) fetcherCompletionBlock{
    
    NSMutableArray *imageCollection  = [[NSMutableArray alloc] init];
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result){
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
                    [imageCollection addObject:result];
                }
            }
        }];
        
        fetcherCompletionBlock(imageCollection);
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
        
    }];
}


@end
