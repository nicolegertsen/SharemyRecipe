//
//  RecipeCell.h
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishTitle;
@property (weak, nonatomic) IBOutlet UILabel *dishIngredients;

-(void)setDetailsWithRecipe: (Recipe *)recipe;

@end
