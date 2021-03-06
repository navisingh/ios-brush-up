//
//  VerticalSwipeArticlesAppDelegate.m
//  VerticalSwipeArticles
//
//  Created by Peter Boctor on 12/26/10.
//
// Copyright (c) 2011 Peter Boctor
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "VerticalSwipeArticlesAppDelegate.h"
#import "RootViewController.h"

#define TOP_APPS_URL @"http://itunes.apple.com/us/rss/toppaidapplications/limit=25/json"

#define WAZAAP_URL @"http://sf.wazaap.in/wp-content/plugins/wz_reloaded/action.php?action=search&category=deals,nightlife,nightlife-clubbing,nightlife-eatingdrinking,nightlife-others,nightlife-comedy,nightlife-music,nightlife-dance,nightlife-movies,offbeat,offbeat-films,offbeat-music,offbeat-other,offbeat-performingarts,offbeat-visualarts,offbeat-literature,challenges,challenges-volunteering,challenges-sportsrecreation,challenges-others,challenges-networking,challenges-hobbies,challenges-classes,challenges-lecturesworkshops,others,others-artscrafts,others-festivals,others-others,others-social,others-sports,others-tours,deals,nightlife,offbeat,challenges"
/*
 #define WAZAAP_URL @"http://sf.wazaap.in/wp-content/plugins/wz_reloaded/action.php?action=search&category=deals,nightlife,nightlife-clubbing,nightlife-eatingdrinking,nightlife-others,nightlife-comedy,nightlife-music,nightlife-dance,nightlife-movies,offbeat,offbeat-films,offbeat-music,offbeat-other,offbeat-performingarts,offbeat-visualarts,offbeat-literature,challenges,challenges-volunteering,challenges-sportsrecreation,challenges-others,challenges-networking,challenges-hobbies,challenges-classes,challenges-lecturesworkshops,others,others-artscrafts,others-festivals,others-others,others-social,others-sports,others-tours,deals,nightlife,offbeat,challenges,others&sort_by=chronological&sort_order=asc&items_per_page=15&page=2&start_before=23"
 */
@implementation VerticalSwipeArticlesAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize loadingView, topAppsData, topAppsData2;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    navigationController.delegate = self;
    
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:WAZAAP_URL]];
    
    NSURLConnection* topAppsConnection2 = [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
    if (topAppsConnection2)
        self.topAppsData2 = [NSMutableData data];
    
    
    RootViewController* rvc = (RootViewController*)[navigationController.viewControllers objectAtIndex:0];
//    self.window.rootViewController = rvc;
    
    [self.window addSubview:loadingView];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController respondsToSelector:@selector(willAppearIn:)])
        [viewController performSelector:@selector(willAppearIn:) withObject:navController];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void) cancel:(NSURLConnection *)connection
{
    [connection cancel];
    self.topAppsData = nil;
}

#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSInteger status = [(NSHTTPURLResponse*)response statusCode];
    
    if (status != 200)
        [self cancel:connection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self cancel:connection];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
        [topAppsData2 appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    RootViewController* rootViewController = (RootViewController*)[navigationController.viewControllers objectAtIndex:0];
    
    NSString* topAppsString = [[NSString alloc] initWithData:topAppsData2 encoding:NSUTF8StringEncoding]; 
    
    @try {
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:topAppsData2 options:kNilOptions error:&error];
        rootViewController.topApps = [json objectForKey:@"events"];
        
        //           rootViewController.topApps = [[topAppsString JSONValue] objectForKey:@"events"];
        
        [self.window addSubview:navigationController.view];
    }
    @catch (NSException * e) {
    }
    
    self.topAppsData2 = nil;
}



@end

