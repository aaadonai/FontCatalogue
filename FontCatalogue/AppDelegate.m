//
//  AppDelegate.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 12/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "AppDelegate.h"
#import "FontTableViewController.h"
#import "CoreDataManager.h"
#import "MenuOptionsManager.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.fontTableViewController = [[FontTableViewController alloc]
                                 initWithStyle:UITableViewStylePlain];
    
    self.navigationController = [[UINavigationController alloc]
                             initWithRootViewController:self.fontTableViewController];
    
    [self.window addSubview:self.navigationController.view];
    
    self.window.rootViewController = self.navigationController;
    
    //create MenuOptions document if needed
    [[MenuOptionsManager sharedManager]createDocument];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [[CoreDataManager sharedManager] saveContext];
    [[MenuOptionsManager sharedManager]writeDocument];
}

@end
