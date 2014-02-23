//
//  TGLoginViewController.m
//  Time Grid
//
//  Created by Jerome Thomere on 8/25/13.
//  Copyright (c) 2013 Jerome Thomere. All rights reserved.
//

#import "TGLoginViewController.h"
#import "TGAppDelegate.h"

@interface TGLoginViewController ()

@end

@implementation TGLoginViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogin:(id)sender
{
    NSLog(@"TGLoginViewController performLogin sender=%@", sender);
    [self.delegate openSession];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here,
}

@end
