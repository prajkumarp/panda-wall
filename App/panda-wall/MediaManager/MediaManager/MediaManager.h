//
//  MediaManager.h
//  MediaManager
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaManager : NSObject

typedef void(^myCompletion)(NSArray *);

+(void) myMethod:(myCompletion) compblock;

@end
