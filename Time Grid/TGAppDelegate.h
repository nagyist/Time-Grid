//
//  TGAppDelegate.h
//  Time Grid
//
//  Created by Jerome Thomere on 8/24/13.
//  Copyright (c) 2013 Jerome Thomere. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGViewController;

@interface TGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TGViewController *mainViewController;

@end
