    //
    //  MediaManager.m
    //  MediaManager
    //
    //  Created by Panneerselvam, Rajkumar on 5/28/14.
    //  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
    //

#import "MediaManager.h"
#import "ImageInformation.h"
#import "ImageAlbum.h"
#import "DeviceImageHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MediaManager

+(void) fetchImages:(fetcingSuccessful) compblock fetchingFailed:(fetchingFailed)failureBlock
{
    
    [DeviceImageHelper fetchImagesFromDevice:^(NSArray *imageCollection) {
        compblock(imageCollection);
    } failureBlock:^(NSError *error) {
        failureBlock(error);}];
}


@end
