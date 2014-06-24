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
    [self yummlyAPI];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mySearchBar.delegate = self;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0){
        isfiltered = NO;
    }
    else {
        isfiltered = YES;
        filteredStrings = [[NSMutableArray alloc] init];
        
        //for (NSString *str in totalStrings){
        for (id str in totalStrings) {
            if ([str isKindOfClass: [NSString class]]) {
                NSRange stringRange = [(NSString *)str rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (stringRange.location != NSNotFound) {
                    [filteredStrings addObject:str];
                }
            }
        }
        /*
         for (NSDictionary *item in totalStrings) {
         NSString *str = [item objectForKey:@"recipeName"];
         NSRange stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
         
         if (stringRange.location != NSNotFound) {
         [filteredStrings addObject:str];
         }
         
         }
         
         for (NSDictionary *theDictionary in totalStrings) {
         
         for (NSString *key in theDictionary) {
         NSString *value = [theDictionary objectForKey:key];
         NSRange stringRange = [value rangeOfString:searchText options:NSCaseInsensitiveSearch];
         
         if (stringRange.location != NSNotFound) {
         [filteredStrings addObject:value];
         }
         }
         }*/
    }
    [self.myTableView reloadData];
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.mySearchBar resignFirstResponder];
}

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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ViewYummlyDetail"]) {
        
        NSManagedObject *selectedDevice = [totalStrings objectAtIndex:[[self.myTableView indexPathForSelectedRow] row]];
        YummlyDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipedb = selectedDevice;
        destViewController.recipe = [totalStrings objectAtIndex:[[self.myTableView indexPathForSelectedRow] row]];
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[RecipeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    /*if (!isfiltered) {
     cell.textLabel.text = [totalStrings objectAtIndex:indexPath.row];
     }
     else {
     cell.textLabel.text = [filteredStrings objectAtIndex:indexPath.row];
     }
     
     //Recipe *recipe = [totalStrings objectAtIndex:indexPath.row];
     */
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(IBAction)switchtheswitch:(id)sender {
    if (theswitch.on) {
        label.text = @"Type in a recipe";
    }
    else {
        label.text = @"Type in an ingredient";
    }
}
 */

-(void)yummlyAPI {
    
    NSURL *req = [NSURL URLWithString: @"http://api.yummly.com/v1/api/recipes?_app_id=2c0c85c6&_app_key=70ef4206d17fcdc1f98b6191f0eea461"];
    NSData *rawdata = [NSData dataWithContentsOfURL:req];
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:rawdata options:kNilOptions error:&error];
    
    NSArray *recipeArray = (NSArray *)[dictionary objectForKey:@"matches"];
    
    totalStrings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in recipeArray)
    {
        Recipe *recipe = [[Recipe alloc] init];
        recipe.name = [dic objectForKey:@"recipeName"];
        recipe.thumbNail = [[dic objectForKey:@"smallImageUrls"] objectAtIndex:0];
        recipe.ingredients = [[dic objectForKey:@"ingredients"] objectAtIndex:0];
        
        [totalStrings addObject:recipe];
    }
    
    [self.myTableView reloadData];
    NSLog(@"%@", totalStrings);
    
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
