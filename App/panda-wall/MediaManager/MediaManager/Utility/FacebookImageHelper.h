//
//  FacebookImageHelper.h
//  MediaManager
//
//  Created by Rajkumar P on 6/3/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookImageHelper : NSObject

typedef void(^imageFetcherCompletion)(NSArray *);
typedef void(^imageFetcherFailed)(NSError *);

+(void) fetchImagesFromFaceBook:(imageFetcherCompletion) compblock failureBlock:(imageFetcherFailed) failureBlock;

@end
