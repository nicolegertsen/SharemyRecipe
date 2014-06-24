//
//  Recipe.m
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

@synthesize name;
@synthesize thumbNail;
@synthesize ingredients;
@synthesize imageData;

-(void) loadData {
    
    NSURL *url = [NSURL URLWithString:self.thumbNail];
    self.imageData = [NSData dataWithContentsOfURL:url];
}

@end
