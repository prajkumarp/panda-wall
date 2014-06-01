//
//  RKPSectionHeaderCell.m
//  panda-wall
//
//  Created by Rajkumar P on 6/1/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import "RKPSectionHeaderCell.h"

@implementation RKPSectionHeaderCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initialize{
    
    _sectionHeader = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 30)];
    [self addSubview:_sectionHeader];

}

@end
