//
//  ChooseAddViewController.m
//  Myrecipes
//
//  Created by Nicole Gertsen on 24-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "ChooseAddViewController.h"

@interface ChooseAddViewController ()

@end

@implementation ChooseAddViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
