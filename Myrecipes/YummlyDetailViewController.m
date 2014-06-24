//
//  YummlyDetailViewController.m
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "YummlyDetailViewController.h"
#import "MyrecipesViewController.h"
#import "MydetailViewController.h"

@interface YummlyDetailViewController ()

@end

@implementation YummlyDetailViewController
@synthesize dishImage;
@synthesize dishTitle;
@synthesize dishIngredients;
@synthesize recipe;
@synthesize recipedb;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.recipedb) {
        dishImage.image = [UIImage imageWithData:recipe.imageData];
        dishTitle.text = recipe.name;
        dishIngredients.text = recipe.ingredients;
        //[self.recipedb setValue:self.recipe.name forKey:@"name"];
        NSLog(@"%@", recipe.name);
        NSLog(@"%@", recipedb);
        MydetailViewController *mdvc = [[MydetailViewController alloc] init];
        self.recipedb = mdvc.recipedb;

    }
}

-(NSManagedObjectContext *) ManagedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)btnSave:(id)sender {
    NSManagedObjectContext *context = [self ManagedObjectContext];
    //[self.recipedb addObject: self.recipe];
    if (self.recipedb) {
        [self.recipedb setValue:self.dishTitle.text forKey:@"name"];
        NSLog(@"%@", self.dishTitle.text);
        //[self.recipedb setValue:self.descriptions.text forKey:@"descriptions"];
        [self.recipedb setValue:self.dishIngredients.text forKey:@"ingredients"];
        //[self.recipedb setValue:self.dishIngredientstextfield.text forKey:@"ingredients"];
        
    }
    else {
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:context];
        [newDevice setValue:self.dishTitle.text forKey:@"name"];
        //[newDevice setValue:self.descriptions.text forKey:@"descriptions"];
        [newDevice setValue:self.dishIngredients.text forKey:@"ingredients"];
        //[newDevice setValue:self.ingredientstextfield.text forKey:@"ingredients"];
        
    }
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.dishTitle resignFirstResponder];
	//[self.descriptions resignFirstResponder];
	[self.dishIngredients resignFirstResponder];
}


- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
