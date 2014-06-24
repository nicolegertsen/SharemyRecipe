//
//  Recipe.h
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *thumbNail;
@property (nonatomic, copy) NSString *ingredients;
@property (nonatomic, retain) NSData *imageData;


-(void) loadData;

@end
