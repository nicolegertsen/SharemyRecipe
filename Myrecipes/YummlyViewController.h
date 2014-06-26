//
//  YummlyViewController.h
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "RecipeCell.h"
#import "YummlyDetailViewController.h"

@interface YummlyViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


-(void)yummlyAPI:(NSString *)searchText;
- (IBAction)btnBack:(id)sender;

@end
