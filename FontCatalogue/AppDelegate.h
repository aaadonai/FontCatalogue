//
//  AppDelegate.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 12/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FontTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, retain) FontTableViewController *fontTableViewController;

@end
