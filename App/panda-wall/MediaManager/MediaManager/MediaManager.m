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
#import "ImageHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MediaManager

+(void) fetchImages:(myCompletion) compblock{
    
    [ImageHelper fetchImages:^(NSArray *imageCollection) {
        compblock(imageCollection);
    }];
}


@end
