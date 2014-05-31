//
//  ImageAlbum.h
//  MediaManager
//
//  Created by Panneerselvam, Rajkumar on 5/31/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageAlbum : NSObject

@property (strong) UIImage *thumbNail;
@property (strong) NSString  *albumName;
@property (strong) NSArray *imageCollection;

@end
