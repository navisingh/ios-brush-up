//
//  ratingAppDelegate.h
//  Ratings
//
//  Created by Navi Singh on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ratingAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *players;
}

@property (strong, nonatomic) UIWindow *window;

- (void) addPlayers;

@end
