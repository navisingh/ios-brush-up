//
//  wazaapAppDelegate.m
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//List of icons thtat need to be added to app.
//http://developer.apple.com/library/ios/#documentation/userexperience/conceptual/mobilehig/IconsImages/IconsImages.html

#import "wazaapAppDelegate.h"
#import "wazaapEntity.h"
#import "WazaapTableViewController.h"

@implementation wazaapAppDelegate

@synthesize window = _window;

NSMutableArray *entities;

void onUncaughtException(NSException *exception)
{
    NSLog(@"uncaught exception at: %@", exception.description);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	NSSetUncaughtExceptionHandler(&onUncaughtException);
    
    entities = [NSMutableArray arrayWithCapacity:10];
    
    {
        WazaapEntity *we = [[WazaapEntity alloc] init];
        we.name = @"Events";
        we.detail = @"Whats happening around here?";
        [entities addObject:we];
    }
    
    {
        WazaapEntity *we = [[WazaapEntity alloc] init];
        we.name = @"Venues";
        we.detail = @"Where do I go around here?";
        [entities addObject:we];
    }
    
    {
        WazaapEntity *we = [[WazaapEntity alloc] init];
        we.name = @"Friends";
        we.detail = @"Who do I know around here?";
        [entities addObject:we];
    }
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
	UINavigationController *navigationController = [[tabBarController viewControllers] objectAtIndex:0];
    
	WazaapTableViewController *wazaapVC= [[navigationController viewControllers] objectAtIndex:0];
	wazaapVC.entities = entities;
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
