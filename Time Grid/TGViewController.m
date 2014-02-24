//
//  TGViewController.m
//  Time Grid
//
//  Created by Jerome Thomere on 8/24/13.
//  Copyright (c) 2013 Jerome Thomere. All rights reserved.
//

#import "TGViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TGLoginViewController.h"

@interface TGViewController ()
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet FBLoginView *fbLoginView;

@end

@implementation TGViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    NSLog(@"TGViewController viewDidLoad FBSession.activeSession.state=%d", FBSession.activeSession.state);
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        NSLog(@"FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded run openSession");
        [self openSession];
    } else {
        // No, display the login page.
        [self showLoginView];
    }
}

- (void)showLoginView
{
    UIViewController *topViewController = [self.navigationController topViewController];
    UIViewController *modalViewController = [topViewController presentedViewController];
    NSLog(@"TGViewController showLoginView topViewController=%@ modalViewController=%@", topViewController, modalViewController);

    // If the login screen is not already displayed, display it. If the login screen is
    // displayed, then getting back here means the login in progress did not successfully
    // complete. In that case, notify the login view so it can update its UI appropriately.
    if (![modalViewController isKindOfClass:[TGLoginViewController class]]) {
        TGLoginViewController* loginViewController = [[TGLoginViewController alloc]
                                                      initWithNibName:@"TGLoginViewController"
                                                      bundle:nil];
        loginViewController.delegate = self;
        [topViewController presentViewController:loginViewController animated:NO completion:nil];
    } else {
        TGLoginViewController* loginViewController = (TGLoginViewController*)modalViewController;
        [loginViewController loginFailed];
    }
}

- (void)openSession
{
    NSLog(@"TGViewController openSession");
    [FBSession openActiveSessionWithReadPermissions:@[@"read_stream"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    NSLog(@"TGViewController sessionStateChanged state=%d", state);
    switch (state) {
        case FBSessionStateOpen: {
            UIViewController *topViewController = [self.navigationController topViewController];
            NSLog(@"TGViewController topViewController %@", topViewController);
            if ([[topViewController presentedViewController]
                 isKindOfClass:[TGLoginViewController class]]) {
                [topViewController dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case FBSessionStateClosed:

        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navigationController popToRootViewControllerAnimated:NO];

            [FBSession.activeSession closeAndClearTokenInformation];

            [self showLoginView];
            break;
        default:
            break;
    }

    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (!error) {
            // Success! Include your code to handle the results here
            self.userNameLabel.text = user.name;
            self.profileView.profileID = [user objectForKey:@"id"];
            self.profileView.pictureCropping = FBProfilePictureCroppingSquare;
        } else {
            // An error occurred, we need to handle the error
            // See: https://developers.facebook.com/docs/ios/errors
        }
    }];
}


- (IBAction)fbLogout:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}

@end
