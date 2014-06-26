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
@synthesize scrollview;

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
        [self setDetailsOfView];
        MydetailViewController *mdvc = [[MydetailViewController alloc] init];
        self.recipedb = mdvc.recipedb;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Set details of Yummly recipe
-(void)setDetailsOfView
{
    dishImage.image = [UIImage imageWithData:recipe.imageData];
    dishTitle.text = recipe.name;
    scrollview.frame = CGRectMake(25.0f, 168.0f, 270.0f, 127.0f);
    int i = 0;
    NSMutableString *ingredientList = [[NSMutableString alloc] init];
    for (NSString *ingredient in recipe.ingredients) {
        i++;
        NSString *myString = [NSString stringWithFormat:@"%@, ",ingredient];
        [ingredientList appendString:myString];
    }
    dishIngredients.text = ingredientList;
    dishIngredients.contentScaleFactor = (25.0f, 168.0f, 270.0f, 127.0f);
    dishIngredients.lineBreakMode = UILineBreakModeWordWrap;
    dishIngredients.numberOfLines = 0;
    [dishIngredients sizeToFit];
    //[self.view addSubview:dishIngredients];
    scrollview.contentSize = CGSizeMake(scrollview.contentSize.width, dishIngredients.frame.size.height);
    [scrollview addSubview:dishIngredients];
    [self.view addSubview:scrollview];
}

-(NSManagedObjectContext *) ManagedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

// Set values for recipe
-(void)setValueAfterSafe {
    
    [self.recipedb setValue:self.dishTitle.text forKey:@"name"];
    [self.recipedb setValue:self.dishIngredients.text forKey:@"ingredients"];
    [self.recipedb setValue:[self convertImageToData] forKey:@"image"];
}

-(void)setValueAfterNewDeviceSafe{
    
    NSManagedObjectContext *context = [self ManagedObjectContext];
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:context];
    [newDevice setValue:self.dishTitle.text forKey:@"name"];
    [newDevice setValue:self.dishIngredients.text forKey:@"ingredients"];
    [newDevice setValue:[self convertImageToData] forKey:@"image"];
}

// Convert image to data
-(NSData *)convertImageToData{
    
    UIImage *image = self.dishImage.image;
    CGFloat compression = 0.9f;
    NSData* pictureData = UIImageJPEGRepresentation(image, compression);
    return pictureData;
    
}

// Set buttons
- (IBAction)btnSave:(id)sender {
    NSManagedObjectContext *context = [self ManagedObjectContext];
    if (self.recipedb) {
        [self setValueAfterSafe];
    }
    else {
        [self setValueAfterNewDeviceSafe];
        
    }
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.dishTitle resignFirstResponder];
	[self.dishIngredients resignFirstResponder];
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
