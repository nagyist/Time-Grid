//
//  TGLoginViewController.h
//  Time Grid
//
//  Created by Jerome Thomere on 8/25/13.
//  Copyright (c) 2013 Jerome Thomere. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TGLoginViewDelegate;

@interface TGLoginViewController : UIViewController

@property (weak, nonatomic)  NSObject<TGLoginViewDelegate> *delegate;

- (IBAction)performLogin:(id)sender;
- (void)loginFailed;

@end

@protocol TGLoginViewDelegate <NSObject>

- (void) openSession;

@end