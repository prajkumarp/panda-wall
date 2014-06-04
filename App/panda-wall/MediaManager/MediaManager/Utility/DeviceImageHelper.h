//
//  ImageHelper.h
//  MediaManager
//
//  Created by Panneerselvam, Rajkumar on 5/29/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceImageHelper : NSObject

typedef void(^imageFetcherCompletion)(NSArray *);
typedef void(^imageFetcherFailed)(NSError *);

+(void) fetchImagesFromDevice:(imageFetcherCompletion) compblock failureBlock:(imageFetcherFailed) failureBlock;

@end
