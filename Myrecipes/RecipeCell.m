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
    
    // Configure the view for the selected state
}

-(void)setDetailsWithRecipe: (Recipe *)recipe {
    
    dishTitle.text = recipe.name;
    dishIngredients.text = recipe.ingredients;
    
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

