//
//  YummlyViewController.m
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "YummlyViewController.h"

@interface YummlyViewController ()
{
    NSMutableArray *totalStrings;
    NSMutableArray *filteredStrings;
    BOOL isfiltered;
}
@end

@implementation YummlyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self yummlyAPI:@""];
    [super viewDidLoad];
    self.mySearchBar.delegate = self;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Search for word in database when 'searchbutton' is clicked
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchText = searchBar.text;
    if (searchBar.text.length > 0) {
        isfiltered = YES;
        filteredStrings = [[NSMutableArray alloc] init];
        [self yummlyAPI:searchText];
        for (Recipe *currentRecipe in totalStrings) {
            if ([currentRecipe.name isKindOfClass: [NSString class]]) {
                NSRange stringRange = [(NSString *)currentRecipe.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (stringRange.location != NSNotFound) {
                    [filteredStrings addObject:currentRecipe];
                }
            }
            
        }
        [self.mySearchBar resignFirstResponder];
        [self.myTableView reloadData];
    }
    else {
        isfiltered = NO;
        [self yummlyAPI:searchText];
        [self.mySearchBar resignFirstResponder];
        [self.myTableView reloadData];
    }
}

# pragma mark - set tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isfiltered){
        return [filteredStrings count];
    }
    return [totalStrings count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[RecipeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Recipe *recipe;
    
    if (!isfiltered){
       
        recipe = [totalStrings objectAtIndex:indexPath.row];
        
    }
    else {
        
        recipe = [filteredStrings objectAtIndex:indexPath.row];
    }
    
    [cell setDetailsWithRecipe:recipe];
    
    return cell;
    
}

// When user touches cell go to Detail View
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ViewYummlyDetail"]) {
        
        NSManagedObject *selectedDevice = [totalStrings objectAtIndex:[[self.myTableView indexPathForSelectedRow] row]];
        YummlyDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipedb = selectedDevice;
        destViewController.recipe = [totalStrings objectAtIndex:[[self.myTableView indexPathForSelectedRow] row]];
        
    }
}

// Retrieve information from Yummly API
-(void)yummlyAPI:(NSString *)searchtext
{
    NSMutableString *stringURL = [[NSMutableString alloc] initWithFormat: @"http://api.yummly.com/v1/api/recipes?_app_id=2c0c85c6&_app_key=70ef4206d17fcdc1f98b6191f0eea461&q=" ];
    [stringURL appendString:searchtext];
    NSURL *req = [NSURL URLWithString: stringURL];
    NSData *rawdata = [NSData dataWithContentsOfURL:req];
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:rawdata options:kNilOptions error:&error];
    
    NSArray *recipeArray = (NSArray *)[dictionary objectForKey:@"matches"];
    NSLog(@"%@", dictionary);
    
    totalStrings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in recipeArray){
    
        Recipe *recipe = [[Recipe alloc] init];
        recipe.name = [dic objectForKey:@"recipeName"];
        NSDictionary *imagedic = [dic objectForKey:@"imageUrlsBySize"];
        recipe.thumbNail = [imagedic objectForKey:@"90"];
        recipe.ingredients = [dic objectForKey:@"ingredients"];

        [totalStrings addObject:recipe];
    }
    
    [self.myTableView reloadData];
}

// Set backbutton
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
