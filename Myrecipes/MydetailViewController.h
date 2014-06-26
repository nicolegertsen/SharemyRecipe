//
//  MydetailViewController.h
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MydetailViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *descriptions;
@property (weak, nonatomic) IBOutlet UITextView *ingredientstextfield;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong) NSManagedObject *recipedb;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnBack:(id)sender;

- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)takePhoto:(UIButton *)sender;

-(IBAction)textFieldReturn:(id)sender;
-(IBAction)backgroundTouched:(id)sender;

@end