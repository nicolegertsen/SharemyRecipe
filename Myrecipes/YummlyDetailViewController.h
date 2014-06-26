//
//  YummlyDetailViewController.h
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeCell.h"

@interface YummlyDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *dishImage;
@property (weak, nonatomic) IBOutlet UILabel *dishTitle;
@property (weak, nonatomic) IBOutlet UILabel *dishIngredients;
@property (nonatomic, retain) Recipe *recipe;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong) NSManagedObject *recipedb;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnBack:(id)sender;

@end
