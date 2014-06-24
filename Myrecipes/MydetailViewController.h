//
//  MydetailViewController.h
//  Myrecipes
//
//  Created by Nicole Gertsen on 23-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MydetailViewController : UIViewController <UITextViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *descriptions;
@property (weak, nonatomic) IBOutlet UITextView *ingredientstextfield;
//@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong) NSManagedObject *recipedb;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnBack:(id)sender;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end