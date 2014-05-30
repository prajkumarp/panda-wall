    //
    //  MediaManager.m
    //  MediaManager
    //
    //  Created by Panneerselvam, Rajkumar on 5/28/14.
    //  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
    //

#import "MediaManager.h"
#import "ImageInformation.h"
#import "ImageHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MediaManager

+(void) myMethod:(myCompletion) compblock{
    
    [ImageHelper fetchImages:^(NSArray *imageCollection) {
        NSLog(@"Count %i",[imageCollection count]);
        
        
        NSMutableArray *returnImageList = [[NSMutableArray alloc] init];
        
        for (ALAsset *loopAsset in imageCollection) {
            
            if ([[loopAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                   
                ALAssetRepresentation* representation = [loopAsset defaultRepresentation];
                CLLocation *imageLoc = [loopAsset valueForProperty:ALAssetPropertyLocation];
                NSDate * date = [loopAsset valueForProperty:ALAssetPropertyDate];
                
                ImageInformation *tempImageInfo = [[ImageInformation alloc] init];
                
                [tempImageInfo setThumbNail:[UIImage imageWithCGImage:[loopAsset thumbnail]]];
                [tempImageInfo setAssetURL:[representation url]];
                [tempImageInfo setTimeStamp:date];
                [tempImageInfo setGeoTag:imageLoc];
                
                [returnImageList addObject:tempImageInfo];
            }
            
        }
        
        compblock(returnImageList);
        
    }];
}


@end
