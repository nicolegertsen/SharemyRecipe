//
//  RecipeCell.m
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "RecipeCell.h"

@implementation RecipeCell

@synthesize dishImageView;
@synthesize dishTitle;
@synthesize dishIngredients;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

// Set the details of the recipe cell
-(void)setDetailsWithRecipe: (Recipe *)recipe {
    
    dishTitle.text = recipe.name;
    NSMutableString *ingredientList = [[NSMutableString alloc] init];
    for (NSString *ingredient in recipe.ingredients) {
        [ingredientList appendString:ingredient];
    }
    dishIngredients.text = ingredientList;

    if (recipe.imageData) {
        
        UIImage *image = [UIImage imageWithData:recipe.imageData];
        dishImageView.image = image;
    }
    else {
        [recipe loadData];
        UIImage *image = [UIImage imageWithData:recipe.imageData];
        dishImageView.image = image;
    }
}

@end

