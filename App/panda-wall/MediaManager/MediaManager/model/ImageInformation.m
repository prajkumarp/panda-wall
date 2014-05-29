//
//  ImageInformation.m
//  MediaManager
//
//  Created by Panneerselvam, Rajkumar on 5/29/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import "ImageInformation.h"

@implementation ImageInformation

- (NSString *)getDateandTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:_timeStamp];
    return stringFromDate;
    
    formatter = nil ;

}


@end
