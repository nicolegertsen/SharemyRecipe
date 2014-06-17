//
//  MainViewController.h
//  SharmyRecipe
//
//  Created by Nicole Gertsen on 17-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "FlipsideViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
