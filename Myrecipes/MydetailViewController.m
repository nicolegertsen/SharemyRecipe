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
@synthesize name;
@synthesize descriptions;
@synthesize ingredientstextfield;
@synthesize imageView;

- (void)viewDidLoad
{
    scrollview.frame = CGRectMake(0, 0, 320, 460);
    [super viewDidLoad];
    name.delegate = self;
    descriptions.delegate = self;
    ingredientstextfield.delegate = self;
    [self setReturnKey];
    
    if (self.recipedb) {
        [self setContentDetail];
    }
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self alertWithTitle:@"Error" message:@"Device has no camera" delegate:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Set the content of the Detail View
-(void)setContentDetail {
    
    [self.name setText:[self.recipedb valueForKey:@"name"]];
    [self.descriptions setText:[self.recipedb valueForKey:@"descriptions"]];
    [self.ingredientstextfield setText:[self.recipedb valueForKey:@"ingredients"]];
    UIImage *image = [self dataToImage:[self.recipedb valueForKey:@"image"]];
    [self.imageView setImage:image];
}

// Set action for 'Take Photo' button
- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// Set action for 'Select Photo' button
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// Set select option for chosen image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

// Set cancel option for image
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

# pragma mark set options for keyboard

// Set the ReturnKey of keyboard
-(void)setReturnKey{
    
    [self.name setReturnKeyType:UIReturnKeyDone];
    [self.descriptions setReturnKeyType:UIReturnKeyDone];
    [self.ingredientstextfield setReturnKeyType:UIReturnKeyGo];
    
}

-(IBAction)textFieldReturn:(id)sender {
    
    [sender resignFirstResponder];
}

-(IBAction)backgroundTouched:(id)sender {
    
    [name resignFirstResponder];
    [descriptions resignFirstResponder];
    [ingredientstextfield resignFirstResponder];
}

-(NSManagedObjectContext *) ManagedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//  Set values for recipe
-(void)setValueAfterSave {
    
    [self.recipedb setValue:self.name.text forKey:@"name"];
    [self.recipedb setValue:self.ingredientstextfield.text forKey:@"ingredients"];
    [self.recipedb setValue:[self convertImageToData] forKey:@"image"];
    
}

-(void)setValueAfterNewDeviceSave{
    
    NSManagedObjectContext *context = [self ManagedObjectContext];
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:context];
    [newDevice setValue:self.name.text forKey:@"name"];
    [newDevice setValue:self.ingredientstextfield.text forKey:@"ingredients"];
    [newDevice setValue:[self convertImageToData] forKey:@"image"];
}

// Convert the data of the image back to orignal data
-(UIImage *)dataToImage:(NSData *)pictureData{
    
    UIImage * originalImage = [UIImage imageWithData:pictureData];
    return originalImage;
}

// Convert the image to Data (for .xcdatamodeld)
-(NSData *)convertImageToData{
   
    UIImage *image = self.imageView.image;
    CGFloat compression = 0.9f;
    NSData* pictureData = UIImageJPEGRepresentation(image, compression);
    return pictureData;
    
}

// Set actions for buttons
- (IBAction)btnSave:(id)sender {
    NSManagedObjectContext *context = [self ManagedObjectContext];
    if (self.recipedb) {
        [self setValueAfterSave];
    }
    else {
        [self setValueAfterNewDeviceSave];
    }
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.name resignFirstResponder];
	[self.descriptions resignFirstResponder];
	[self.ingredientstextfield resignFirstResponder];
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
