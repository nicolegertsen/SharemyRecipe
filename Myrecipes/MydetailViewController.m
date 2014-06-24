//
//  MydetailViewController.m
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "MydetailViewController.h"
#import "MyrecipesViewController.h"

@interface MydetailViewController ()

@end

@implementation MydetailViewController
@synthesize recipedb;
@synthesize scrollview;

- (void)viewDidLoad
{
    scrollview.frame = CGRectMake(0, 0, 320, 460);
    self.ingredientstextfield.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.recipedb) {
        [self.name setText:[self.recipedb valueForKey:@"name"]];
        [self.descriptions setText:[self.recipedb valueForKey:@"descriptions"]];
        //[self.ingredients setText:[self.recipedb valueForKey:@"ingredients"]];
        [self.ingredientstextfield setText:[self.recipedb valueForKey:@"ingredients"]];
        //[self.image setView:[self.recipedb valueForKey:@"image"]];
        
    }
}

-(BOOL)textViewDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = -100;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    return YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.name resignFirstResponder];
}

-(NSManagedObjectContext *) ManagedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
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

- (IBAction)btnSave:(id)sender {
    NSManagedObjectContext *context = [self ManagedObjectContext];
    
    
    if (self.recipedb) {
        [self.recipedb setValue:self.name.text forKey:@"name"];
        [self.recipedb setValue:self.descriptions.text forKey:@"descriptions"];
        //[self.recipedb setValue:self.ingredients.text forKey:@"ingredients"];
        [self.recipedb setValue:self.ingredientstextfield.text forKey:@"ingredients"];
    }
    else {
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:context];
        [newDevice setValue:self.name.text forKey:@"name"];
        [newDevice setValue:self.descriptions.text forKey:@"descriptions"];
        //[newDevice setValue:self.ingredients.text forKey:@"ingredients"];
        [newDevice setValue:self.ingredientstextfield.text forKey:@"ingredients"];

    }
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyrecipesViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Myrecipes"];
    [vc setModalPresentationStyle:UIModalPresentationNone];
    [self presentViewController:vc animated:YES completion:nil];
     */
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.name resignFirstResponder];
	[self.descriptions resignFirstResponder];
	[self.ingredientstextfield resignFirstResponder];
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
