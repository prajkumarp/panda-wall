//
//  RKPMenuViewController.m
//  panda-wall
//
//  Created by Panneerselvam, Rajkumar on 6/5/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import "RKPMenuViewController.h"

@interface RKPMenuViewController ()

@end

@implementation RKPMenuViewController

- (void) viewDidLoad{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-background"]]];
}

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue{}

@end
