//
//  MyrecipesViewController.m
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "MyrecipesViewController.h"
#import "MydetailViewController.h"
#import "YummlyViewController.h"
#import "YummlyDetailViewController.h"

@interface MyrecipesViewController ()

@end

@implementation MyrecipesViewController
@synthesize recipearray;

-(NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
         return context;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationItem];
}

// Custom the Navigation Item
-(void)setNavigationItem {
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Chalkduster" size:24.0f];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = @"My Recipes";
    self.navigationItem.titleView = label;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logokleiner.png"]];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:image];
    self.navigationItem.leftBarButtonItem = backBarButton;
}

-(void)viewDidAppear:(BOOL)animated {
 
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Recipes"];
    self.recipearray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Transform the data of the image back to original image
-(UIImage *)dataToImage:(NSData *)pictureData{
    
    UIImage * originalImage = [UIImage imageWithData:pictureData];
    return originalImage;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.recipearray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
    [self configureTheCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

// Configure the tableviewcell
-(void)configureTheCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *device = [self.recipearray objectAtIndex:indexPath.row];
    UIImage *image = [self dataToImage:[device valueForKey:@"image"]];
    
    UIGraphicsBeginImageContext(CGSizeMake(92,73));
    [image drawInRect:CGRectMake(1, 1, 92, 73)]; //
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kleinererodepeper.png"]]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 2;
    [cell.textLabel setFont:[UIFont fontWithName:@"Chalkduster" size:14.0f]];
    [cell.imageView setImage:newThumbnail];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"name"]]];
    [cell.detailTextLabel setText:@""];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.recipearray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self.recipearray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
         }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if ([[segue identifier] isEqualToString:@"UpdateRecipe"]) {
        NSManagedObject *selectedDevice = [self.recipearray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        MydetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipedb = selectedDevice;
    }
}

// Alert
- (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
    // show alert view
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
